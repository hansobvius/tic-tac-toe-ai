abstract class AiRepository {
  /// Sends the current board state to the AI and returns the index of the next move.
  /// 
  /// [boardState] is a list of 9 integers where:
  /// 0 represents an empty space,
  /// 1 represents Player 1 (User),
  /// 2 represents Player 2 (AI).
  /// 
  /// Returns the index (0-8) of the move the AI wants to make.
  Future<int> getNextMove(List<int> boardState, List<int> yourMoves);
}
