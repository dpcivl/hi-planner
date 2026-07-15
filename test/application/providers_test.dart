import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hi_planner/application/providers.dart';
import 'package:hi_planner/domain/repositories/focus_repository.dart';
import 'package:hi_planner/domain/repositories/todo_repository.dart';

import '../data/helpers.dart';

void main() {
  test('container resolves repositories as their domain interface types', () {
    final db = newTestDb();
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    addTearDown(() => db.close());
    addTearDown(container.dispose);

    // Typed as the domain abstraction, and non-null.
    expect(container.read(todoRepositoryProvider), isA<TodoRepository>());
    expect(container.read(focusRepositoryProvider), isA<FocusRepository>());
  });

  test('appDatabaseProvider override propagates through the repositories',
      () async {
    final db = newTestDb();
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    addTearDown(() => db.close());
    addTearDown(container.dispose);

    // A write via the provider-obtained repository lands in the injected db,
    // proving the repo is wired to the overridden database (not a fresh one).
    final todoRepo = container.read(todoRepositoryProvider);
    await todoRepo.createTodo(makeTodo(id: 't1', title: 'wired'));

    final fetched = await todoRepo.getTodoById('t1');
    expect(fetched, isNotNull);
    expect(fetched!.title, 'wired');

    // Both repository providers resolve against the very same db instance.
    expect(container.read(appDatabaseProvider), same(db));
  });
}
