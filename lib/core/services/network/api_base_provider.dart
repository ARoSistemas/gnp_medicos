part of 'network_service.dart';

abstract class ApiBaseProvider extends GetConnect {
  abstract final String url;

  abstract final String contextPath;

  @override
  @mustCallSuper
  void onInit() {
    httpClient.baseUrl = '$url$contextPath';
    httpClient.timeout = const Duration(seconds: 20);
    httpClient
      ..addRequestModifier(_defaultRequestModifier)
      ..addResponseModifier(_defaultResponseModifier);
    super.onInit();
  }

  @override
  Future<Response<T>> get<T>(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
  }) async {
    final Response<T> response = await super.get(
      url,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
    );
    _handleResponseStatus(response);

    return response;
  }

  @override
  Future<Response<T>> post<T>(
    String? url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) async {
    final Response<T> response = await super.post(
      url,
      body,
      contentType: contentType,
      headers: headers,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    );
    _handleResponseStatus(response);

    return response;
  }

  @override
  Future<Response<T>> put<T>(
    String url,
    dynamic body, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) async {
    final Response<T> response = await super.put(
      url,
      body,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    );
    _handleResponseStatus(response);

    return response;
  }

  @override
  Future<Response<T>> delete<T>(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
  }) async {
    final Response<T> response = await super.delete(
      url,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
    );
    _handleResponseStatus(response);

    return response;
  }

  @override
  Future<Response<T>> patch<T>(
    String url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) async {
    final Response<T> response = await super.patch(
      url,
      body,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    );
    _handleResponseStatus(response);

    return response;
  }

  Future<Request<T>> _defaultRequestModifier<T>(Request<T> request) async {
    String bodyLog = 'Body: <File Content>';
    final Map<String, String> headers = request.headers;
    final String contentType =
        headers[HttpHeaders.contentTypeHeader]?.toLowerCase() ?? '';
    final String contentDisposition =
        headers[HttpHeaders.contentDisposition]?.toLowerCase() ?? '';

    final bool isFile =
        contentType.contains(ContentType.binary.value) ||
        contentType.contains('multipart/form-data') ||
        contentDisposition.contains('attachment');

    if (!isFile) {
      final List<int> bodyAsBytes = await request.bodyBytes
          .expand((element) => element)
          .toList();
      bodyLog = 'Body: ${utf8.decode(bodyAsBytes, allowMalformed: true)}';
    }

    logger.i(
      'Method: ${request.method.toUpperCase()}\n'
      'Url: ${request.url}\n'
      'Headers: ${request.headers}\n'
      '$bodyLog\n',
    );

    return request;
  }

  Response _defaultResponseModifier<T>(
    Request<T?> request,
    Response<T?> response,
  ) {
    final int? code = response.statusCode;
    String bodyLog = 'Body: <File Content>';

    final String contentType =
        response.headers?[HttpHeaders.contentTypeHeader]?.toLowerCase() ?? '';
    final String contentDisposition =
        response.headers?[HttpHeaders.contentDisposition]?.toLowerCase() ?? '';

    final bool isFileDownload =
        contentType.contains(ContentType.binary.value) ||
        contentType.contains('application/pdf') ||
        contentType.startsWith('image/') ||
        contentType.startsWith('video/') ||
        contentType.startsWith('audio/') ||
        contentDisposition.contains('attachment');

    if (!isFileDownload) {
      bodyLog = 'Body: ${response.bodyString}';
    }

    logger.i(
      'Response of ${response.request?.url}\n'
      'Status Code: $code\n'
      '$bodyLog\n',
    );

    return response;
  }

  void _handleResponseStatus(Response response) {
    if (response.hasError) {
      final HttpException exception = HttpException.fromStatusCode(
        response.statusCode ?? 500,
      );
      throw exception;
    }
  }
}
