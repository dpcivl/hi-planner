import '../entities/focus_policy.dart';
import '../entities/focus_session.dart';
import '../enums/focus_end_reason.dart';

/// Abstract data-layer boundary for the focus session lifecycle and the
/// active [FocusPolicy].
///
/// Presentation/application depend ONLY on this interface (per
/// `contract.Architecture`). The application-layer timer notifier owns the
/// clock; this repository persists lifecycle transitions and exposes analytics
/// reads. Instants are UTC; buckets are derived from the local `scheduledDate`.
abstract class FocusRepository {
  /// Read the active focus policy (25-min prefill suggestion by default).
  Future<FocusPolicy> getFocusPolicy();

  /// Start (persist) a new running session. [session.endAt] is null and
  /// [session.endReason] is provisional until [endSession].
  Future<void> startSession(FocusSession session);

  /// Persist pause/resume accounting for a running session: updated
  /// [FocusSession.durationSeconds] and [FocusSession.pausedSeconds]. Matched
  /// by [FocusSession.id].
  Future<void> updateSessionAccounting(FocusSession session);

  /// End a running session, recording [endReason] and [endAt] (plus the final
  /// [FocusSession.durationSeconds]/[FocusSession.pausedSeconds]/[FocusSession.interrupted]).
  /// autoStopped is used when durationSeconds reached plannedSeconds.
  Future<void> endSession(FocusSession session, FocusEndReason endReason);

  /// Fetch a single session by [id], or null if none exists.
  Future<FocusSession?> getSessionById(String id);

  /// One-shot fetch of all sessions for the todo [todoId], newest first.
  Future<List<FocusSession>> getSessionsForTodo(String todoId);

  /// Reactive stream of sessions for the todo [todoId] (e.g. to reflect a
  /// running/just-ended session in the UI). Emits on any change to the set.
  Stream<List<FocusSession>> watchSessionsForTodo(String todoId);

  /// One-shot fetch of all sessions on [date] ('YYYY-MM-DD') for daily
  /// focus analytics (totals / adherence).
  Future<List<FocusSession>> getSessionsForDay(String date);

  /// Reactive stream of sessions on [date] ('YYYY-MM-DD'). Emits on change.
  Stream<List<FocusSession>> watchSessionsForDay(String date);
}
