import 'package:flutter_test/flutter_test.dart';
import 'package:hi_planner/data/repositories/focus_repository_impl.dart';
import 'package:hi_planner/data/repositories/todo_repository_impl.dart';
import 'package:hi_planner/domain/enums/focus_end_reason.dart';

import 'helpers.dart';

void main() {
  group('FocusRepositoryImpl', () {
    test('getFocusPolicy returns the default policy', () async {
      final db = newTestDb();
      final repo = FocusRepositoryImpl(db);
      final policy = await repo.getFocusPolicy();
      expect(policy.defaultSessionMinutes, 25);
      expect(policy.defaultSessionSeconds, 1500);
      await db.close();
    });

    test('startSession + getSessionById round-trips', () async {
      final db = newTestDb();
      await TodoRepositoryImpl(db).createTodo(makeTodo(id: 't1'));
      final repo = FocusRepositoryImpl(db);

      final session = makeSession(id: 's1', todoId: 't1', durationSeconds: 0);
      await repo.startSession(session);

      final fetched = await repo.getSessionById('s1');
      expect(fetched, isNotNull);
      expect(fetched!.isRunning, isTrue);
      expect(fetched.plannedSeconds, 1500);
      expect(fetched.todoId, 't1');
      await db.close();
    });

    test('getSessionsForTodo / ForDay order newest-first by startAt', () async {
      final db = newTestDb();
      await TodoRepositoryImpl(db).createTodo(makeTodo(id: 't1'));
      final repo = FocusRepositoryImpl(db);
      await repo.startSession(makeSession(
          id: 'early', todoId: 't1', startAt: DateTime.utc(2026, 7, 15, 8)));
      await repo.startSession(makeSession(
          id: 'late', todoId: 't1', startAt: DateTime.utc(2026, 7, 15, 10)));

      final forTodo = await repo.getSessionsForTodo('t1');
      expect(forTodo.map((s) => s.id).toList(), ['late', 'early']);

      final forDay = await repo.getSessionsForDay('2026-07-15');
      expect(forDay.map((s) => s.id).toList(), ['late', 'early']);
      await db.close();
    });

    test('updateSessionAccounting updates the session but NOT the todo cache',
        () async {
      final db = newTestDb();
      final todoRepo = TodoRepositoryImpl(db);
      await todoRepo.createTodo(makeTodo(id: 't1'));
      final repo = FocusRepositoryImpl(db);
      await repo.startSession(makeSession(id: 's1', todoId: 't1'));

      await repo.updateSessionAccounting(
        makeSession(id: 's1', todoId: 't1', durationSeconds: 600, pausedSeconds: 60),
      );

      final session = await repo.getSessionById('s1');
      expect(session!.durationSeconds, 600);
      expect(session.pausedSeconds, 60);

      // Per approved decision: pause/resume ticks do not touch the todo cache.
      final todo = await todoRepo.getTodoById('t1');
      expect(todo!.focusTotalSeconds, 0);
      expect(todo.focusSessionCount, 0);
      await db.close();
    });

    test('endSession recomputes the todo denorm cache in a transaction',
        () async {
      final db = newTestDb();
      final todoRepo = TodoRepositoryImpl(db);
      await todoRepo.createTodo(makeTodo(id: 't1'));
      final repo = FocusRepositoryImpl(db);

      // First session: 1400s.
      await repo.startSession(makeSession(id: 's1', todoId: 't1'));
      await repo.endSession(
        makeSession(id: 's1', todoId: 't1', durationSeconds: 1400),
        FocusEndReason.completed,
      );

      var todo = await todoRepo.getTodoById('t1');
      expect(todo!.focusTotalSeconds, 1400);
      expect(todo.focusSessionCount, 1);

      // Second session: +600s, count -> 2, total -> 2000 (recompute, not blind +=).
      await repo.startSession(makeSession(id: 's2', todoId: 't1'));
      await repo.endSession(
        makeSession(id: 's2', todoId: 't1', durationSeconds: 600),
        FocusEndReason.autoStopped,
      );

      todo = await todoRepo.getTodoById('t1');
      expect(todo!.focusTotalSeconds, 2000);
      expect(todo.focusSessionCount, 2);

      // endReason persisted.
      final ended = await repo.getSessionById('s2');
      expect(ended!.endReason, FocusEndReason.autoStopped);
      expect(ended.isRunning, isFalse);
      await db.close();
    });

    test('inserting a session with a non-existent todoId is rejected '
        '(FK enforced via PRAGMA foreign_keys=ON)', () async {
      final db = newTestDb();
      final repo = FocusRepositoryImpl(db);

      // No todo 'ghost' exists -> the FK constraint must reject the insert.
      expect(
        () => repo.startSession(makeSession(id: 's1', todoId: 'ghost')),
        throwsA(isA<Exception>()), // FK violation surfaces as a SqliteException
      );

      await db.close();
    });

    test('sessions survive a soft-deleted todo (records preserved)', () async {
      final db = newTestDb();
      final todoRepo = TodoRepositoryImpl(db);
      await todoRepo.createTodo(makeTodo(id: 't1'));
      final repo = FocusRepositoryImpl(db);
      await repo.startSession(makeSession(id: 's1', todoId: 't1'));
      await repo.endSession(
        makeSession(id: 's1', todoId: 't1', durationSeconds: 900),
        FocusEndReason.completed,
      );

      await todoRepo.deleteTodo('t1');

      // Todo hidden, but its focus sessions remain for analytics.
      expect(await todoRepo.getTodoById('t1'), isNull);
      final sessions = await repo.getSessionsForTodo('t1');
      expect(sessions, hasLength(1));
      expect(sessions.first.durationSeconds, 900);
      await db.close();
    });
  });
}
