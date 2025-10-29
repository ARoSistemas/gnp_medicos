enum Method { get, post }

class MyRequest {
  MyRequest({
    required this.baseUrl,
    required this.path,
    required this.method,
    this.body,
    this.headers,
  });
  final String baseUrl;
  final String path;
  final Method method;
  final dynamic body;
  final Map<String, String>? headers;
}

class MyResponse {
  MyResponse({required this.success, this.response});

  factory MyResponse.fromJson(Map<String, dynamic> json) => MyResponse(
    success: json['success'] ?? true,
    response: json['response'] ?? [],
  );
  
  final bool success;
  final dynamic response;
}

class RequestHandler {
  static Future<MyResponse> httpRequest(MyRequest request) async =>
      MyResponse(success: true, response: {});
  // Implementación mock: devuelve una respuesta exitosa con un cuerpo vacío.
  // print('Ejecutando httpRequest (stub) para: ${request.path}');
}
