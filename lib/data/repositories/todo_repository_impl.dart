import 'package:drift/drift.dart';

import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../models/todo_model.dart';
import '../sources/app_database.dart';

/// Drift-backed [TodoRepository]. Active queries filter `deletedAt IS NULL`;
/// [deleteTodo] performs a soft delete (records are preserved so focus
/// analytics survive). The domain never sees the `deletedAt` column.
class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<void> createTodo(Todo todo) async {
    await _db.into(_db.todos).insert(todo.toCompanion());
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    // Companion write (not replace) so the data-layer-only `deletedAt` is
    // preserved rather than clobbered.
    await (_db.update(_db.todos)..where((t) => t.id.equals(todo.id)))
        .write(todo.toCompanion());
  }

  @override
  Future<void> deleteTodo(String id) async {
    final nowIso = DateTime.now().toUtc().toIso8601String();
    await (_db.update(_db.todos)..where((t) => t.id.equals(id))).write(
      TodosCompanion(
        deletedAt: Value(nowIso),
        updatedAt: Value(nowIso),
      ),
    );
  }

  @override
  Future<Todo?> getTodoById(String id) async {
    final row = await (_db.select(_db.todos)
          ..where((t) => t.id.equals(id) & t.deletedAt.isNull()))
        .getSingleOrNull();
    return row?.toEntity();
  }

  @override
  Future<List<Todo>> getTodosForDay(String date) {
    return _dayQuery(date).get().then(_toEntities);
  }

  @override
  Stream<List<Todo>> watchTodosForDay(String date) {
    return _dayQuery(date).watch().map(_toEntities);
  }

  @override
  Future<List<Todo>> getTodosForMonth(String month) {
    return _monthQuery(month).get().then(_toEntities);
  }

  @override
  Stream<List<Todo>> watchTodosForMonth(String month) {
    return _monthQuery(month).watch().map(_toEntities);
  }

  SimpleSelectStatement<$TodosTable, TodoRow> _dayQuery(String date) {
    return _db.select(_db.todos)
      ..where((t) => t.scheduledDate.equals(date) & t.deletedAt.isNull())
      ..orderBy([
        (t) => OrderingTerm.asc(t.orderIndex),
        (t) => OrderingTerm.asc(t.createdAt),
      ]);
  }

  SimpleSelectStatement<$TodosTable, TodoRow> _monthQuery(String month) {
    return _db.select(_db.todos)
      ..where((t) => t.scheduledDate.like('$month-%') & t.deletedAt.isNull())
      ..orderBy([
        (t) => OrderingTerm.asc(t.scheduledDate),
        (t) => OrderingTerm.asc(t.orderIndex),
        (t) => OrderingTerm.asc(t.createdAt),
      ]);
  }

  List<Todo> _toEntities(List<TodoRow> rows) =>
      rows.map((r) => r.toEntity()).toList();
}
