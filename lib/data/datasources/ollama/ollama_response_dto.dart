import 'dart:convert';

/// Data Transfer Object for the Ollama API response.
///
/// Represents the raw structure of the JSON returned by the AI.
/// Lives in the Data layer because it reflects an external API format,
/// not a domain concept.
class OllamaResponseDTO {
  final int move;

  const OllamaResponseDTO({required this.move});

  /// Creates an [OllamaResponseDTO] from the raw JSON response text.
  ///
  /// The Ollama API returns a JSON object with a "response" field
  /// containing a stringified JSON like: {"move": 4}
  ///
  /// Throws [FormatException] if the JSON is malformed or missing the "move" field.
  factory OllamaResponseDTO.fromResponseText(String responseText) {
    final cleanJson = responseText.trim();
    final Map<String, dynamic> data = jsonDecode(cleanJson);

    if (!data.containsKey('move')) {
      throw const FormatException('Response did not contain "move" field');
    }

    return OllamaResponseDTO(move: data['move'] as int);
  }

  @override
  String toString() => 'OllamaResponseDTO(move: $move)';
}
