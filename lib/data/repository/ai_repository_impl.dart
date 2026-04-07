import 'package:tic_tac_toe/domain/failures/failure.dart';
import 'package:tic_tac_toe/domain/repository/ai_repository.dart';
import 'package:tic_tac_toe/domain/value_objects/board_position.dart';
import 'package:tic_tac_toe/data/datasources/ollama/ollama_service.dart';

/// Implements [AiRepository] by delegating to [OllamaService].
///
/// This is the adapter that converts between the Data layer (DTOs)
/// and the Domain layer (BoardPosition, Failure).
class AiRepositoryImpl implements AiRepository {
  final OllamaService _ollamaService;

  AiRepositoryImpl(this._ollamaService);

  @override
  Future<(BoardPosition?, Failure?)> getNextMove(
    List<int> boardState,
    List<int> yourMoves,
  ) async {
    final (dto, error) = await _ollamaService.getNextMove(boardState, yourMoves);

    if (error != null) {
      return (null, AiUnavailableFailure(error));
    }

    if (dto == null) {
      return (null, const AiUnavailableFailure('AI returned null response'));
    }

    // Convert DTO → Domain Value Object
    try {
      final position = BoardPosition(dto.move);
      return (position, null);
    } catch (e) {
      return (null, InvalidMoveFailure('AI returned invalid index: ${dto.move}'));
    }
  }
}
