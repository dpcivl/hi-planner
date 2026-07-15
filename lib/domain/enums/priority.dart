/// Task priority mirroring `contract.Todo.priority` (enum-int 0..3).
///
/// The underlying int is the source of truth persisted by the data layer;
/// each variant maps to exactly one int via [level].
enum Priority {
  none(0),
  low(1),
  medium(2),
  high(3);

  const Priority(this.level);

  /// The persisted integer value (0..3) for this priority.
  final int level;

  /// Map a persisted int (0..3) to a [Priority].
  ///
  /// Throws [ArgumentError] if [level] is outside the closed 0..3 range.
  static Priority fromLevel(int level) {
    for (final p in Priority.values) {
      if (p.level == level) return p;
    }
    throw ArgumentError.value(level, 'level', 'Priority must be in 0..3');
  }
}
