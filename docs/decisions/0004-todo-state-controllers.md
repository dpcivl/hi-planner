# ADR 0004: Application Layer — Todo State Controllers

- **Status**: Accepted & Implemented
- **Date**: 2026-07-15
- **Owner**: dpcivl (design human-approved 2026-07-15)
- **Spec refs**: `contract.Architecture`, `contract.Todo`, `impl.data` (reactive `watch*` streams), ADR 0003 (DI providers), `impl.todo_controllers`, `review.todo_controllers`

> IMPLEMENTED. `lib/application/todo_controllers.dart` + `test/application/todo_controllers_test.dart`.
> `flutter analyze` clean, `flutter test` green (22). Domain/data unchanged.
> **Review (agent-B + /code-review): APPROVE**, no blocking bugs. #1 (reactivity
> test strengthened to a single live subscription proving re-emission) APPLIED;
> #2 (toggleDone collapses non-done→done / un-done→pending) and #3 (`update()`
> doesn't auto-bump `updatedAt`) accepted as documented trade-offs.

> SCOPE (proposed) = the **Todo** state surface the 오늘/이번달 views need:
> reactive READ providers + a thin mutation controller. **The focus-session
> controller (wall-clock timer, pause/resume, accounting) is deliberately a
> SEPARATE next increment** — it carries timer/concurrency risk and deserves its
> own design + review rather than being bundled here.

## Feature

The DI seam (ADR 0003) exposes `TodoRepository`. The presentation layer needs
(a) reactive lists for 오늘/이번달 that update automatically when the DB changes,
and (b) a way to create/update/delete/complete a todo. This increment adds those
as Riverpod providers over the repository's existing `watch*` streams and
mutation methods — no new persistence, no new domain logic beyond composing
existing entity operations.

## Proposed approach

New file `lib/application/todo_controllers.dart`:

### Reactive reads — `StreamProvider.family`

```dart
// date = 'YYYY-MM-DD'; auto-updates via Drift .watch when todos change.
final todosForDayProvider = StreamProvider.family<List<Todo>, String>(
  (ref, date) => ref.watch(todoRepositoryProvider).watchTodosForDay(date),
);

// month = 'YYYY-MM'.
final todosForMonthProvider = StreamProvider.family<List<Todo>, String>(
  (ref, month) => ref.watch(todoRepositoryProvider).watchTodosForMonth(month),
);
```

The UI consumes `AsyncValue<List<Todo>>` (loading/data/error handled by Riverpod).
`.family` keys the stream by date/month so each view scope has its own stream.

### Mutations — a thin controller

```dart
final todoActionsProvider = Provider<TodoActions>(
  (ref) => TodoActions(ref.watch(todoRepositoryProvider)),
);

class TodoActions {
  TodoActions(this._repo);
  final TodoRepository _repo;

  Future<void> add(Todo todo) => _repo.createTodo(todo);
  Future<void> update(Todo todo) => _repo.updateTodo(todo);
  Future<void> remove(String id) => _repo.deleteTodo(id);

  /// Toggle completion: sets status + completedAt consistently, bumps updatedAt.
  Future<void> toggleDone(Todo todo, {required DateTime now}) {
    final done = todo.status == TodoStatus.done;
    return _repo.updateTodo(todo.copyWith(
      status: done ? TodoStatus.pending : TodoStatus.done,
      completedAt: done ? null : now,   // sentinel copyWith clears when un-doing
      updatedAt: now,
    ));
  }
}
```

Mutations just call the repo; the `StreamProvider`s refresh reactively (Drift
`.watch` emits), so there is **no manual list state to keep in sync** — the DB is
the single source of truth.

### Why these choices

- **`StreamProvider.family` over the repo's `watch*`** — the reactive stream
  already exists; wrapping it is the whole job. No `Notifier` holding a mutable
  list (that would duplicate DB state and risk drift). Read stays derived.
- **`now` is injected into `toggleDone`** (not `DateTime.now()` inside) — keeps
  the controller deterministic and testable; the caller/UI supplies the clock.
- **Mutations as a plain `Provider<TodoActions>`, not a `Notifier`** — there is
  no controller-owned state to manage (the list lives in the stream), so a
  stateful notifier would be ceremony. Methods return `Future<void>`; the UI
  awaits and shows its own progress/errors.

## Rejected alternatives

- **`Notifier<List<Todo>>` that loads + holds the list** — duplicates the DB as
  in-memory state, needs manual refresh after each mutation, and can drift from
  the source of truth. The `.watch` stream makes it unnecessary. Rejected.
- **Bundling the focus-session controller here** — timer lifecycle, pause/resume
  accounting, and end-reason transitions are non-trivial and concurrency-prone;
  mixing them into a todo-CRUD increment would bloat the review. Deferred to its
  own ADR.
- **Putting `toggleDone` logic in the widget** — leaks domain rules (status↔
  completedAt invariant) into presentation. Kept in the controller. Rejected.
- **`riverpod_generator` codegen** — still deferred (ADR 0003); revisit if the
  family keys or controllers grow.

## Acceptance

- `flutter analyze` clean; `flutter test` green.
- New `test/application/todo_controllers_test.dart`:
  - `todosForDayProvider`/`todosForMonthProvider` emit initial + updated lists
    when todos are created/deleted (via an in-memory DB override), proving
    reactivity end-to-end.
  - `TodoActions.toggleDone` sets status=done + completedAt=now, and un-toggles
    back to pending + completedAt=null; `add`/`remove` round-trip.
- No change to `lib/domain/**` or `lib/data/**`.

## Handoff (next increment, not this one)

`FocusSessionController` in `lib/application/`: owns the wall-clock `Timer`,
start/pause/resume/stop, periodic `updateSessionAccounting` ticks (duration vs
paused), and `endSession(endReason)` — with its own ADR covering the timer/
concurrency model. Presentation (오늘/이번달 views, focus screen) consumes both.
