import '../../domain/repository/ai_repository.dart';
import '../../service/ollama/ollama_service.dart';

class AiRepositoryImpl implements AiRepository {
  final OllamaService _ollamaService;

  AiRepositoryImpl(this._ollamaService);

  @override
  Future<int> getNextMove(List<int> boardState, List<int> yourMoves) {
    return _ollamaService.getNextMove(boardState, yourMoves);
  }
}
