import 'package:tic_tac_toe/domain/entities/game_model.dart';
import 'package:tic_tac_toe/domain/enums/game_status.dart';
import 'package:tic_tac_toe/domain/enums/player.dart';
import 'package:tic_tac_toe/domain/game_logic/game_victory_condition.dart';
import 'package:tic_tac_toe/domain/value_objects/board_position.dart';

/// Use case responsible for executing a player's move on the board.
///
/// Validates the move, updates the board state, checks for
/// victory conditions, and switches turns.
class PlayMoveUseCase {

  /// Executes a move for the current player.
  ///
  /// Returns an updated [GameModel] with the move applied.
  /// If the move is invalid (already occupied or game is over),
  /// returns the model unchanged.
  GameModel call(BoardPosition position, GameModel currentState) {
    // Don't allow moves if the game is over
    if (currentState.status != GameStatus.playing) return currentState;

    // Don't allow moves on already occupied squares
    if (currentState.selectedBoardSquares.contains(position.index)) {
      return currentState;
    }

    // Don't allow moves if it's not the user's turn
    if (currentState.currentPlayer != Player.first) return currentState;

    // Apply the move
    currentState.firstBoardSquares.add(position.index);
    currentState.selectedBoardSquares.add(position.index);

    // Check for winner
    if (VictoryConditions.hasWinner(currentState.firstBoardSquares)) {
      currentState.status = GameStatus.playerWon;
      return currentState;
    }

    // Check for draw
    if (currentState.selectedBoardSquares.length == 9) {
      currentState.status = GameStatus.draw;
      return currentState;
    }

    // Switch turn
    currentState.currentPlayer = Player.second;
    return currentState;
  }
}
