import 'package:equatable/equatable.dart';

/// Immutable value object mirroring `contract.FocusPolicy`.
///
/// Free-form focus model: [defaultSessionMinutes] (25) is a prefill *suggestion*
/// used to seed `FocusSession.plannedSeconds`, not an enforced limit.
/// Value equality is provided via [Equatable].
class FocusPolicy extends Equatable {
  const FocusPolicy({
    this.defaultSessionMinutes = 25,
    this.userAdjustable = true,
    this.forcedBreaks = false,
    this.pomodoro = false,
  });

  /// Prefill suggestion for a session's planned duration, in minutes.
  final int defaultSessionMinutes;

  /// Whether the user may adjust the planned duration.
  final bool userAdjustable;

  /// Whether breaks are forced between sessions.
  final bool forcedBreaks;

  /// Whether a pomodoro cadence is enforced.
  final bool pomodoro;

  /// The suggested planned duration expressed in seconds
  /// (convenience for seeding `FocusSession.plannedSeconds`).
  int get defaultSessionSeconds => defaultSessionMinutes * 60;

  /// The default free-form policy approved for the MVP.
  static const FocusPolicy defaults = FocusPolicy();

  @override
  List<Object?> get props => [
        defaultSessionMinutes,
        userAdjustable,
        forcedBreaks,
        pomodoro,
      ];
}
