import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hi_planner/application/providers.dart';
import 'package:hi_planner/application/todo_controllers.dart';
import 'package:hi_planner/domain/entities/todo.dart';
import 'package:hi_planner/domain/enums/todo_status.dart';

import '../data/helpers.dart';

/// Poll the event loop until [cond] holds (or time out). Lets a Drift `.watch`
/// re-emission propagate to a live listener without a fixed, flaky delay.
Future<void> _pumpUntil(
  bool Function() cond, {
  Duration timeout = const Duration(seconds: 2),
}) async {
  final deadline = DateTime.now().add(timeout);
  while (!cond()) {
    if (DateTime.now().isAfter(deadline)) {
      throw StateError('condition not met within $timeout');
    }
    await Future<void>.delayed(const Duration(milliseconds: 5));
  }
}

void main() {
  ProviderContainer containerWith(db) {
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    addTearDown(container.dispose);
    return container;
  }

  const date = '2026-07-15';

  test('todosForDayProvider is empty then RE-EMITS to a live listener on create',
      () async {
    final db = newTestDb();
    addTearDown(() => db.close());
    final container = containerWith(db);

    // A single, persistent subscription — so a second emission proves the
    // stream actually re-emits on change (not just that a fresh read reflects
    // current state).
    final emissions = <List<Todo>>[];
    final sub = container.listen(todosForDayProvider(date), (_, next) {
      if (next is AsyncData<List<Todo>>) emissions.add(next.value);
    }, fireImmediately: true);
    addTearDown(sub.close);

    await _pumpUntil(() => emissions.isNotEmpty);
    expect(emissions.first, isEmpty);

    await container.read(todoActionsProvider).add(makeTodo(id: 't1'));

    await _pumpUntil(() => emissions.any((l) => l.any((t) => t.id == 't1')));
    expect(emissions.last.map((t) => t.id), ['t1']);
    expect(emissions.length, greaterThanOrEqualTo(2),
        reason: 'live subscription should have re-emitted, not fired once');
  });

  test('todosForMonthProvider reflects todos in the month bucket', () async {
    final db = newTestDb();
    addTearDown(() => db.close());
    final container = containerWith(db);

    await container.read(todoActionsProvider).add(makeTodo(id: 't1'));
    final list = await container.read(todosForMonthProvider('2026-07').future);
    expect(list.single.id, 't1');
  });

  test('toggleDone sets done+completedAt, then un-does back to pending+null',
      () async {
    final db = newTestDb();
    addTearDown(() => db.close());
    final container = containerWith(db);
    final actions = container.read(todoActionsProvider);
    final repo = container.read(todoRepositoryProvider);
    final now = DateTime.utc(2026, 7, 15, 10);

    await actions.add(makeTodo(id: 't1', status: TodoStatus.pending));
    final pending = (await repo.getTodoById('t1'))!;

    await actions.toggleDone(pending, now: now);
    final done = (await repo.getTodoById('t1'))!;
    expect(done.status, TodoStatus.done);
    expect(done.completedAt, now);
    expect(done.updatedAt, now);

    await actions.toggleDone(done, now: now);
    final reopened = (await repo.getTodoById('t1'))!;
    expect(reopened.status, TodoStatus.pending);
    expect(reopened.completedAt, isNull);
  });

  test('add then remove round-trips (soft-delete hides the todo)', () async {
    final db = newTestDb();
    addTearDown(() => db.close());
    final container = containerWith(db);
    final actions = container.read(todoActionsProvider);
    final repo = container.read(todoRepositoryProvider);

    await actions.add(makeTodo(id: 't1'));
    expect(await repo.getTodoById('t1'), isNotNull);

    await actions.remove('t1');
    expect(await repo.getTodoById('t1'), isNull);
  });
}
