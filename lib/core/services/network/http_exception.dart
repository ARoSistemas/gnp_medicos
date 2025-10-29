part of 'network_service.dart';

class HttpException implements ApiException {
  HttpException({this.code = 0});

  factory HttpException.fromStatusCode(int statusCode) {
    switch (statusCode) {
      case HttpStatus.badRequest: // 400
        return BadRequestException();
      case HttpStatus.unauthorized: // 401
        return UnauthorizedException();
      case HttpStatus.forbidden: // 403
        return ForbiddenException();
      case HttpStatus.notFound: // 404
        return NotFoundException();
      case HttpStatus.methodNotAllowed: // 405
        return MethodNotAllowedException();
      case HttpStatus.requestTimeout: // 408
        return RequestTimeoutException();
      case HttpStatus.conflict: // 409
        return ConflictException();
      case HttpStatus.unsupportedMediaType: // 415
        return UnsupportedMediaTypeException();
      case HttpStatus.internalServerError: // 500
        return InternalServerException();
      case HttpStatus.badGateway: // 502
        return BadGatewayException();
      case HttpStatus.serviceUnavailable: // 503
        return ServiceUnavailableException();
      case HttpStatus.gatewayTimeout: // 504
        return GatewayTimeoutException();
      default:
        return HttpException(code: statusCode);
    }
  }

  final int code;

  @override
  String get message => 'Error de código http';
}

class BadRequestException extends HttpException {
  BadRequestException() : super(code: HttpStatus.badRequest);

  @override
  String get message => 'Petición inválida.';
}

class UnauthorizedException extends HttpException {
  UnauthorizedException() : super(code: HttpStatus.unauthorized);

  @override
  String get message => 'No autorizado. Inicia sesión de nuevo.';
}

class ForbiddenException extends HttpException {
  ForbiddenException() : super(code: HttpStatus.forbidden);

  @override
  String get message => 'Acceso prohibido.';
}

class NotFoundException extends HttpException {
  NotFoundException() : super(code: HttpStatus.notFound);

  @override
  String get message => 'Recurso no encontrado.';
}

class MethodNotAllowedException extends HttpException {
  MethodNotAllowedException() : super(code: HttpStatus.methodNotAllowed);

  @override
  String get message => 'Método no permitido.';
}

class RequestTimeoutException extends HttpException {
  RequestTimeoutException() : super(code: HttpStatus.requestTimeout);

  @override
  String get message => 'Tiempo de espera de la petición agotado.';
}

class ConflictException extends HttpException {
  ConflictException() : super(code: HttpStatus.conflict);

  @override
  String get message =>
      'Conflicto. El recurso ya existe o '
      'hay un conflicto con el estado actual del recurso.';
}

class UnsupportedMediaTypeException extends HttpException {
  UnsupportedMediaTypeException()
    : super(
        code: HttpStatus.unsupportedMediaType,
      );

  @override
  String get message => 'Tipo de medio no soportado.';
}

class InternalServerException extends HttpException {
  InternalServerException() : super(code: HttpStatus.internalServerError);

  @override
  String get message => 'Error interno del servidor.';
}

class BadGatewayException extends HttpException {
  BadGatewayException() : super(code: HttpStatus.badGateway);

  @override
  String get message => 'Error de pasarela incorrecta.';
}

class ServiceUnavailableException extends HttpException {
  ServiceUnavailableException() : super(code: HttpStatus.serviceUnavailable);

  @override
  String get message => 'Servicio no disponible.';
}

class GatewayTimeoutException extends HttpException {
  GatewayTimeoutException() : super(code: HttpStatus.gatewayTimeout);

  @override
  String get message => 'Tiempo de espera agotado.';
}
