part of 'network_service.dart';

abstract class ApiBaseProvider extends GetConnect {
  abstract final String url;
  abstract final String contextPath;
  Future<bool> onTokenExpired() => AuthRefreshService.refreshToken(this);

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
  }) => _handleRequestWithRetry(
    () => super.get<T>(
      url,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
    ),
  );

  @override
  Future<Response<T>> post<T>(
    String? url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) => _handleRequestWithRetry(
    () => super.post(
      url,
      body,
      contentType: contentType,
      headers: headers,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    ),
  );

  @override
  Future<Response<T>> put<T>(
    String url,
    dynamic body, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) => _handleRequestWithRetry(
    () => super.put(
      url,
      body,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    ),
  );

  @override
  Future<Response<T>> delete<T>(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
  }) => _handleRequestWithRetry(
    () => super.delete(
      url,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
    ),
  );

  @override
  Future<Response<T>> patch<T>(
    String url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) => _handleRequestWithRetry(
    () => super.patch(
      url,
      body,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    ),
  );

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

  Future<Response<T>> _handleRequestWithRetry<T>(
    Future<Response<T>> Function() request,
  ) async {
    Response<T> response = await request();
    if (response.statusCode == HttpStatus.unauthorized) {
      final bool refreshed = await onTokenExpired();
      if (refreshed) {
        response = await request();
      }
    }
    _handleResponseStatus(response);
    return response;
  }
}
