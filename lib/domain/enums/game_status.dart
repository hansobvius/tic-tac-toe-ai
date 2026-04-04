/// Represents the current state of the game.
enum GameStatus {
  /// The game is still in progress.
  playing,

  /// Player 1 (User) has won.
  playerWon,

  /// Player 2 (Opponent/AI) has won.
  opponentWon,

  /// The game ended in a draw.
  draw,
}
