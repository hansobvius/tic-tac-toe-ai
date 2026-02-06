import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tic_tac_toe/domain/service/interface_service.dart';

abstract class BaseService implements InterfaceService {
  
  @override
  Future<(Map<String, dynamic>? map, int statusCode, String? message)> post({
    required String path,
    required Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final baseUrl = dotenv.env['BASE_URL'];
      final port = dotenv.env['PORT'];

      if (baseUrl == null || port == null) {
        return (null, -1, "Missing environment configuration");
      }

      var uriString = "$baseUrl:$port/$path";
      
      final defaultHeaders = {'Content-Type': 'application/json'};
      if (headers != null) {
        defaultHeaders.addAll(headers);
      }

      final response = await http.post(
        Uri.parse(uriString),
        headers: defaultHeaders,
        body: body != null ? jsonEncode(body) : null,
      );

      try {
          if (response.body.isEmpty) {
             return (null, response.statusCode, "Empty response");
          }
          final decoded = jsonDecode(response.body);
          return (
            decoded is Map<String, dynamic> ? decoded : null, 
            response.statusCode, 
            null
          );
      } catch (e) {
        return (null, response.statusCode, "Invalid JSON response: ${response.body}");
      }

    } on SocketException catch (e) {
      return (null, -1, "Connection refused: ${e.message}");
    } on HttpException catch (e) {
      return (null, -1, e.message);
    } catch (e) {
      return (null, -1, "Unknown error: $e");
    }
  }
}