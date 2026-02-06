import 'package:flutter/foundation.dart';


import 'package:tic_tac_toe/dependency_injection/dependency.dart';
import 'package:tic_tac_toe/domain/entities/game_model.dart';
import 'package:tic_tac_toe/domain/game_logic/game_victory_condition.dart';
import 'package:tic_tac_toe/domain/repository/ai_repository.dart';

class GameRule {

  final AiRepository _aiRepository = DependencyInjection().aiRepositoryImpl;
  
  GameModel _gameModel = GameModel();

  GameModel get gameModel => _gameModel;
  
  bool currentUserPlay = true;

  bool isGameTerminated = false;

  bool isGameDraw = false;
  
  // 1 = Player 1 (User), 2 = Player 2 (Opponent), null = No winner yet
  int? winnerPlayer;

  void play(int index) {
    if (isGameTerminated) return;

    debugPrint("VIEW_MODEL play index: $index / currentUserPlay : $currentUserPlay");

    if (currentUserPlay && !_gameModel.selectedBoardSquares.contains(index)) {
      _gameModel.firstBoardSquares.add(index);
      _gameModel.selectedBoardSquares.add(index);
      currentUserPlay = false;
      checkWinner();
    } 
  }

   Future<(bool, String?)> opponentPlay(List<int> opponnetBoardIndicies) async {
    final (index, error) = await _aiRepository.getNextMove(
      _gameModel.selectedBoardSquares, opponnetBoardIndicies);       
    
    if (error != null) {
      debugPrint("OLLAMA ERROR: $error");
      return (true, error);
    }

    if (index != null) {
      debugPrint("VIEW_MODEL opponentPlay index: $index / currentUserPlay : $currentUserPlay");

      if (_gameModel.selectedBoardSquares.contains(index)) {
         // Recursive retry might be dangerous if AI keeps sending bad moves, 
         // but keeping original logic structure for now.
         return await opponentPlay(opponnetBoardIndicies); 
      }

      _gameModel.secondBoardSquares.add(index);
      _gameModel.selectedBoardSquares.add(index);
      currentUserPlay = true;
      checkWinner();
    }
    return (false, null);
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