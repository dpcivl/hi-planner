import 'package:drift/drift.dart';

import '../../domain/entities/focus_session.dart';
import '../../domain/enums/focus_end_reason.dart';
import '../sources/app_database.dart';
import 'data_mapping_exception.dart';

/// Maps between the Drift row/companion for the `FocusSessions` table and the
/// domain [FocusSession] entity. Instants are hand-mapped to/from
/// ISO-8601-UTC-`Z` TEXT; `endReason` via its `wireValue`.
extension FocusSessionRowMapper on FocusSessionRow {
  FocusSession toEntity() {
    try {
      return FocusSession(
        id: id,
        todoId: todoId,
        startAt: DateTime.parse(startAt).toUtc(),
        endAt: endAt == null ? null : DateTime.parse(endAt!).toUtc(),
        plannedSeconds: plannedSeconds,
        durationSeconds: durationSeconds,
        pausedSeconds: pausedSeconds,
        interrupted: interrupted,
        endReason: FocusEndReason.fromWire(endReason),
        scheduledDate: scheduledDate,
        timezone: timezone,
        createdAt: DateTime.parse(createdAt).toUtc(),
      );
    } catch (e) {
      throw DataMappingException(
          entity: 'FocusSession', rowId: id, cause: e);
    }
  }
}

extension FocusSessionEntityMapper on FocusSession {
  FocusSessionsCompanion toCompanion() {
    return FocusSessionsCompanion(
      id: Value(id),
      todoId: Value(todoId),
      startAt: Value(startAt.toUtc().toIso8601String()),
      endAt: Value(endAt?.toUtc().toIso8601String()),
      createdAt: Value(createdAt.toUtc().toIso8601String()),
      plannedSeconds: Value(plannedSeconds),
      durationSeconds: Value(durationSeconds),
      pausedSeconds: Value(pausedSeconds),
      interrupted: Value(interrupted),
      endReason: Value(endReason.wireValue),
      scheduledDate: Value(scheduledDate),
      timezone: Value(timezone),
    );
  }
}
