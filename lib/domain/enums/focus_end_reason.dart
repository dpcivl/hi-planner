/// Why a [FocusSession] ended.
///
/// Closed enum mirroring `contract.FocusSession.endReason`
/// (completed|interrupted|abandoned|autoStopped).
///
/// - [completed]: user finished the session normally.
/// - [interrupted]: user stopped mid-session (paused/interrupted flow).
/// - [abandoned]: session dropped without an explicit finish.
/// - [autoStopped]: durationSeconds reached plannedSeconds and the timer
///   auto-stopped (per FocusPolicy suggestion).
enum FocusEndReason {
  completed,
  interrupted,
  abandoned,
  autoStopped;

  /// The stable string used for persistence / serialization.
  String get wireValue => name;

  /// Parse a persisted string back into a [FocusEndReason].
  static FocusEndReason fromWire(String value) =>
      FocusEndReason.values.byName(value);
}
