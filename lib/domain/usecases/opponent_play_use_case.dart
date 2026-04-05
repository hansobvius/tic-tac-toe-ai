import 'package:flutter/foundation.dart';

import 'package:tic_tac_toe/domain/entities/game_model.dart';
import 'package:tic_tac_toe/domain/enums/game_status.dart';
import 'package:tic_tac_toe/domain/enums/player.dart';
import 'package:tic_tac_toe/domain/failures/failure.dart';
import 'package:tic_tac_toe/domain/game_logic/game_victory_condition.dart';
import 'package:tic_tac_toe/domain/repository/ai_repository.dart';

/// Use case responsible for executing the AI opponent's move.
///
/// Delegates to [AiRepository] to get the next move, validates it,
/// and updates the board state accordingly.
class OpponentPlayUseCase {
  final AiRepository _aiRepository;

  OpponentPlayUseCase({required AiRepository aiRepository})
      : _aiRepository = aiRepository;

  /// Executes the opponent's move.
  ///
  /// Returns a tuple of (updated [GameModel], optional [Failure]).
  /// On success, the model has the opponent's move applied.
  /// On failure, the model is returned unchanged with a [Failure] describing the error.
  Future<(GameModel, Failure?)> call(GameModel currentState) async {
    final (position, failure) = await _aiRepository.getNextMove(
      currentState.selectedBoardSquares,
      currentState.secondBoardSquares,
    );

    if (failure != null) {
      debugPrint('OPPONENT_PLAY: ${failure.message}');
      return (currentState, failure);
    }

    if (position == null) {
      return (currentState, const AiUnavailableFailure('AI returned no move'));
    }

    // If AI returned an already occupied square, retry
    if (currentState.selectedBoardSquares.contains(position.index)) {
      debugPrint('OPPONENT_PLAY: AI returned occupied index ${position.index}, retrying...');
      return call(currentState);
    }

    // Apply the move
    currentState.secondBoardSquares.add(position.index);
    currentState.selectedBoardSquares.add(position.index);

    // Check for winner
    if (VictoryConditions.hasWinner(currentState.secondBoardSquares)) {
      currentState.status = GameStatus.opponentWon;
      return (currentState, null);
    }

    // Check for draw
    if (currentState.selectedBoardSquares.length == 9) {
      currentState.status = GameStatus.draw;
      return (currentState, null);
    }

    // Switch turn back to player
    currentState.currentPlayer = Player.first;
    return (currentState, null);
  }
}
