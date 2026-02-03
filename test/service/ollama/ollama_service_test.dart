import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/service/ollama/ollama_service.dart';

void main() {
  group('OllamaService Integration Test', () {
    late OllamaService ollamaService;

    setUp(() async {
      // Ensure you have this model pulled in your local ollama: `ollama pull llama3`
      // We pass the baseUrl directly to avoid needing to load .env in the test environment
      ollamaService = OllamaService(
        modelName: 'llama3',
        baseUrl: 'http://localhost:11434/api/generate',
      );
    });

    test('getNextMove returns a valid move index (0-8) from real Ollama instance', () async {
      // Arrange
      // 0 = Empty, 1 = Player 1 (Opponent), 2 = Player 2 (AI)
      // Scenario: Player 1 has played at index 0 (top-left).
      final boardState = [1, 0, 0, 0, 0, 0, 0, 0, 0]; 
      final aiMoves = <int>[];

      // Act
      print('----------------------------------------------------------------');
      print('Sending request to local Ollama (localhost:11434)...');
      print('Model: ${ollamaService.modelName}');
      print('----------------------------------------------------------------');
      
      try {
        final move = await ollamaService.getNextMove(boardState, aiMoves);
        print('Received move from Ollama: $move');

        // Assert
        expect(move, isNotNull);
        expect(move, greaterThanOrEqualTo(0));
        expect(move, lessThanOrEqualTo(8));
        
        // Ensure AI didn't pick an occupied spot (index 0 is taken)
        expect(boardState[move], 0, reason: 'AI picked an occupied spot at index $move');
      } catch (e) {
        print('Test failed with exception: $e');
        print('Make sure Ollama is running (`ollama serve`) and the model is pulled (`ollama pull llama3`).');
        rethrow;
      }
    }, timeout: Timeout(Duration(minutes: 2)));
  });
}
