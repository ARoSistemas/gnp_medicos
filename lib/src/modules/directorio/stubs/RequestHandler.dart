
enum Method { GET, POST }

class MyRequest {
  final String baseUrl;
  final String path;
  final Method method;
  final dynamic body;
  final Map<String, String>? headers;

  MyRequest({
    required this.baseUrl,
    required this.path,
    required this.method,
    this.body,
    this.headers,
  });
}

class MyResponse {
  final bool success;
  final dynamic response;

  MyResponse({required this.success, this.response});
}

class RequestHandler {
  static Future<MyResponse> httpRequest(MyRequest request) async {
    // Implementación mock: devuelve una respuesta exitosa con un cuerpo vacío.
    print('Ejecutando httpRequest (stub) para: ${request.path}');
    return MyResponse(success: true, response: {});
  }
}
