part of 'network_service.dart';

abstract class ApiException implements Exception {
  abstract final String message;
}

class FetchDataException implements ApiException {
  @override
  final String message = 'Error de conexión. Revisa tu internet.';
}
