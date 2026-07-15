import 'package:equatable/equatable.dart';

import '../enums/focus_end_reason.dart';

/// Sentinel used by [FocusSession.copyWith] to distinguish "argument omitted"
/// from "argument explicitly set to null" for nullable fields.
const Object _undefined = Object();

/// Immutable domain entity mirroring `contract.FocusSession` (v2).
///
/// Top-level record and source of truth for focus analytics
/// (planned-vs-actual adherence). Instants ([startAt], [endAt], [createdAt])
/// are UTC per contract. Value equality is provided via [Equatable].
class FocusSession extends Equatable {
  const FocusSession({
    required this.id,
    required this.todoId,
    required this.startAt,
    this.endAt,
    this.plannedSeconds,
    required this.durationSeconds,
    required this.pausedSeconds,
    required this.interrupted,
    required this.endReason,
    required this.scheduledDate,
    required this.timezone,
    required this.createdAt,
  });

  /// UUID identity.
  final String id;

  /// FK to the owning [Todo].
  final String todoId;

  /// Session start instant (UTC).
  final DateTime startAt;

  /// Session end instant (UTC); null while the session is still running.
  final DateTime? endAt;

  /// User-selected/suggested target seconds at start (per FocusPolicy);
  /// null if open-ended. autoStopped fires when [durationSeconds] reaches this.
  final int? plannedSeconds;

  /// Actual focused seconds, excluding paused time.
  final int durationSeconds;

  /// Total paused seconds.
  final int pausedSeconds;

  /// Whether the session was interrupted.
  final bool interrupted;

  /// Why the session ended.
  final FocusEndReason endReason;

  /// Local calendar day 'YYYY-MM-DD' the session belongs to.
  final String scheduledDate;

  /// IANA timezone.
  final String timezone;

  /// Creation instant (UTC).
  final DateTime createdAt;

  /// Whether the session is still running (no [endAt] recorded yet).
  bool get isRunning => endAt == null;

  /// Returns a copy with the given fields replaced. Nullable fields accept an
  /// explicit `null` (via the sentinel) to clear them.
  FocusSession copyWith({
    String? id,
    String? todoId,
    DateTime? startAt,
    Object? endAt = _undefined,
    Object? plannedSeconds = _undefined,
    int? durationSeconds,
    int? pausedSeconds,
    bool? interrupted,
    FocusEndReason? endReason,
    String? scheduledDate,
    String? timezone,
    DateTime? createdAt,
  }) {
    return FocusSession(
      id: id ?? this.id,
      todoId: todoId ?? this.todoId,
      startAt: startAt ?? this.startAt,
      endAt: endAt == _undefined ? this.endAt : endAt as DateTime?,
      plannedSeconds: plannedSeconds == _undefined
          ? this.plannedSeconds
          : plannedSeconds as int?,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      pausedSeconds: pausedSeconds ?? this.pausedSeconds,
      interrupted: interrupted ?? this.interrupted,
      endReason: endReason ?? this.endReason,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      timezone: timezone ?? this.timezone,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        todoId,
        startAt,
        endAt,
        plannedSeconds,
        durationSeconds,
        pausedSeconds,
        interrupted,
        endReason,
        scheduledDate,
        timezone,
        createdAt,
      ];
}
