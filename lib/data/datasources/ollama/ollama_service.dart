import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:tic_tac_toe/core/network/network_client.dart';

class OllamaService extends NetworkClient{
  final String modelName;

  OllamaService({this.modelName = 'llama3'});

  Future<(int?, String?)> getNextMove(List<int> boardState, List<int> yourMoves,
      {bool isRetry = false}) async {
    final prompt = _generatePrompt(boardState, yourMoves);

    final (jsonResponse, statusCode, message) = await post(
      path: 'api/generate',
      body: {
        'model': modelName,
        'prompt': prompt,
        'stream': false,
        'format': 'json',
      },
    );

    if (statusCode == 200 && jsonResponse != null) {
      if (jsonResponse.containsKey('response')) {
        final responseText = jsonResponse['response'];
        try {
          final move = _parseMove(responseText);
          return (move, null);
        } catch (e) {
          return (null, 'Failed to parse AI response: $responseText');
        }
      }
      return (null, 'Key "response" not found in JSON');
    } else if (statusCode == 404 && !isRetry) {
      // Model not found, try to pull it
      debugPrint('Model $modelName not found. Attempting to pull...');
      final pullSuccess = await _pullModel();
      if (pullSuccess) {
        debugPrint('Model pulled successfully. Retrying move...');
        return getNextMove(boardState, yourMoves, isRetry: true);
      } else {
        return (null, 'Model not found and failed to pull $modelName.');
      }
    } else {
      return (
        null,
        'Failed to get move from Ollama: $statusCode - ${message ?? "Unknown error"}'
      );
    }
  }

  Future<bool> _pullModel() async {
    final (_, statusCode, _) = await post(
      path: 'api/pull',
      body: {
        'name': modelName,
        'stream': false,
      },
    );

    if (statusCode == 200) {
      return true;
    } else {
      debugPrint('Failed to pull model: $statusCode');
      return false;
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
