import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'home_view_model.g.dart';

class HomeViewModel = HomeViewModelState with _$HomeViewModel;

abstract class HomeViewModelState with Store {
  
  bool currentUserPlay = true;

  String userSymbol = 'O';

  String oponentSymbol = 'X';

  List<int> gameSelectedIndex = [];

  @observable
  List<int> userBoardState = [];

  @observable
  List<int> oponentBoardState = [];

  @action
  void setPlay({required int index}) {
    debugPrint("VIEW_MODEL setPlay index: $index / currentUserPlay : $currentUserPlay");
    if (currentUserPlay && !gameSelectedIndex.contains(index)) {
      userBoardState.add(index);
      gameSelectedIndex.add(index);
      currentUserPlay = false;
    }
    if (!currentUserPlay && !gameSelectedIndex.contains(index)) {
      oponentBoardState.add(index);
      gameSelectedIndex.add(index);
      currentUserPlay = true;
    }
  }
}