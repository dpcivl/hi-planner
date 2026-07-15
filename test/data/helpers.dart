import 'package:drift/native.dart';
import 'package:hi_planner/data/sources/app_database.dart';
import 'package:hi_planner/domain/entities/focus_session.dart';
import 'package:hi_planner/domain/entities/todo.dart';
import 'package:hi_planner/domain/enums/focus_end_reason.dart';
import 'package:hi_planner/domain/enums/priority.dart';
import 'package:hi_planner/domain/enums/todo_status.dart';

/// Fresh in-memory database with dev seeding disabled.
AppDatabase newTestDb() => AppDatabase.forTesting(NativeDatabase.memory());

final _t0 = DateTime.utc(2026, 7, 15, 9);

/// Build a `Todo` entity with sensible defaults, overridable per field.
Todo makeTodo({
  required String id,
  String title = 'task',
  String scheduledDate = '2026-07-15',
  TodoStatus status = TodoStatus.pending,
  DateTime? completedAt,
  DateTime? startAt,
  DateTime? endAt,
  List<String> tags = const [],
  Priority priority = Priority.medium,
  int orderIndex = 0,
  int focusTotalSeconds = 0,
  int focusSessionCount = 0,
  String timezone = 'Asia/Seoul',
  bool isAllDay = false,
}) {
  return Todo(
    id: id,
    title: title,
    status: status,
    createdAt: _t0,
    updatedAt: _t0,
    completedAt: completedAt,
    scheduledDate: scheduledDate,
    startAt: startAt,
    endAt: endAt,
    timezone: timezone,
    isAllDay: isAllDay,
    priority: priority,
    tags: tags,
    focusTotalSeconds: focusTotalSeconds,
    focusSessionCount: focusSessionCount,
    orderIndex: orderIndex,
  );
}

/// Build a running `FocusSession` (endAt null) with sensible defaults.
FocusSession makeSession({
  required String id,
  required String todoId,
  String scheduledDate = '2026-07-15',
  DateTime? startAt,
  int? plannedSeconds = 1500,
  int durationSeconds = 0,
  int pausedSeconds = 0,
  String timezone = 'Asia/Seoul',
}) {
  return FocusSession(
    id: id,
    todoId: todoId,
    startAt: startAt ?? _t0,
    endAt: null,
    plannedSeconds: plannedSeconds,
    durationSeconds: durationSeconds,
    pausedSeconds: pausedSeconds,
    interrupted: false,
    endReason: FocusEndReason.completed,
    scheduledDate: scheduledDate,
    timezone: timezone,
    createdAt: _t0,
  );
}
