# ADR 0002: Data Layer (Drift / SQLite)

- **Status**: Accepted
- **Date**: 2026-07-15
- **Owner**: dpcivl (human-reviewed & approved 2026-07-15)
- **Spec refs**: `contract.Storage`, `contract.Todo`, `contract.FocusSession` (v2), `contract.FocusPolicy`, `contract.Architecture`, `impl.domain`, `review.domain`

> IMPLEMENTED. `pubspec.yaml` deps added, `lib/data/**` built, codegen run,
> tests in `test/data/`. `flutter analyze` clean, `flutter test` green.
>
> **Human-approved decisions (2026-07-15):**
> - **(a) Denorm cache**: the Todo cache is recomputed **only on session end**,
>   inside the end transaction. Frequent `updateSessionAccounting` (pause/resume)
>   ticks do **not** touch the Todo cache.
> - **(b) Deletion = soft-delete, data-layer only**: `Todos` gets a nullable
>   `deletedAt TEXT` column. The **domain `Todo` entity and `contract.Todo` are
>   unchanged** (domain sees only active todos). `deleteTodo` sets `deletedAt`;
>   all active reads filter `deletedAt IS NULL`. FocusSessions are **never**
>   deleted/cascaded — focus history is preserved.

## Feature

Implement the domain repository interfaces
(`lib/domain/repositories/{todo_repository,focus_repository}.dart`) with a
concrete Drift/SQLite persistence layer under `lib/data/`, satisfying the fixed
`contract.Storage` schema, its indexes/key queries, and the reactive
`watch*` streams that power the 오늘/이번달 views.

## 1. Dependencies & codegen

Runtime (`dependencies`):

| Package | Purpose |
| --- | --- |
| `drift` | Typed query DSL, `.watch()` streams, migrations. |
| `drift_flutter` | Cross-platform `driftDatabase(...)` connection helper (native + web) so `data/sources` stays platform-agnostic. |
| `sqlite3_flutter_libs` | Bundles the native SQLite lib (iOS/Android/macOS/Windows/Linux). |
| `flutter_riverpod` | Already mandated by `contract.Architecture` for DI (app/DI layer's concern). |

Dev (`dev_dependencies`):

| Package | Purpose |
| --- | --- |
| `drift_dev` | Code generator for tables/database. |
| `build_runner` | Runs the generators. |

Web support: Drift on web needs WASM assets `web/sqlite3.wasm` and
`web/drift_worker.js` (copied from the drift/sqlite3 packages). Native needs no
asset step. This is a one-time setup cost — flagged as a risk (§7).

**Codegen location & command**: annotations live on the database file
`lib/data/sources/app_database.dart` (`@DriftDatabase(tables: [...])`) and the
table classes in `lib/data/sources/tables.dart`. Generation:
`dart run build_runner build --delete-conflicting-outputs`, emitting
`app_database.g.dart` (git-ignored generated file). No `build.yaml` is required;
we deliberately do **not** enable drift's `store_date_time_values_as_text`
global (see §2 — instants are hand-mapped TEXT for exact contract fidelity).

**DI fit (app-layer's lane, noted for the seam)**: the data layer exposes plain
constructables — `AppDatabase()` and `TodoRepositoryImpl(db)` /
`FocusRepositoryImpl(db)`. Wiring lives in `application/providers.dart`: one
singleton `Provider<AppDatabase>` (single connection; see §7 concurrency) whose
`dispose` closes the DB, and `Provider<TodoRepository>` /
`Provider<FocusRepository>` returning the impls bound to the domain interface
type. No `riverpod_generator` — plain providers avoid a second codegen toolchain.

## 2. Drift table definitions plan

Two tables in `lib/data/sources/tables.dart`, mapping `contract.Storage`
one-to-one. **Instants are stored as `TEXT` ISO-8601-UTC-`Z` strings**, not
Drift's default `DateTime` mapping — hand-mapped in the DTO mappers (§3) so the
persisted wire format is exactly the contract's `Z` form and independent of
Drift's internal datetime representation. `scheduledDate` bucketing uses the
stored local `'YYYY-MM-DD'` string with no read-time timezone math (per
contract).

**Todos**

| Column | Drift type | Notes |
| --- | --- | --- |
| id | `text()` | PK. |
| title | `text()` | non-empty (validated in domain). |
| notes | `text().nullable()` | |
| status | `text()` | enum via `TodoStatus.wireValue`. |
| createdAt / updatedAt | `text()` | ISO-UTC-Z. |
| completedAt | `text().nullable()` | ISO-UTC-Z. |
| scheduledDate | `text()` | 'YYYY-MM-DD' local. |
| startAt / endAt | `text().nullable()` | ISO-UTC-Z. |
| timezone | `text()` | IANA. |
| isAllDay | `boolean()` | INTEGER 0/1. |
| priority | `integer()` | `Priority.level` 0..3. |
| tags | `text()` | JSON array string (`jsonEncode`). |
| focusTotalSeconds | `integer().withDefault(const Constant(0))` | denorm cache (§5). |
| focusSessionCount | `integer().withDefault(const Constant(0))` | denorm cache (§5). |
| orderIndex | `integer()` | manual ordering. |
| deletedAt | `text().nullable()` | **soft-delete marker** (ISO-UTC-Z); null = active. Data-layer only; absent from the domain entity. |

**FocusSessions**

| Column | Drift type | Notes |
| --- | --- | --- |
| id | `text()` | PK. |
| todoId | `text().references(Todos, #id)` | FK, **no cascade** — sessions outlive a soft-deleted todo. |
| startAt | `text()` | ISO-UTC-Z. |
| endAt | `text().nullable()` | null while running. |
| createdAt | `text()` | ISO-UTC-Z. |
| plannedSeconds | `integer().nullable()` | null = open-ended. |
| durationSeconds | `integer()` | actual focused. |
| pausedSeconds | `integer()` | |
| interrupted | `boolean()` | INTEGER 0/1. |
| endReason | `text()` | enum via `FocusEndReason.wireValue`. |
| scheduledDate | `text()` | 'YYYY-MM-DD' local. |
| timezone | `text()` | IANA. |

**Indexes** (via `@TableIndex` annotations, matching `contract.Storage`):
`idx_todo_scheduledDate`, `idx_todo_status`, `idx_fs_scheduledDate`,
`idx_fs_todoId`.

**Encoding summary**: enums → their existing `wireValue` (string) /
`Priority.level` (int); `tags` → JSON string via `jsonEncode`/`jsonDecode`
(Drift has no list column; `json_each` available if tag-filtering is ever
needed); bools → SQLite INTEGER; instants → hand-mapped ISO-UTC-Z TEXT.

## 3. Entity ↔ row mapping (`data/models`)

Drift **generates** row data classes (`Todo`-row, `FocusSession`-row) and
insert companions. To avoid a naming clash with the domain entities and a
redundant third DTO layer, mappers live in `data/models/`:

- `data/models/todo_model.dart` — extension mappers
  `TodoRow.toEntity()` → domain `Todo`, and `Todo.toCompanion()` →
  `TodosCompanion` for inserts/updates.
- `data/models/focus_session_model.dart` — same for `FocusSession`.

(Drift's generated row class **is** the DTO; we do not hand-write a parallel
DTO — that would be gold-plating.) The generated table classes are named to
avoid colliding with domain `Todo`/`FocusSession` (e.g. drift data classes
`TodoRow`/`FocusSessionRow` via `@DataClassName`).

Mapping does the type work: `DateTime.parse(...).toUtc()` ↔
`dt.toUtc().toIso8601String()`; `TodoStatus.fromWire` / `FocusEndReason.fromWire`
/ `Priority.fromLevel`; `jsonDecode` ↔ `jsonEncode` for tags.

The data-layer-only `deletedAt` is **not** part of the domain `Todo`:
`TodoRow.toEntity()` drops it, and `Todo.toCompanion()` leaves it
[Value.absent], so a domain-driven update never clobbers the soft-delete marker.

**Corrupt-value handling**: `fromWire`/`fromLevel` throw on bad persisted data
(by design, per `impl.domain`). Mappers catch and rethrow a typed
`DataMappingException` (in `data/models`) carrying the row id, so a single
corrupt row surfaces as a clear failure rather than a raw `ArgumentError`
bubbling through a stream. Repos let it propagate (interface returns plain
`Future`/`Stream`); the app layer's Result/Failure handling is the app layer's lane.

## 4. Repository implementations (`data/repositories`)

`TodoRepositoryImpl(AppDatabase db) implements TodoRepository`
and `FocusRepositoryImpl(AppDatabase db) implements FocusRepository`.

**TodoRepositoryImpl** (all active reads filter `deletedAt IS NULL`)
- `createTodo` → `into(todos).insert(todo.toCompanion())`.
- `updateTodo` → `(update(todos)..where(id)).write(todo.toCompanion())` — a
  companion write (not `replace`) so the data-layer-only `deletedAt` is
  **preserved**, never clobbered (a stray domain update can't resurrect a
  deleted todo).
- `deleteTodo(id)` → **soft delete**: `(update(todos)..where(id)).write(...)`
  setting `deletedAt` (+ `updatedAt`) to now. The row and its FocusSessions
  stay.
- `getTodoById` → `select..where(id & deletedAt.isNull()).getSingleOrNull()`.
- `getTodosForDay(date)` → `where(scheduledDate = date & deletedAt IS NULL)`
  `..orderBy([orderIndex asc, createdAt asc])`.
- `watchTodosForDay(date)` → same query `.watch().map(rows → entities)`.
- `getTodosForMonth(month)` / `watchTodosForMonth(month)` →
  `where(scheduledDate LIKE '$month-%' & deletedAt IS NULL)` (index-backed).

**FocusRepositoryImpl**
- `getFocusPolicy` → returns `FocusPolicy.defaults` (const value object; **no
  table** — the policy is fixed config per `contract.FocusPolicy`, not persisted
  state).
- `startSession` → insert the running row (endAt null). Does **not** recompute
  the cache (decision a).
- `updateSessionAccounting` → update `durationSeconds`/`pausedSeconds` by id.
  **Does not** touch the Todo cache (decision a).
- `endSession(session, endReason)` → transaction: update the row with
  `endAt`/final duration/paused/interrupted/`endReason.wireValue`, then recompute
  the todo cache and bump `Todos.updatedAt`.
- `getSessionById` → `getSingleOrNull` → `toEntity()`.
- `getSessionsForTodo(todoId)` / `watchSessionsForTodo` →
  `where(todoId = ..)..orderBy([startAt desc])` (newest first), get/watch.
- `getSessionsForDay(date)` / `watchSessionsForDay` →
  `where(scheduledDate = date)`, get/watch.

Reactive streams: Drift `.watch()` re-emits whenever the underlying tables
change, so the 오늘/이번달 views and per-todo/day session views update
automatically — no manual invalidation.

## 5. Denormalized `focusTotalSeconds` / `focusSessionCount` maintenance

**Decision (approved): recompute-in-transaction from `FocusSessions` (the source
of truth), run *only on session end* (`endSession`), inside the same Drift
transaction as the session mutation.** Sessions are never deleted, so `endSession`
is the sole cache-affecting event.

Implementation: a private
`_recomputeTodoFocusCache(todoId)` runs
`SELECT COALESCE(SUM(durationSeconds),0), COUNT(*) FROM focus_sessions WHERE todoId = ?`
and writes both back onto the Todo row.

**Rationale**
- **Idempotent & self-healing**: recompute yields the correct total regardless
  of retries, edits, re-ends, or deletes. A blind `+=` increment drifts
  permanently if `endSession` is retried, a session is edited, or one is deleted.
- **Cheap**: a todo has a handful of sessions; `idx_fs_todoId` makes the
  aggregate a tiny index scan.
- **Consistency inside the write's transaction**: readers never observe a
  session insert without its cache update (Drift serializes writes; the
  transaction is atomic).

**Rejected**
- *Blind increment/decrement* — drift risk on retry/edit/delete (above).
- *DB trigger* — logic hidden from Dart, harder to unit-test, and adds
  native↔WASM parity surface across platforms; Drift migrations manage triggers
  less ergonomically than table Dart code.
- *Pure recompute-on-read (no denorm)* — rejected because `focusTotalSeconds`/
  `focusSessionCount` are **contract fields on `Todo`**, and the 오늘/이번달
  list needs per-todo totals without an aggregate-join per row.

**RESOLVED (decision a)**: the frequent `updateSessionAccounting` (pause/resume
ticks) does **not** refresh the Todo cache. The live in-progress number is
presentation state owned by the focus timer notifier (`application/focus`); the
Todo denorm cache reflects the running session's partial duration only at
`endSession`. This avoids write-amplification on the `Todos` table (and spurious
`watchTodosForDay` re-emissions) on every timer tick. Trade-off: if the app is
killed mid-session, the Todo cache lags the last persisted accounting snapshot
until the session is ended on next open — acceptable, and the `FocusSessions`
row still holds the truth.

## 6. Dev-only seed data

Seed inside Drift's `MigrationStrategy.beforeOpen`, guarded by both
`kDebugMode` (from `package:flutter/foundation.dart`) and `details.wasCreated`
so it runs exactly once, only on a fresh **debug** database:

```
beforeOpen: (details) async {
  await customStatement('PRAGMA foreign_keys = ON');
  if (kDebugMode && details.wasCreated) {
    await DevSeed(this).run(); // a few Todos + FocusSessions
  }
}
```

Seed content lives in `lib/data/sources/dev_seed.dart`. Because `kReleaseMode`
is a `const`, the Dart compiler tree-shakes the seed branch out of release
builds (dead-code elimination), so seed rows are never inserted in production.

Note (minor, flagged): the `DevSeed` *code* still links into the release binary
unless split behind a Flutter flavor / separate `main_dev.dart` entrypoint. For
the MVP the `kDebugMode` guard is sufficient; a flavor split is deferred.

## 7. Risks & alternatives rejected

- **Web SQLite (WASM) vs native** — Drift native uses `sqlite3_flutter_libs`
  (zero asset config); web requires bundling `sqlite3.wasm` + `drift_worker.js`
  under `web/`. **Risk**: forgetting the web assets → web build fails at
  runtime. Mitigation: use `drift_flutter`'s connection helper and document the
  asset copy in the setup step. *Rejected alt*: `sqflite` — no web support, no
  typed/compiled queries, no reactive streams (already rejected in
  `contract.Storage`).
- **Instant storage: hand-mapped TEXT vs Drift `DateTime`** — chose explicit
  TEXT ISO-UTC-Z to match the contract wire format exactly and stay engine-
  independent. *Rejected*: Drift's default `DateTime` (unix-seconds INTEGER) and
  its `store_date_time_values_as_text` global (Drift's own text format, not the
  contract's `Z` form). Date bucketing relies on the separate `scheduledDate`
  string regardless.
- **Migration strategy** — `schemaVersion = 1`; `onCreate` builds all
  tables+indexes; `beforeOpen` enables `PRAGMA foreign_keys = ON` (Drift does
  not enable FKs by default). Recommend adopting `drift_dev`'s schema snapshot +
  migration tests before the first schema change post-launch. No migration logic
  is needed for v1.
- **Deletion = soft-delete (decision b, approved)** — a Todo is never physically
  removed; `deleteTodo` sets `deletedAt` and active reads filter it out.
  FocusSessions are never deleted or cascaded, so **focus analytics history is
  preserved**. The FK is plain (no cascade); referential integrity holds because
  todos are never hard-deleted. The `deletedAt` column lives **only** in the
  data layer — the domain `Todo` and `contract.Todo` are unchanged, so domain/
  application code only ever sees active todos. *Alt rejected*: hard delete +
  `ON DELETE CASCADE` — discards focus history, which the analytics goal needs.
- **Concurrency** — a single `AppDatabase` connection (singleton provider);
  Drift serializes writes and multi-statement mutations use `transaction()`, so
  there are no cross-write races. The main perf concern is running-timer write
  amplification, handled by the §5 default (don't refresh the Todo cache on
  every `updateSessionAccounting` tick).
- **Codegen toolchain** — plain Riverpod providers (no `riverpod_generator`) to
  avoid a second generator alongside `drift_dev`; only `drift_dev` +
  `build_runner` are added.

## Files this will create (implementation phase, not now)

```
lib/data/
  sources/
    tables.dart            (Todos, FocusSessions + @TableIndex)
    app_database.dart      (@DriftDatabase, migration/seed strategy)
    app_database.g.dart    (generated)
    dev_seed.dart          (kDebugMode-guarded seed)
  models/
    todo_model.dart        (Row<->Todo mappers, DataMappingException)
    focus_session_model.dart
  repositories/
    todo_repository_impl.dart
    focus_repository_impl.dart
```
Plus `pubspec.yaml` deps (§1) and, for web, `web/sqlite3.wasm` +
`web/drift_worker.js`.

## Review & accepted trade-offs

Code review: SOLID — correctness, security, and contract fidelity CLEAN;
only LOW-severity nits, each knowingly accepted for the MVP. Recorded so future
readers understand these are deliberate, not oversights.

1. **이번달 query uses `scheduledDate LIKE 'YYYY-MM-%'` (a full-table scan on the
   text index).** SQLite cannot use the `idx_todo_scheduledDate` index for a
   `LIKE` with a wildcard tail, so the month view scans all Todos.
   *Acceptable for MVP*: at MVP row counts (hundreds of todos) the scan is
   sub-millisecond; if it ever matters, swap to a half-open range
   (`scheduledDate >= '2026-07-01' AND scheduledDate < '2026-08-01'`) which is
   index-friendly — a localized query change, no schema impact.

2. **Denorm recompute at `endSession` counts any still-running sessions for the
   same todo.** `_recomputeTodoFocusCache` sums/counts *all* rows for the todo,
   so a concurrently-running session would be included with its partial
   duration.
   *Acceptable for MVP*: the focus flow is strictly one session at a time (the
   timer notifier owns a single active session), so no second running session
   for a todo can exist at end-time — the edge is temporary and unreachable in
   practice; the recompute self-corrects on the next `endSession` regardless.

3. **A single corrupt row errors the whole `watch*` stream.** `toEntity()`
   throws `DataMappingException` on a bad row, which propagates through the
   `.map()` and faults the entire reactive stream (not just the one item).
   *Acceptable for MVP*: fail-loud is the right default — corrupt data is a bug
   we want surfaced, not silently hidden. Blast radius is bounded: only writes
   go through the validated mappers, so corruption is not reachable through
   normal app operation, and the exception carries `entity` + `rowId` for
   diagnosis. Per-row skipping/quarantine can be added later if a real corruption
   source appears.

### Tests added post-review (`test/data/`)

- Reading a row with a corrupt stored value (invalid `status` enum string,
  written directly past the mapper) throws `DataMappingException` with the
  offending `entity`/`rowId` (trade-off #3).
- Inserting a `FocusSession` with a non-existent `todoId` is rejected by the FK
  constraint (`SqliteException`), confirming `PRAGMA foreign_keys = ON` is active.
