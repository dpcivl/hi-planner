import 'package:drift/drift.dart';

/// Drift table definitions mapping `contract.Storage` one-to-one.
///
/// Design notes (see docs/decisions/0002-data-layer.md):
/// - Instants (createdAt/updatedAt/completedAt/startAt/endAt/deletedAt) are
///   stored as `TEXT` ISO-8601-UTC-`Z` strings, hand-mapped in `data/models`
///   so the persisted wire format matches the contract exactly (independent of
///   Drift's internal datetime representation).
/// - `scheduledDate` is a local 'YYYY-MM-DD' string that drives 오늘/이번달
///   bucketing with no read-time timezone math.
/// - Enums are stored via their existing `wireValue` (TEXT) / `Priority.level`
///   (INT); `tags` as a JSON array string; booleans as SQLite INTEGER.
///
/// The generated row data classes are named `TodoRow` / `FocusSessionRow`
/// (via [DataClassName]) to avoid colliding with the domain `Todo` /
/// `FocusSession` entities.

/// Todos table. Soft-delete only: rows are never physically removed — a set
/// [deletedAt] marks a todo as deleted while preserving its FocusSessions
/// history. The domain `Todo` entity intentionally has no `deletedAt`; active
/// queries filter `deletedAt IS NULL`.
@DataClassName('TodoRow')
@TableIndex(name: 'idx_todo_scheduledDate', columns: {#scheduledDate})
@TableIndex(name: 'idx_todo_status', columns: {#status})
class Todos extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get notes => text().nullable()();

  /// `TodoStatus.wireValue`.
  TextColumn get status => text()();

  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
  TextColumn get completedAt => text().nullable()();

  /// Local 'YYYY-MM-DD' bucket key.
  TextColumn get scheduledDate => text()();

  TextColumn get startAt => text().nullable()();
  TextColumn get endAt => text().nullable()();

  TextColumn get timezone => text()();
  BoolColumn get isAllDay => boolean()();

  /// `Priority.level` (0..3).
  IntColumn get priority => integer()();

  /// JSON-encoded `List<String>`.
  TextColumn get tags => text()();

  /// Denormalized cache (recomputed from FocusSessions on session end).
  IntColumn get focusTotalSeconds => integer().withDefault(const Constant(0))();
  IntColumn get focusSessionCount => integer().withDefault(const Constant(0))();

  IntColumn get orderIndex => integer()();

  /// Soft-delete marker (ISO-UTC-Z). Null = active.
  TextColumn get deletedAt => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// FocusSessions table. Source of truth for focus analytics. Rows are never
/// deleted or cascaded (records are preserved even when the owning todo is
/// soft-deleted).
@DataClassName('FocusSessionRow')
@TableIndex(name: 'idx_fs_scheduledDate', columns: {#scheduledDate})
@TableIndex(name: 'idx_fs_todoId', columns: {#todoId})
class FocusSessions extends Table {
  TextColumn get id => text()();

  /// FK to [Todos.id]. No cascade — sessions outlive a soft-deleted todo.
  TextColumn get todoId => text().references(Todos, #id)();

  TextColumn get startAt => text()();
  TextColumn get endAt => text().nullable()();
  TextColumn get createdAt => text()();

  IntColumn get plannedSeconds => integer().nullable()();
  IntColumn get durationSeconds => integer()();
  IntColumn get pausedSeconds => integer()();
  BoolColumn get interrupted => boolean()();

  /// `FocusEndReason.wireValue`.
  TextColumn get endReason => text()();

  TextColumn get scheduledDate => text()();
  TextColumn get timezone => text()();

  @override
  Set<Column> get primaryKey => {id};
}
