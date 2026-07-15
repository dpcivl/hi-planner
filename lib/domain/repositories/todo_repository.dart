import '../entities/todo.dart';

/// Abstract data-layer boundary for [Todo] persistence.
///
/// Presentation/application depend ONLY on this interface (per
/// `contract.Architecture`); the concrete storage engine lives behind the
/// data-layer implementation. Instants are UTC; buckets are derived from the
/// local `scheduledDate` 'YYYY-MM-DD' string.
abstract class TodoRepository {
  /// Persist a new todo (할 일 생성).
  Future<void> createTodo(Todo todo);

  /// Persist changes to an existing todo (matched by [Todo.id]).
  Future<void> updateTodo(Todo todo);

  /// Delete the todo with [id].
  Future<void> deleteTodo(String id);

  /// Fetch a single todo by [id], or null if none exists.
  Future<Todo?> getTodoById(String id);

  /// One-shot fetch of all todos scheduled on [date] ('YYYY-MM-DD'), ordered.
  Future<List<Todo>> getTodosForDay(String date);

  /// Reactive stream of todos scheduled on [date] ('YYYY-MM-DD') for 오늘 views
  /// (list + timeline). Emits on any change to the matching set.
  Stream<List<Todo>> watchTodosForDay(String date);

  /// One-shot fetch of all todos scheduled within [month] ('YYYY-MM').
  Future<List<Todo>> getTodosForMonth(String month);

  /// Reactive stream of todos scheduled within [month] ('YYYY-MM') for the
  /// 이번 달 view. Emits on any change to the matching set.
  Stream<List<Todo>> watchTodosForMonth(String month);
}
