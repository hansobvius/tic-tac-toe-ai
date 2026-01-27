import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:tic_tac_toe/domain/game_logic/game_victory_condition.dart';


part 'home_view_model.g.dart';

class HomeViewModel = HomeViewModelState with _$HomeViewModel;

abstract class HomeViewModelState with Store {

  final String userSymbol = 'O';

  final String oponentSymbol = 'X';

  final List<int> gameSelectedIndex = [];
  
  bool currentUserPlay = true;

  bool isGameTerminated = false;

  @observable
  ObservableList<int> userBoardState = ObservableList<int>();

  @observable
  ObservableList<int> oponentBoardState = ObservableList<int>();

  @action
  void setPlay({required int index}) {
    debugPrint("VIEW_MODEL setPlay index: $index / currentUserPlay : $currentUserPlay");
    if (currentUserPlay && !gameSelectedIndex.contains(index)) {
      userBoardState.add(index);
      gameSelectedIndex.add(index);
      currentUserPlay = false;
      isWinner();
    }
    if (!currentUserPlay && !gameSelectedIndex.contains(index)) {
      oponentBoardState.add(index);
      gameSelectedIndex.add(index);
      currentUserPlay = true;
      isWinner();
    }
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
  
  void isWinner() {
    if (hasWinnerNumbers(userBoardState)) {
      debugPrint("USER WON");
      isGameTerminated = true;
    }

    if (hasWinnerNumbers(oponentBoardState)) {
      debugPrint("OPPONENT WON");
      isGameTerminated = true;
    }
  }
}
