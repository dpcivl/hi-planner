/// Thrown when a persisted row cannot be mapped to a domain entity because a
/// stored value is corrupt/out of range (e.g. an unknown enum wire string or a
/// priority outside 0..3). Wraps the underlying error so a single bad row
/// surfaces as a clear, identifiable failure instead of a raw `ArgumentError`
/// bubbling through a repository stream.
class DataMappingException implements Exception {
  DataMappingException({
    required this.entity,
    required this.rowId,
    required this.cause,
  });

  /// The target entity type (e.g. 'Todo', 'FocusSession').
  final String entity;

  /// The offending row's primary key.
  final String rowId;

  /// The underlying error (e.g. an `ArgumentError` from `fromWire`).
  final Object cause;

  @override
  String toString() =>
      'DataMappingException($entity id=$rowId): $cause';
}
