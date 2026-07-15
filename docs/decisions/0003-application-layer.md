# ADR 0003: Application Layer — DI Wiring (Riverpod)

- **Status**: Accepted & Implemented
- **Date**: 2026-07-15
- **Owner**: dpcivl (design human-approved 2026-07-15)
- **Spec refs**: `contract.Architecture` (Riverpod + 3-layer domain/data/application/presentation), `impl.domain`, `impl.data`, `impl.application`, `review.application`

> IMPLEMENTED. `flutter_riverpod ^2.6.1` added; `lib/application/providers.dart`
> and `ProviderScope` wrap in `lib/main.dart` built; `test/application/providers_test.dart`
> added. `flutter analyze` clean, `flutter test` green (18 = 16 data/widget + 2 app).
> Domain/data layers unchanged.
>
> **agent-B review: APPROVE** — no blocking/non-blocking findings. Confirmed:
> DB provider lifetime correct (app-lifetime singleton, `onDispose(db.close)`
> fires exactly once at root-scope disposal, not `autoDispose`); repository
> providers typed as domain interfaces sharing one `AppDatabase`; the override
> test is a genuine write/read-back propagation proof (not just `isA`), and its
> manual `db.close()` tearDown is necessary (because `overrideWithValue` bypasses
> the provider's `onDispose`) and ordered safely (LIFO: container disposed before
> the connection closes). One optional nit noted (test db built before the
> container → harmless leak only if the ctor ever throws); left as-is.
>
> **`/code-review` (high) follow-up:** no blocking bugs; 3 LOW observations.
> #1 APPLIED — `test/widget_test.dart` now wraps `MyApp` in `ProviderScope` to
> mirror `main()`'s boot path. #2 (`onDispose(db.close)` fire-and-forget) and
> #3 (unguarded provider read in pure-VM context) accepted as documented
> trade-offs.

> SCOPE OF THIS INCREMENT = **dependency-injection wiring only.** It binds the
> already-built data-layer implementations to the domain interfaces through
> Riverpod providers, and installs a `ProviderScope` at the app root. **State
> controllers/notifiers (오늘/이번달 lists, focus timer) are a SEPARATE later
> increment** and are deliberately NOT built here (agent A rule: only code for
> the requested feature, no over-engineering).

## Feature

The domain (`lib/domain/`) and data (`lib/data/`) layers exist but nothing wires
them together — there is no way for a future presentation layer to obtain a
`TodoRepository` / `FocusRepository` without hand-constructing an `AppDatabase`.
This increment adds the Riverpod DI seam: a single app-lifetime `AppDatabase`
and repository providers typed as the **domain interfaces**, so higher layers
depend only on domain abstractions and tests can swap the database.

## 1. Dependencies

- Add `flutter_riverpod` (runtime). No codegen target added in this increment.
- Version pinned at implementation time (`flutter pub add flutter_riverpod`).

## 2. Chosen approach — plain providers, interface-typed

New file `lib/application/providers.dart`:

```dart
// App-lifetime SQLite database. Constructed once, closed when the root scope
// is torn down (app exit). NOT autoDispose — it must outlive individual screens.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

// Repositories are exposed as the DOMAIN interface types, so the presentation
// layer never sees *Impl or Drift. Swapping persistence = swap these two lines.
final todoRepositoryProvider = Provider<TodoRepository>(
  (ref) => TodoRepositoryImpl(ref.watch(appDatabaseProvider)),
);

final focusRepositoryProvider = Provider<FocusRepository>(
  (ref) => FocusRepositoryImpl(ref.watch(appDatabaseProvider)),
);
```

`main.dart` wraps the app in a `ProviderScope`:

```dart
void main() => runApp(const ProviderScope(child: MyApp()));
```

### Why these choices

- **DI *via* Riverpod, not a second framework.** `contract.Architecture` already
  fixes Riverpod; the repository providers ARE the DI container. No get_it.
- **Return type = domain interface** (`Provider<TodoRepository>`, not
  `Provider<TodoRepositoryImpl>`). Enforces the dependency-inversion boundary:
  presentation/controllers compile against domain only.
- **`appDatabaseProvider` is a plain (non-autoDispose) `Provider`** with an
  `onDispose(db.close)`. The DB is a process-wide singleton; auto-disposing it
  when the last screen stops listening would close SQLite mid-use. It lives for
  the app's lifetime and closes exactly once when the root scope is disposed.
- **Test seam:** tests override `appDatabaseProvider` with an in-memory
  `AppDatabase.forTesting(NativeDatabase.memory())` via
  `ProviderScope(overrides: [...])`; the repository providers then resolve
  against the test DB with zero production-code changes. A smoke test asserts
  the container resolves both repositories and that an override reaches them.

## 3. Rejected alternatives

- **`riverpod_generator` codegen** — gives compile-checked providers + typed
  args, but adds a second `build_runner` target and annotation boilerplate for
  three trivial providers. Deferred; revisit when controllers with parameters
  (e.g. `todosForDay(date)`) arrive and codegen pays for itself.
- **`get_it` / `injectable` service locator** — a parallel DI mechanism next to
  Riverpod; redundant and splits the wiring story. Rejected.
- **Construct `AppDatabase` in `main()` and pass it down / inherited widget** —
  loses the override-based test seam and re-introduces manual plumbing Riverpod
  exists to remove. Rejected.
- **`autoDispose` on the DB provider** — would close the DB when transiently
  unobserved; wrong lifetime for a singleton connection. Rejected.
- **Building state controllers now** — out of scope for a DI increment; would be
  speculative before any screen consumes them. Deferred to the next increment.

## 4. Acceptance

- `flutter pub get` resolves; `flutter analyze` clean.
- `flutter test` green, including a new
  `test/application/providers_test.dart` that (1) reads both repository
  providers from a container and gets non-null domain-typed instances, and
  (2) verifies an `appDatabaseProvider` override propagates to the repositories.
- No change to `lib/domain/**` or `lib/data/**`.

## 5. Handoff (next increment, not this one)

State controllers in `lib/application/`: a `todosForDay` / `todosForMonth`
`StreamProvider` (or `Notifier`) over `watchTodosForDay/Month`, and a focus
session controller that owns the wall-clock timer and calls
`start/updateSessionAccounting/endSession`. Presentation layer consumes those.
