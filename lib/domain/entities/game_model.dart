import 'package:tic_tac_toe/domain/enums/game_status.dart';
import 'package:tic_tac_toe/domain/enums/player.dart';

/// Represents the complete state of a Tic-Tac-Toe game.
///
/// This is a pure domain entity with no framework dependencies.
class GameModel {

  GameModel({
    List<int>? selectedBoardSquares,
    List<int>? firstBoardSquares,
    List<int>? secondBoardSquares,
    this.firstPlayerWins = 0,
    this.secondPlayerWins = 0,
    this.rounds = 0,
    this.status = GameStatus.playing,
    this.currentPlayer = Player.first,
  }) : selectedBoardSquares = selectedBoardSquares ?? [],
       firstBoardSquares = firstBoardSquares ?? [],
       secondBoardSquares = secondBoardSquares ?? [];

  /// All squares that have been selected by either player.
  List<int> selectedBoardSquares;

  /// Squares selected by Player 1 (User).
  List<int> firstBoardSquares;

  /// Squares selected by Player 2 (Opponent/AI).
  List<int> secondBoardSquares;

  int firstPlayerWins;

  int secondPlayerWins;

  int rounds;

  /// The current status of the game.
  GameStatus status;

  /// The player whose turn it is.
  Player currentPlayer;
}