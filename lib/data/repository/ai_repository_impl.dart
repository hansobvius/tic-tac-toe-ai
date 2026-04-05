import 'package:tic_tac_toe/domain/failures/failure.dart';
import 'package:tic_tac_toe/domain/repository/ai_repository.dart';
import 'package:tic_tac_toe/domain/value_objects/board_position.dart';
import 'package:tic_tac_toe/data/datasources/ollama/ollama_service.dart';

class AiRepositoryImpl implements AiRepository {
  final OllamaService _ollamaService;

  AiRepositoryImpl(this._ollamaService);

  @override
  Future<(BoardPosition?, Failure?)> getNextMove(
    List<int> boardState,
    List<int> yourMoves,
  ) async {
    final (index, error) = await _ollamaService.getNextMove(boardState, yourMoves);

    if (error != null) {
      return (null, AiUnavailableFailure(error));
    }

    if (index == null) {
      return (null, const AiUnavailableFailure('AI returned null move'));
    }

    try {
      final position = BoardPosition(index);
      return (position, null);
    } catch (e) {
      return (null, InvalidMoveFailure('AI returned invalid index: $index'));
    }
  }
}
