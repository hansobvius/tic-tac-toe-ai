import 'package:tic_tac_toe/domain/entities/game_model.dart';

/// Use case responsible for resetting the game to its initial state.
class ResetGameUseCase {

  /// Returns a fresh [GameModel] with all state cleared.
  GameModel call() => GameModel();
}
