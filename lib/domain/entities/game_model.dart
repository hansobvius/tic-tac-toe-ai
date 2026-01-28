class GameModel {

  GameModel({
    required this.selectedBoardSquares,
    required this.firstBoardSquares,
    required this.secondBoardSquares,
    required this.firstPlayerWins,
    required this.secondPlayerWins,
    required this.rounds
  });

  List<int> selectedBoardSquares = [];
  List<int> firstBoardSquares = [];
  List<int> secondBoardSquares = [];
  int firstPlayerWins = 0;
  int secondPlayerWins = 0;
  int rounds = 0;
}