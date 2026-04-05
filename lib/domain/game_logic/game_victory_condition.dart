import 'package:tic_tac_toe/resources/extensions/list_extension.dart';

/// Encapsulates all winning conditions for Tic-Tac-Toe.
///
/// Uses [static const] to prevent accidental mutation and
/// provide a single source of truth for victory validation.
class VictoryConditions {
  VictoryConditions._();

  /// Vertical winning combinations.
  static const List<int> verticalFirstColumn  = [0, 3, 6];
  static const List<int> verticalSecondColumn = [1, 4, 7];
  static const List<int> verticalThirdColumn  = [2, 5, 8];

  /// Horizontal winning combinations.
  static const List<int> horizontalFirstRow  = [0, 1, 2];
  static const List<int> horizontalSecondRow = [3, 4, 5];
  static const List<int> horizontalThirdRow  = [6, 7, 8];

  /// Diagonal winning combinations.
  static const List<int> diagonalFirst  = [0, 4, 8];
  static const List<int> diagonalSecond = [2, 4, 6];

  /// All possible winning combinations.
  static const List<List<int>> allConditions = [
    verticalFirstColumn,
    verticalSecondColumn,
    verticalThirdColumn,
    horizontalFirstRow,
    horizontalSecondRow,
    horizontalThirdRow,
    diagonalFirst,
    diagonalSecond,
  ];

  /// Checks if the given [moves] contain any winning combination.
  static bool hasWinner(List<int> moves) {
    return allConditions.any((condition) => moves.containsElements(condition));
  }
}
