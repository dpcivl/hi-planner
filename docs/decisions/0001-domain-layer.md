# ADR 0001: Domain Layer

- **Status**: Accepted
- **Date**: 2026-07-15
- **Owner**: dpcivl
- **Spec refs**: `contract.Todo`, `contract.FocusSession` (v2), `contract.FocusPolicy`, `contract.Architecture`, `contract.Storage`

## Feature

The domain layer for hi-planner: entities, enums, and abstract repository
interfaces. Pure Dart — the innermost layer that everything else depends on.

## What was built

Under `lib/domain/`:

| File | Purpose |
| --- | --- |
| `enums/todo_status.dart` | `TodoStatus` (pending/inProgress/done/canceled) + `wireValue`/`fromWire`. |
| `enums/priority.dart` | `Priority` none(0)/low(1)/medium(2)/high(3), int `level` + `fromLevel`. |
| `enums/focus_end_reason.dart` | `FocusEndReason` (completed/interrupted/abandoned/autoStopped) + `wireValue`/`fromWire`. |
| `entities/todo.dart` | Immutable `Todo` mirroring `contract.Todo`; sentinel `copyWith`; invariant asserts; unmodifiable `tags`. |
| `entities/focus_session.dart` | Immutable `FocusSession` (v2, incl. nullable `plannedSeconds`); `isRunning` getter; sentinel `copyWith`. |
| `entities/focus_policy.dart` | `FocusPolicy` value object (25-min prefill suggestion, not enforced); `defaults` const. |
| `repositories/todo_repository.dart` | Abstract `TodoRepository`: create/update/delete/getById + get/watch today + get/watch month. |
| `repositories/focus_repository.dart` | Abstract `FocusRepository`: getFocusPolicy + session lifecycle (start/updateAccounting/end) + get/watch by todo/day. |

## Approach chosen & why

- **Pure Dart, no Flutter/persistence imports** — per `contract.Architecture`,
  domain is the inward-pointing core. Only added dependency is `equatable`
  (pure Dart).
- **Immutable entities mirroring the board contracts exactly** — field names,
  types, nullability, and enums match the contracts so DTO/mapping in `data/`
  is mechanical.
- **Sentinel-based `copyWith`** (`Todo`, `FocusSession`) — a private
  `_undefined` sentinel lets callers distinguish "omit this field" from
  "explicitly set it to null" for nullable fields (`notes`, `completedAt`,
  `startAt`, `endAt`, `plannedSeconds`), which a plain `value ?? this.value`
  cannot express.
- **Repository interfaces as the data-layer boundary** — presentation/
  application depend only on these abstractions; the concrete storage engine
  (Drift/SQLite per `contract.Storage`) lives entirely behind the impls in
  `data/`. Streams (`watch*`) power the reactive 오늘/이번달 views; `Future`
  for one-shot reads/writes.

## Alternatives considered & rejected

- **Value equality** — `equatable` **(CHOSEN)**: minimal, pure Dart, no
  codegen; entities list all fields in `props`.
  - `freezed` — rejected for now: heavier codegen/build_runner overhead than an
    MVP domain layer needs. Deferred; may revisit if boilerplate grows.
  - Hand-rolled `==`/`hashCode` — rejected: error-prone and easy to drift out
    of sync as fields change.
- **`FocusSession` shape** — kept as a **top-level record** (FK `todoId` to
  Todo), not embedded inside `Todo`. It is the source of truth for focus
  analytics (planned-vs-actual adherence, interruption rate), which requires
  independent, query-able rows per `contract.Storage`.

## Trade-offs / notes

- `Todo` **lost its `const` constructor**: `tags` is defensively copied via
  `List.unmodifiable(tags)`, which runs at runtime. Acceptable — nothing
  constructs `Todo` in a const context. `FocusSession` and `FocusPolicy` keep
  const constructors.
- **Invariant asserts** added to `Todo`: `endAt >= startAt` (when both set) and
  `completedAt` non-null iff `status == done`. Both analyze clean.
- **`fromWire`/`fromLevel` throw** on unknown/out-of-range values by design —
  the data layer is responsible for handling corrupt persisted values.
- Analyzer: `flutter analyze lib/domain` → clean.
