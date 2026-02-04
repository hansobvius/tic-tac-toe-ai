import 'package:tic_tac_toe/domain/entities/game_model.dart';
import 'package:tic_tac_toe/domain/game_logic/game_victory_condition.dart';

class GameRule {
  
  var gameModel = GameModel();
  
  bool currentUserPlay = true;

  bool isGameTerminated = false;

  bool isGameDraw = false;
  
  // 1 = Player 1 (User), 2 = Player 2 (Opponent), null = No winner yet
  int? winnerPlayer;

  void play(int index) {
    if (isGameTerminated) return;

    if (currentUserPlay && !gameModel.selectedBoardSquares.contains(index)) {
      gameModel.firstBoardSquares.add(index);
      gameModel.selectedBoardSquares.add(index);
      currentUserPlay = false;
      checkWinner();
    } else if (!currentUserPlay && !gameModel.selectedBoardSquares.contains(index)) {
      gameModel.secondBoardSquares.add(index);
      gameModel.selectedBoardSquares.add(index);
      currentUserPlay = true;
      checkWinner();
    }
  }

  void checkWinner() {
    if (hasWinnerNumbers(gameModel.firstBoardSquares)) {
      isGameTerminated = true;
      winnerPlayer = 1;
      // Ideally update wins in GameModel here if needed, but for now just marking termination
    }
    
    if (hasWinnerNumbers(gameModel.secondBoardSquares)) {
       isGameTerminated = true;
       winnerPlayer = 2;
    }

    if (gameModel.selectedBoardSquares.length == 9) {
      isGameTerminated = true;
      isGameDraw = true;
    }
  }

  void reset() {
    gameModel = GameModel();
    isGameTerminated = false;
    currentUserPlay = true;
    winnerPlayer = null;
    isGameDraw = false;
  }
}