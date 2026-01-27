import 'package:tic_tac_toe/resources/extensions/list_extension.dart';

/// GAME RULES FOR WINNING CONDITIONS

/// Vertical condition
List<int> verticalFirstColumn  = [0,3,6];
List<int> verticalSecondColumn = [1,4,7];
List<int> verticalThirdColumn  = [2,5,8];

/// Horizontal condition
List<int> horizontalFirstCondition  = [0,1,2];
List<int> horizontalSecondCondition = [3,4,5];
List<int> horizontalThirdCondition  = [6,7,8];

/// Diagonal condition
List<int> diagonalFirstCondition  = [1,4,8];
List<int> diagonalSecondCondition = [2,4,6];

bool hasWinnerNumbers(List<int> list) {
  if (
    list.containsElements(verticalFirstColumn)       ||
    list.containsElements(verticalSecondColumn)      ||
    list.containsElements(verticalThirdColumn)       ||
    list.containsElements(horizontalFirstCondition)  ||
    list.containsElements(horizontalSecondCondition) ||
    list.containsElements(horizontalThirdCondition)  ||
    list.containsElements(diagonalFirstCondition)    ||
    list.containsElements(diagonalSecondCondition)
  ) {
    return true;
  }
  return false;
}
