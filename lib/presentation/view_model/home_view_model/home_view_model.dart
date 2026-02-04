import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:tic_tac_toe/dependency_injection/dependency.dart';

import 'package:tic_tac_toe/domain/game_logic/game_rule.dart';


part 'home_view_model.g.dart';

class HomeViewModel = HomeViewModelState with _$HomeViewModel;

abstract class HomeViewModelState with Store {

  final GameRule _gameRule = DependencyInjection().gameRule;

  final String userSymbol = 'O';

  final String oponentSymbol = 'X';

  // Exposed for UI if needed, but logic is in specific board states
  List<int> get gameSelectedIndex => _gameRule.gameModel.selectedBoardSquares;

  String winner = "";

  @observable
  int playerScore = 0;

  @observable
  int opponentScore = 0;

  @observable
  bool opponnetThinking = false;
  
  @observable
  bool currentUserPlay = true;

  @observable
  bool isGameTerminated = false;

  @observable
  ObservableList<int> userBoardState = ObservableList<int>();

  @observable
  ObservableList<int> oponentBoardState = ObservableList<int>();

  @action
  Future setPlay({required int index}) async {
    debugPrint("VIEW_MODEL setPlay index: $index / currentUserPlay : $currentUserPlay");

    /// If the index selected already included into game list, the method skips
    
    _gameRule.play(index);
    
    // Sync state
    userBoardState
      ..clear()
      ..addAll(_gameRule.gameModel.firstBoardSquares);
    oponentBoardState
      ..clear()
      ..addAll(_gameRule.gameModel.secondBoardSquares);
    currentUserPlay = _gameRule.currentUserPlay;
    isGameTerminated = _gameRule.isGameTerminated;
    
    if (isGameTerminated) {
        if (_gameRule.winnerPlayer == 1) { 
          playerScore++;
          var label = "USER WON";
          winner = label;
          debugPrint(label);
        } else if (_gameRule.winnerPlayer == 2) {
          opponentScore++;
          var label = "OPPONENT WON";
          winner = label;
          debugPrint(label);
        } else if (_gameRule.isGameDraw) {
          debugPrint("GAME DRAW");
        } else {
          debugPrint("STATE NOT MAPPED");
        }
    }

    if (!_gameRule.currentUserPlay) {
      opponnetThinking = true;
      await _gameRule.opponentPlay(oponentBoardState).then((_) {
        oponentBoardState
            ..clear()
            ..addAll(_gameRule.gameModel.secondBoardSquares);
        opponnetThinking = false;
      });
    }
  }

  @action
  void resetGame() {
     _gameRule.reset();
    userBoardState.clear();
    oponentBoardState.clear();
    isGameTerminated = false;
    winner = "";
  }

  String getSymbol(int index) {
    if (userBoardState.contains(index)) {
      return userSymbol;
    }

    if (oponentBoardState.contains(index)) {
      return oponentSymbol;
    }

    return '';
  }
}