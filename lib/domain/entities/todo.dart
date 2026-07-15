import 'package:equatable/equatable.dart';

import '../enums/priority.dart';
import '../enums/todo_status.dart';

/// Sentinel used by [Todo.copyWith] to distinguish "argument omitted" from
/// "argument explicitly set to null" for nullable fields.
const Object _undefined = Object();

/// Immutable domain entity mirroring `contract.Todo`.
///
/// Instants ([createdAt], [updatedAt], [completedAt], [startAt], [endAt]) are
/// UTC per contract; [scheduledDate] is a local calendar day 'YYYY-MM-DD' that
/// drives the 오늘/이번달 buckets together with [timezone] (IANA).
///
/// Value equality is provided via [Equatable]. The constructor is not `const`
/// because [tags] is wrapped in an unmodifiable copy so the "immutable" entity
/// cannot leak mutable state.
class Todo extends Equatable {
  Todo({
    required this.id,
    required this.title,
    this.notes,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.completedAt,
    required this.scheduledDate,
    this.startAt,
    this.endAt,
    required this.timezone,
    required this.isAllDay,
    required this.priority,
    required List<String> tags,
    required this.focusTotalSeconds,
    required this.focusSessionCount,
    required this.orderIndex,
  })  : assert(
          endAt == null || startAt == null || !endAt.isBefore(startAt),
          'endAt must be >= startAt',
        ),
        assert(
          (status == TodoStatus.done) == (completedAt != null),
          'completedAt is non-null iff status is done',
        ),
        tags = List.unmodifiable(tags);

  /// UUID identity.
  final String id;

  /// Non-empty title.
  final String title;

  /// Optional free-form notes.
  final String? notes;

  /// Lifecycle status.
  final TodoStatus status;

  /// Creation instant (UTC).
  final DateTime createdAt;

  /// Last-update instant (UTC).
  final DateTime updatedAt;

  /// Completion instant (UTC); non-null iff [status] is [TodoStatus.done].
  final DateTime? completedAt;

  /// Local calendar day 'YYYY-MM-DD'; drives 오늘/이번달 bucketing.
  final String scheduledDate;

  /// Optional timeline start instant (UTC).
  final DateTime? startAt;

  /// Optional timeline end instant (UTC); when present, `>= startAt`.
  final DateTime? endAt;

  /// IANA timezone (e.g. 'Asia/Seoul') used with [scheduledDate].
  final String timezone;

  /// Whether the todo spans the whole day (no specific time).
  final bool isAllDay;

  /// Priority (0..3).
  final Priority priority;

  /// Free-form tags (stored as an unmodifiable list).
  final List<String> tags;

  /// Denormalized cache: total focused seconds across sessions for this todo.
  final int focusTotalSeconds;

  /// Denormalized cache: number of focus sessions for this todo.
  final int focusSessionCount;

  /// Manual ordering index within a bucket.
  final int orderIndex;

  /// Returns a copy with the given fields replaced. Nullable fields accept an
  /// explicit `null` (via the sentinel) to clear them.
  Todo copyWith({
    String? id,
    String? title,
    Object? notes = _undefined,
    TodoStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? completedAt = _undefined,
    String? scheduledDate,
    Object? startAt = _undefined,
    Object? endAt = _undefined,
    String? timezone,
    bool? isAllDay,
    Priority? priority,
    List<String>? tags,
    int? focusTotalSeconds,
    int? focusSessionCount,
    int? orderIndex,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      notes: notes == _undefined ? this.notes : notes as String?,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt:
          completedAt == _undefined ? this.completedAt : completedAt as DateTime?,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      startAt: startAt == _undefined ? this.startAt : startAt as DateTime?,
      endAt: endAt == _undefined ? this.endAt : endAt as DateTime?,
      timezone: timezone ?? this.timezone,
      isAllDay: isAllDay ?? this.isAllDay,
      priority: priority ?? this.priority,
      tags: tags ?? this.tags,
      focusTotalSeconds: focusTotalSeconds ?? this.focusTotalSeconds,
      focusSessionCount: focusSessionCount ?? this.focusSessionCount,
      orderIndex: orderIndex ?? this.orderIndex,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        notes,
        status,
        createdAt,
        updatedAt,
        completedAt,
        scheduledDate,
        startAt,
        endAt,
        timezone,
        isAllDay,
        priority,
        tags,
        focusTotalSeconds,
        focusSessionCount,
        orderIndex,
      ];
}
