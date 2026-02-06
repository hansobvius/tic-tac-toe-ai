abstract interface class NetworkInterface {

  Future<(Map<String, dynamic>? map, int statusCode, String? message)> post({
    required String path,
    required Map<String, dynamic>? body,
    Map<String, String>? headers,
  });
}