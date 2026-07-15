/// Lifecycle status of a [Todo].
///
/// Closed enum mirroring `contract.Todo.status` (pending|inProgress|done|canceled).
enum TodoStatus {
  pending,
  inProgress,
  done,
  canceled;

  /// The stable string used for persistence / serialization (matches the enum
  /// name so the data layer can round-trip via [TodoStatus.values.byName]).
  String get wireValue => name;

  /// Parse a persisted string back into a [TodoStatus].
  static TodoStatus fromWire(String value) => TodoStatus.values.byName(value);
}
