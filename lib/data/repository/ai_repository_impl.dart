

import '../../domain/repository/ai_repository.dart';
import '../datasources/ollama/ollama_service.dart';

class AiRepositoryImpl implements AiRepository {
  final OllamaService _ollamaService;

  AiRepositoryImpl(this._ollamaService);

  @override
  Future<(int?, String?)> getNextMove(List<int> boardState, List<int> yourMoves) {
    return _ollamaService.getNextMove(boardState, yourMoves);
  }
}
