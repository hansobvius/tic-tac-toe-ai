/// Base class for domain-level failures.
///
/// Failures represent expected error conditions in the business logic,
/// as opposed to unexpected exceptions from infrastructure.
abstract class Failure {
  final String message;

  const Failure(this.message);

  @override
  String toString() => '$runtimeType: $message';
}

/// The AI service is unavailable or returned an error.
class AiUnavailableFailure extends Failure {
  const AiUnavailableFailure(super.message);
}

/// The AI returned a move that is not valid on the current board.
class InvalidMoveFailure extends Failure {
  const InvalidMoveFailure(super.message);
}
