import 'dart:convert';

import 'package:drift/drift.dart';

import '../../domain/entities/todo.dart';
import '../../domain/enums/priority.dart';
import '../../domain/enums/todo_status.dart';
import '../sources/app_database.dart';
import 'data_mapping_exception.dart';

/// Maps between the Drift row/companion for the `Todos` table and the domain
/// [Todo] entity.
///
/// The generated [TodoRow] is the DTO (no redundant hand-written model).
/// Instants are hand-mapped to/from ISO-8601-UTC-`Z` TEXT; enums via their
/// `wireValue` / `Priority.level`; `tags` via JSON. The `deletedAt` column is
/// data-layer-only and never exposed to the domain: [toEntity] drops it, and
/// [toCompanion] leaves it absent so it is preserved across updates.
extension TodoRowMapper on TodoRow {
  Todo toEntity() {
    try {
      return Todo(
        id: id,
        title: title,
        notes: notes,
        status: TodoStatus.fromWire(status),
        createdAt: DateTime.parse(createdAt).toUtc(),
        updatedAt: DateTime.parse(updatedAt).toUtc(),
        completedAt:
            completedAt == null ? null : DateTime.parse(completedAt!).toUtc(),
        scheduledDate: scheduledDate,
        startAt: startAt == null ? null : DateTime.parse(startAt!).toUtc(),
        endAt: endAt == null ? null : DateTime.parse(endAt!).toUtc(),
        timezone: timezone,
        isAllDay: isAllDay,
        priority: Priority.fromLevel(priority),
        tags: (jsonDecode(tags) as List).cast<String>(),
        focusTotalSeconds: focusTotalSeconds,
        focusSessionCount: focusSessionCount,
        orderIndex: orderIndex,
      );
    } catch (e) {
      throw DataMappingException(entity: 'Todo', rowId: id, cause: e);
    }
  }
}

extension TodoEntityMapper on Todo {
  /// Full companion for insert/update. `deletedAt` is deliberately
  /// [Value.absent] so soft-delete state is never clobbered by a domain write.
  TodosCompanion toCompanion() {
    String? isoOrNull(DateTime? dt) => dt?.toUtc().toIso8601String();
    return TodosCompanion(
      id: Value(id),
      title: Value(title),
      notes: Value(notes),
      status: Value(status.wireValue),
      createdAt: Value(createdAt.toUtc().toIso8601String()),
      updatedAt: Value(updatedAt.toUtc().toIso8601String()),
      completedAt: Value(isoOrNull(completedAt)),
      scheduledDate: Value(scheduledDate),
      startAt: Value(isoOrNull(startAt)),
      endAt: Value(isoOrNull(endAt)),
      timezone: Value(timezone),
      isAllDay: Value(isAllDay),
      priority: Value(priority.level),
      tags: Value(jsonEncode(tags)),
      focusTotalSeconds: Value(focusTotalSeconds),
      focusSessionCount: Value(focusSessionCount),
      orderIndex: Value(orderIndex),
      // deletedAt: absent — preserved across writes.
    );
  }
}
