/// Represents a valid position on the 3x3 board (index 0–8).
///
/// Encapsulates validation so invalid positions cannot propagate
/// through the domain layer.
class BoardPosition {
  final int index;

  BoardPosition(this.index) {
    if (index < 0 || index > 8) {
      throw ArgumentError('Board position must be between 0 and 8, got $index');
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoardPosition && other.index == index;

  @override
  int get hashCode => index.hashCode;

  @override
  String toString() => 'BoardPosition($index)';
}
