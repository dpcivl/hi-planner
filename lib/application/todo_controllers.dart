import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/todo.dart';
import '../domain/enums/todo_status.dart';
import '../domain/repositories/todo_repository.dart';
import 'providers.dart';

/// Reactive list of todos for a single day (`date` = 'YYYY-MM-DD').
///
/// Backed by the repository's Drift `.watch` stream, so it re-emits
/// automatically whenever a todo for that day is created, updated, or
/// (soft-)deleted — the UI consumes the resulting `AsyncValue<List<Todo>>`.
final todosForDayProvider = StreamProvider.family<List<Todo>, String>(
  (ref, date) => ref.watch(todoRepositoryProvider).watchTodosForDay(date),
);

/// Reactive list of todos for a month (`month` = 'YYYY-MM'). See
/// [todosForDayProvider].
final todosForMonthProvider = StreamProvider.family<List<Todo>, String>(
  (ref, month) => ref.watch(todoRepositoryProvider).watchTodosForMonth(month),
);

/// Write-side controller for todos. Mutations go straight to the repository;
/// the reactive read providers above refresh themselves via the DB stream, so
/// there is no in-memory list to keep in sync (the database is the source of
/// truth).
final todoActionsProvider = Provider<TodoActions>(
  (ref) => TodoActions(ref.watch(todoRepositoryProvider)),
);

class TodoActions {
  TodoActions(this._repo);

  final TodoRepository _repo;

  Future<void> add(Todo todo) => _repo.createTodo(todo);

  Future<void> update(Todo todo) => _repo.updateTodo(todo);

  Future<void> remove(String id) => _repo.deleteTodo(id);

  /// Toggle completion, keeping the domain invariant that `completedAt` is
  /// non-null iff `status == done`. `now` is injected (not read from the global
  /// clock) so the operation is deterministic and testable.
  Future<void> toggleDone(Todo todo, {required DateTime now}) {
    final isDone = todo.status == TodoStatus.done;
    return _repo.updateTodo(
      todo.copyWith(
        status: isDone ? TodoStatus.pending : TodoStatus.done,
        completedAt: isDone ? null : now, // sentinel copyWith clears on un-done
        updatedAt: now,
      ),
    );
  }
}
