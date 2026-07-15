import 'package:flutter_test/flutter_test.dart';
import 'package:hi_planner/data/models/data_mapping_exception.dart';
import 'package:hi_planner/data/repositories/todo_repository_impl.dart';
import 'package:hi_planner/data/sources/app_database.dart' show TodosCompanion;
import 'package:hi_planner/domain/enums/priority.dart';
import 'package:hi_planner/domain/enums/todo_status.dart';

import 'helpers.dart';

void main() {
  group('TodoRepositoryImpl', () {
    test('create + getTodoById round-trips all fields', () async {
      final db = newTestDb();
      final repo = TodoRepositoryImpl(db);
      final todo = makeTodo(
        id: 't1',
        title: '설계 리뷰',
        priority: Priority.high,
        tags: ['dev', 'planner'],
        startAt: DateTime.utc(2026, 7, 15, 10),
        endAt: DateTime.utc(2026, 7, 15, 11),
      );

      await repo.createTodo(todo);
      final fetched = await repo.getTodoById('t1');

      expect(fetched, isNotNull);
      expect(fetched, equals(todo)); // value equality (Equatable)
      expect(fetched!.tags, ['dev', 'planner']);
      expect(fetched.priority, Priority.high);
      expect(fetched.startAt, DateTime.utc(2026, 7, 15, 10));

      await db.close();
    });

    test('updateTodo persists changes', () async {
      final db = newTestDb();
      final repo = TodoRepositoryImpl(db);
      await repo.createTodo(makeTodo(id: 't1', title: 'old'));

      await repo.updateTodo(makeTodo(
        id: 't1',
        title: 'new',
        status: TodoStatus.done,
        completedAt: DateTime.utc(2026, 7, 15, 12),
      ));

      final fetched = await repo.getTodoById('t1');
      expect(fetched!.title, 'new');
      expect(fetched.status, TodoStatus.done);
      expect(fetched.completedAt, DateTime.utc(2026, 7, 15, 12));

      await db.close();
    });

    test('getTodosForDay filters by scheduledDate and orders by orderIndex',
        () async {
      final db = newTestDb();
      final repo = TodoRepositoryImpl(db);
      await repo.createTodo(
          makeTodo(id: 'b', scheduledDate: '2026-07-15', orderIndex: 2));
      await repo.createTodo(
          makeTodo(id: 'a', scheduledDate: '2026-07-15', orderIndex: 1));
      await repo.createTodo(
          makeTodo(id: 'other', scheduledDate: '2026-07-16', orderIndex: 0));

      final today = await repo.getTodosForDay('2026-07-15');
      expect(today.map((t) => t.id).toList(), ['a', 'b']);

      await db.close();
    });

    test('getTodosForMonth filters by YYYY-MM prefix', () async {
      final db = newTestDb();
      final repo = TodoRepositoryImpl(db);
      await repo.createTodo(makeTodo(id: 'jul1', scheduledDate: '2026-07-01'));
      await repo.createTodo(makeTodo(id: 'jul31', scheduledDate: '2026-07-31'));
      await repo.createTodo(makeTodo(id: 'aug', scheduledDate: '2026-08-01'));

      final july = await repo.getTodosForMonth('2026-07');
      expect(july.map((t) => t.id).toSet(), {'jul1', 'jul31'});

      await db.close();
    });

    test('deleteTodo is a soft delete: hidden from reads but row preserved',
        () async {
      final db = newTestDb();
      final repo = TodoRepositoryImpl(db);
      await repo.createTodo(makeTodo(id: 't1', scheduledDate: '2026-07-15'));

      await repo.deleteTodo('t1');

      expect(await repo.getTodoById('t1'), isNull);
      expect(await repo.getTodosForDay('2026-07-15'), isEmpty);
      expect(await repo.getTodosForMonth('2026-07'), isEmpty);

      // Row still physically present with deletedAt set.
      final row = await (db.select(db.todos)
            ..where((t) => t.id.equals('t1')))
          .getSingleOrNull();
      expect(row, isNotNull);
      expect(row!.deletedAt, isNotNull);

      await db.close();
    });

    test('updateTodo preserves deletedAt (does not resurrect a deleted todo)',
        () async {
      final db = newTestDb();
      final repo = TodoRepositoryImpl(db);
      await repo.createTodo(makeTodo(id: 't1'));
      await repo.deleteTodo('t1');

      // A stray domain update must not clobber the soft-delete marker.
      await repo.updateTodo(makeTodo(id: 't1', title: 'edited'));

      expect(await repo.getTodoById('t1'), isNull);
      final row = await (db.select(db.todos)
            ..where((t) => t.id.equals('t1')))
          .getSingleOrNull();
      expect(row!.deletedAt, isNotNull);

      await db.close();
    });

    test('reading a row with a corrupt stored value throws '
        'DataMappingException', () async {
      final db = newTestDb();
      final repo = TodoRepositoryImpl(db);

      // Write a row directly (bypassing the mapper) with an invalid `status`
      // enum string, simulating corrupt persisted data.
      final now = DateTime.utc(2026, 7, 15).toIso8601String();
      await db.into(db.todos).insert(TodosCompanion.insert(
            id: 'bad',
            title: 'corrupt',
            status: 'NOT_A_STATUS',
            createdAt: now,
            updatedAt: now,
            scheduledDate: '2026-07-15',
            timezone: 'Asia/Seoul',
            isAllDay: false,
            priority: 1,
            tags: '[]',
            orderIndex: 0,
          ));

      expect(
        () => repo.getTodoById('bad'),
        throwsA(isA<DataMappingException>()
            .having((e) => e.entity, 'entity', 'Todo')
            .having((e) => e.rowId, 'rowId', 'bad')),
      );

      await db.close();
    });

    test('watchTodosForDay emits on create and delete', () async {
      final db = newTestDb();
      final repo = TodoRepositoryImpl(db);
      final stream = repo.watchTodosForDay('2026-07-15');

      final expectation = expectLater(
        stream.map((list) => list.map((t) => t.id).toList()),
        emitsInOrder([
          <String>[],
          ['t1'],
          <String>[],
        ]),
      );

      await pumpEventQueue();
      await repo.createTodo(makeTodo(id: 't1', scheduledDate: '2026-07-15'));
      await pumpEventQueue();
      await repo.deleteTodo('t1');

      await expectation;
      await db.close();
    });
  });
}
