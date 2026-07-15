import 'package:drift/drift.dart';

import '../../domain/entities/focus_policy.dart';
import '../../domain/entities/focus_session.dart';
import '../../domain/enums/focus_end_reason.dart';
import '../../domain/repositories/focus_repository.dart';
import '../models/focus_session_model.dart';
import '../sources/app_database.dart';

/// Drift-backed [FocusRepository]. FocusSession rows are the source of truth for
/// focus analytics and are never deleted. The owning todo's denormalized
/// `focusTotalSeconds` / `focusSessionCount` cache is recomputed from these rows
/// **only on session end** (per approved decision), inside the end transaction —
/// frequent pause/resume accounting writes do not touch the todo cache.
class FocusRepositoryImpl implements FocusRepository {
  FocusRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<FocusPolicy> getFocusPolicy() async {
    // Fixed config per contract.FocusPolicy — not persisted state.
    return FocusPolicy.defaults;
  }

  @override
  Future<void> startSession(FocusSession session) async {
    await _db.into(_db.focusSessions).insert(session.toCompanion());
  }

  @override
  Future<void> updateSessionAccounting(FocusSession session) async {
    // Pause/resume accounting only; deliberately does NOT refresh the todo
    // denorm cache (avoids write-amplification / spurious todo stream emits).
    await (_db.update(_db.focusSessions)
          ..where((s) => s.id.equals(session.id)))
        .write(
      FocusSessionsCompanion(
        durationSeconds: Value(session.durationSeconds),
        pausedSeconds: Value(session.pausedSeconds),
      ),
    );
  }

  @override
  Future<void> endSession(FocusSession session, FocusEndReason endReason) async {
    await _db.transaction(() async {
      final endIso = (session.endAt ?? DateTime.now().toUtc())
          .toUtc()
          .toIso8601String();
      await (_db.update(_db.focusSessions)
            ..where((s) => s.id.equals(session.id)))
          .write(
        FocusSessionsCompanion(
          endAt: Value(endIso),
          durationSeconds: Value(session.durationSeconds),
          pausedSeconds: Value(session.pausedSeconds),
          interrupted: Value(session.interrupted),
          endReason: Value(endReason.wireValue),
        ),
      );
      await _recomputeTodoFocusCache(session.todoId);
    });
  }

  @override
  Future<FocusSession?> getSessionById(String id) async {
    final row = await (_db.select(_db.focusSessions)
          ..where((s) => s.id.equals(id)))
        .getSingleOrNull();
    return row?.toEntity();
  }

  @override
  Future<List<FocusSession>> getSessionsForTodo(String todoId) {
    return _todoQuery(todoId).get().then(_toEntities);
  }

  @override
  Stream<List<FocusSession>> watchSessionsForTodo(String todoId) {
    return _todoQuery(todoId).watch().map(_toEntities);
  }

  @override
  Future<List<FocusSession>> getSessionsForDay(String date) {
    return _dayQuery(date).get().then(_toEntities);
  }

  @override
  Stream<List<FocusSession>> watchSessionsForDay(String date) {
    return _dayQuery(date).watch().map(_toEntities);
  }

  /// Recompute the owning todo's denorm cache from all its session rows.
  /// Runs inside [endSession]'s transaction, so readers never observe the
  /// ended session without its cache update.
  Future<void> _recomputeTodoFocusCache(String todoId) async {
    final sumExpr = _db.focusSessions.durationSeconds.sum();
    final countExpr = _db.focusSessions.id.count();
    final query = _db.selectOnly(_db.focusSessions)
      ..addColumns([sumExpr, countExpr])
      ..where(_db.focusSessions.todoId.equals(todoId));
    final row = await query.getSingle();
    final total = row.read(sumExpr) ?? 0;
    final count = row.read(countExpr) ?? 0;
    final nowIso = DateTime.now().toUtc().toIso8601String();
    await (_db.update(_db.todos)..where((t) => t.id.equals(todoId))).write(
      TodosCompanion(
        focusTotalSeconds: Value(total),
        focusSessionCount: Value(count),
        updatedAt: Value(nowIso),
      ),
    );
  }

  SimpleSelectStatement<$FocusSessionsTable, FocusSessionRow> _todoQuery(
      String todoId) {
    return _db.select(_db.focusSessions)
      ..where((s) => s.todoId.equals(todoId))
      ..orderBy([(s) => OrderingTerm.desc(s.startAt)]);
  }

  SimpleSelectStatement<$FocusSessionsTable, FocusSessionRow> _dayQuery(
      String date) {
    return _db.select(_db.focusSessions)
      ..where((s) => s.scheduledDate.equals(date))
      ..orderBy([(s) => OrderingTerm.desc(s.startAt)]);
  }

  List<FocusSession> _toEntities(List<FocusSessionRow> rows) =>
      rows.map((r) => r.toEntity()).toList();
}
