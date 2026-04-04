import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

import 'package:tic_tac_toe/domain/entities/game_model.dart';
import 'package:tic_tac_toe/domain/enums/game_status.dart';
import 'package:tic_tac_toe/domain/enums/player.dart';
import 'package:tic_tac_toe/domain/usecases/play_move_use_case.dart';
import 'package:tic_tac_toe/domain/usecases/opponent_play_use_case.dart';
import 'package:tic_tac_toe/domain/usecases/reset_game_use_case.dart';
import 'package:tic_tac_toe/domain/value_objects/board_position.dart';

part 'home_view_model.g.dart';

class HomeViewModel = HomeViewModelState with _$HomeViewModel;

abstract class HomeViewModelState with Store {

  final PlayMoveUseCase _playMoveUseCase;
  final OpponentPlayUseCase _opponentPlayUseCase;
  final ResetGameUseCase _resetGameUseCase;

  HomeViewModelState({
    required PlayMoveUseCase playMoveUseCase,
    required OpponentPlayUseCase opponentPlayUseCase,
    required ResetGameUseCase resetGameUseCase,
  })  : _playMoveUseCase = playMoveUseCase,
        _opponentPlayUseCase = opponentPlayUseCase,
        _resetGameUseCase = resetGameUseCase;

  GameModel _gameModel = GameModel();

  final String userSymbol = 'O';

  final String oponentSymbol = 'X';

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
  
  @observable
  String? errorMessage;

  @action
  Future setPlay({required int index}) async {

    // Execute the player's move via UseCase
    _gameModel = _playMoveUseCase(BoardPosition(index), _gameModel);
    
    // Sync UI state
    _syncBoardState();

    if (_gameModel.status == GameStatus.playerWon) {
      playerScore++;
      winner = "USER WON";
      isGameTerminated = true;
      debugPrint("USER WON");
      return;
    }

    if (_gameModel.status == GameStatus.draw) {
      winner = "GAME DRAW";
      isGameTerminated = true;
      debugPrint("GAME DRAW");
      return;
    }

    // If it's now the opponent's turn, execute AI move
    if (_gameModel.status == GameStatus.playing && 
        _gameModel.currentPlayer == Player.second) {
      opponnetThinking = true;
      errorMessage = null;

      final (updatedModel, failure) = await _opponentPlayUseCase(_gameModel);
      _gameModel = updatedModel;

      opponnetThinking = false;

      if (failure != null) {
        errorMessage = failure.message;
        debugPrint("HOME_VIEW_MODEL: AI Error: ${failure.message}");
        return;
      }

      // Sync UI state after opponent move
      _syncBoardState();

      if (_gameModel.status == GameStatus.opponentWon) {
        opponentScore++;
        winner = "OPPONENT WON";
        isGameTerminated = true;
        debugPrint("OPPONENT WON");
      } else if (_gameModel.status == GameStatus.draw) {
        winner = "GAME DRAW";
        isGameTerminated = true;
        debugPrint("GAME DRAW");
      }
    }
  }

  @action
  void resetGame() {
    _gameModel = _resetGameUseCase();
    userBoardState.clear();
    oponentBoardState.clear();
    isGameTerminated = false;
    currentUserPlay = true;
    winner = "";
    errorMessage = null;
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

  /// Syncs the observable UI lists with the domain model.
  void _syncBoardState() {
    userBoardState
      ..clear()
      ..addAll(_gameModel.firstBoardSquares);
    oponentBoardState
      ..clear()
      ..addAll(_gameModel.secondBoardSquares);
    currentUserPlay = _gameModel.currentPlayer == Player.first;
    isGameTerminated = _gameModel.status != GameStatus.playing;
  }
}