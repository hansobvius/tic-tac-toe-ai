import 'package:tic_tac_toe/domain/failures/failure.dart';
import 'package:tic_tac_toe/domain/value_objects/board_position.dart';

/// Contract for AI move generation.
///
/// Defined in the domain layer — implementations live in the data layer.
abstract class AiRepository {
  /// Sends the current board state to the AI and returns the next move.
  ///
  /// [boardState] contains the indices of all occupied squares.
  /// [yourMoves] contains the indices of the AI's own moves.
  ///
  /// Returns a [BoardPosition] on success, or a [Failure] on error.
  Future<(BoardPosition?, Failure?)> getNextMove(
    List<int> boardState,
    List<int> yourMoves,
  );
}
