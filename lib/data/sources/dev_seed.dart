import 'dart:convert';

import 'package:drift/drift.dart';

import 'app_database.dart';

/// Dev-only seed data. Invoked from [AppDatabase]'s `beforeOpen` migration
/// hook, guarded by `kDebugMode && details.wasCreated`, so it inserts sample
/// rows exactly once on a fresh debug database and is excluded from release
/// builds (the guard's `kReleaseMode` const tree-shakes the call site).
///
/// Writes raw companions directly (data-layer internal) rather than going
/// through the domain mappers, keeping the seed self-contained.
class DevSeed {
  DevSeed(this._db);

  final AppDatabase _db;

  Future<void> run() async {
    final now = DateTime.now().toUtc();
    final today = _localDay(now);
    const tz = 'Asia/Seoul';

    String iso(DateTime dt) => dt.toUtc().toIso8601String();

    await _db.transaction(() async {
      // Two active todos scheduled today.
      await _db.into(_db.todos).insert(TodosCompanion.insert(
            id: 'seed-todo-1',
            title: '데이터 레이어 설계 리뷰',
            status: 'inProgress',
            createdAt: iso(now),
            updatedAt: iso(now),
            scheduledDate: today,
            startAt: Value(iso(now.add(const Duration(hours: 1)))),
            endAt: Value(iso(now.add(const Duration(hours: 2)))),
            timezone: tz,
            isAllDay: false,
            priority: 2,
            tags: jsonEncode(['dev', 'planner']),
            orderIndex: 0,
          ));

      await _db.into(_db.todos).insert(TodosCompanion.insert(
            id: 'seed-todo-2',
            title: '산책하기',
            notes: const Value('저녁 30분'),
            status: 'pending',
            createdAt: iso(now),
            updatedAt: iso(now),
            scheduledDate: today,
            timezone: tz,
            isAllDay: true,
            priority: 0,
            tags: jsonEncode(const <String>[]),
            orderIndex: 1,
          ));

      // A completed focus session for todo-1 (feeds the denorm cache below).
      final sessionStart = now.subtract(const Duration(minutes: 30));
      final sessionEnd = now.subtract(const Duration(minutes: 5));
      await _db.into(_db.focusSessions).insert(FocusSessionsCompanion.insert(
            id: 'seed-session-1',
            todoId: 'seed-todo-1',
            startAt: iso(sessionStart),
            endAt: Value(iso(sessionEnd)),
            createdAt: iso(sessionStart),
            plannedSeconds: const Value(1500),
            durationSeconds: 1400,
            pausedSeconds: 100,
            interrupted: false,
            endReason: 'completed',
            scheduledDate: today,
            timezone: tz,
          ));

      // Reflect the seeded session in todo-1's denorm cache.
      await (_db.update(_db.todos)..where((t) => t.id.equals('seed-todo-1')))
          .write(const TodosCompanion(
        focusTotalSeconds: Value(1400),
        focusSessionCount: Value(1),
      ));
    });
  }

  /// Local calendar day 'YYYY-MM-DD'. The seed uses the host local date
  /// (dev-only convenience); production writes the app-computed local day.
  String _localDay(DateTime utc) {
    final local = utc.toLocal();
    final y = local.year.toString().padLeft(4, '0');
    final mo = local.month.toString().padLeft(2, '0');
    final d = local.day.toString().padLeft(2, '0');
    return '$y-$mo-$d';
  }
}
