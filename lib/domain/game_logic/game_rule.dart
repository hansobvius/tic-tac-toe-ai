import 'package:tic_tac_toe/data/repository/ai_repository_impl.dart';
import 'package:tic_tac_toe/dependency_injection/dependency.dart';
import 'package:tic_tac_toe/domain/entities/game_model.dart';
import 'package:tic_tac_toe/domain/game_logic/game_victory_condition.dart';
import 'package:tic_tac_toe/domain/repository/ai_repository.dart';

class GameRule {

  final AiRepositoryImpl _aiRepositoryImpl = DependencyInjection().aiRepositoryImpl;
  
  GameModel _gameModel = GameModel();

  GameModel get gameModel => _gameModel;
  
  bool currentUserPlay = true;

  bool isGameTerminated = false;

  bool isGameDraw = false;
  
  // 1 = Player 1 (User), 2 = Player 2 (Opponent), null = No winner yet
  int? winnerPlayer;

  void play(int index) {
    if (isGameTerminated) return;

    if (currentUserPlay && !_gameModel.selectedBoardSquares.contains(index)) {
      _gameModel.firstBoardSquares.add(index);
      _gameModel.selectedBoardSquares.add(index);
      currentUserPlay = false;
      checkWinner();
    } 
    // else if (!currentUserPlay && !_gameModel.selectedBoardSquares.contains(index)) {
    //   _gameModel.secondBoardSquares.add(index);
    //   _gameModel.selectedBoardSquares.add(index);
    //   currentUserPlay = true;
    //   checkWinner();
    // }
  }

  Future<int> opponentPlay(List<int> opponnetBoardIndicies) async {
    var index = await _aiRepositoryImpl.getNextMove(
      _gameModel.selectedBoardSquares, opponnetBoardIndicies);
    _gameModel.secondBoardSquares.add(index);
    _gameModel.selectedBoardSquares.add(index);
    currentUserPlay = true;
    checkWinner();
    return index;
  }

  void checkWinner() {
    if (hasWinnerNumbers(_gameModel.firstBoardSquares)) {
      isGameTerminated = true;
      winnerPlayer = 1;
      // Ideally update wins in GameModel here if needed, but for now just marking termination
    }
    
    if (hasWinnerNumbers(_gameModel.secondBoardSquares)) {
       isGameTerminated = true;
       winnerPlayer = 2;
    }

    if (_gameModel.selectedBoardSquares.length == 9) {
      isGameTerminated = true;
      isGameDraw = true;
    }
  }

  void reset() {
    _gameModel = GameModel();
    isGameTerminated = false;
    currentUserPlay = true;
    winnerPlayer = null;
    isGameDraw = false;
  }
}