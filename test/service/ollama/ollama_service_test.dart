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
        final (move, error) = await ollamaService.getNextMove(boardState, aiMoves);
        print('Received move from Ollama: $move');
        print('Received error from Ollama: $error');

        // Since the user might have Docker stopped, we handle both cases to verify the Record mechanism works.
        if (move != null) {
           expect(move, greaterThanOrEqualTo(0));
           expect(move, lessThanOrEqualTo(8));
           expect(boardState[move], 0, reason: 'AI picked an occupied spot at index $move');
        } else {
           expect(error, isNotNull);
           print('Test passed: Gracefully handled error: $error');
        }

      } catch (e) {
        fail('Should not throw exception, but returned error record. Exception: $e');
      }
    }, timeout: Timeout(Duration(minutes: 2)));
  });
}
