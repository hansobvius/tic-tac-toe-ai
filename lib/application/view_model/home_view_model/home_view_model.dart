import 'package:mobx/mobx.dart';

part 'home_view_model.g.dart';

class HomeViewModel = HomeViewModelState with _$HomeViewModel;

abstract class HomeViewModelState with Store {
  
  bool currentUserPlay = true;

  String userSymbol = 'O';

  String oponentSymbol = 'X';

  @observable
  List<List<int>> userBoardState = [];

  @observable
  List<List<int>> oponentBoardState = [];

  @action
  void setPlay({required int row, required int column}) {
    if (currentUserPlay) {
      userBoardState.add([row, column]);
      currentUserPlay = false;
    }
  }
}