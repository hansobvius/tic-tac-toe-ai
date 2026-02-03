import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OllamaService {
  final String _baseUrl;
  final String modelName;

  OllamaService({this.modelName = 'llama3', String? baseUrl})
      : _baseUrl = baseUrl ??
            'http://localhost:${dotenv.env['PORT'] ?? '11434'}/api/generate';


  Future<int> getNextMove(List<int> boardState, List<int> yourMoves) async {
    final prompt = _generatePrompt(boardState, yourMoves);
    
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'model': modelName,
          'prompt': prompt,
          'stream': false,
          'format': 'json',
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final responseText = jsonResponse['response'];
        return _parseMove(responseText);
      } else {
        throw Exception('Failed to get move from Ollama: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error communicating with Ollama: $e');
    }
  }

  String _generatePrompt(List<int> boardState, List<int> yourMoves) {
    return '''
You are playing Tic Tac Toe. You are Player 2 (O).
The current board state is represented as a list of 9 integers where:
0 = Empty
1 = Player 1 (Opponent)
2 = Player 2 (You)

The Board State represents the already choosen indicies, and you cannot choose any of them.
Current Board State: $boardState
The Your Moves Represents your previously moves.
Current Your Moves: $yourMoves
Indices:
0 1 2
3 4 5
6 7 8

Analyze the board.
1. Check if you can win in this move.
2. Check if you need to block the opponent from winning.
3. Otherwise, pick the best available strategic move (center, corners, etc).

Return ONLY a JSON object with a single field "move" containing the index (0-8) of your move.
Example: {"move": 4}
''';
  }

  int _parseMove(String responseText) {
    try {
      // Clean up the response in case there's extra text (though format: json should prevent this)
      final cleanJson = responseText.trim();
      final Map<String, dynamic> data = jsonDecode(cleanJson);
      if (data.containsKey('move')) {
        return data['move'] as int;
      }
      throw Exception('Response did not contain "move" field');
    } catch (e) {
      throw Exception('Failed to parse AI response: $responseText');
    }
  }
}
