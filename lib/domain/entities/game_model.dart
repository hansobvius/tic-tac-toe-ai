class GameModel {

  GameModel({
    List<int>? selectedBoardSquares,
    List<int>? firstBoardSquares,
    List<int>? secondBoardSquares,
    this.firstPlayerWins = 0,
    this.secondPlayerWins = 0,
    this.rounds = 0,
  }) : selectedBoardSquares = selectedBoardSquares ?? [],
       firstBoardSquares = firstBoardSquares ?? [],
       secondBoardSquares = secondBoardSquares ?? [];

  List<int> selectedBoardSquares;

  List<int> firstBoardSquares;

  List<int> secondBoardSquares;

  int firstPlayerWins;

  int secondPlayerWins;

  int rounds;
}