part of 'login_controller.dart';

/// Login Model
/// Represents the response from the login API.
/// Includes methods for JSON serialization and deserialization.
final class LoginModel {
  LoginModel({
    required this.code,
    required this.message,
    required this.payload,
    required this.name,
  });

  factory LoginModel.empty() => LoginModel(
    name: 'Login',
    code: 0,
    message: '',
    payload: <String, dynamic>{},
  );

  factory LoginModel.fromRaw(String raw) => LoginModel.fromMap(jsonDecode(raw));

  factory LoginModel.fromMap(Map<String, dynamic> json) => LoginModel(
    name: 'Login',
    code: json['code'] ?? 0,
    message: json['message'] ?? '',
    payload: json['payload'] ?? <String, dynamic>{},
  );

  /// Bridge between DTO and Model
  LoginEntity toEntity() => LoginEntity(
    code: code,
    message: message,
    user: payload.isNotEmpty ? UserModel.fromMap(payload) : UserModel.empty(),
  );

  LoginModel copyWith({
    String? name,
    int? code,
    String? message,
    Map<String, dynamic>? payload,
  }) => LoginModel(
    name: name ?? this.name,
    code: code ?? this.code,
    message: message ?? this.message,
    payload: payload ?? this.payload,
  );

  final String name;
  final int code;
  final String message;
  final Map<String, dynamic> payload;

  /// EndClass
}

class LoginEntity {
  LoginEntity({
    required this.code,
    required this.message,
    required this.user,
  });

  final int code;
  final String message;
  final UserModel user;
}

  //   static const String rHardCode = '''
  // {
  //     "code": 200,
  //     "message": "",
  //     "payload": {
  //         "token": {
  //             "jwt": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9....,
  //             "refreshtoken": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9...
  //         },
  //         "codigoFiliacion": "0000799393",
  //         "rfc": "AAGJ500515KP8",
  //         "nombreCompleto": "JUAN JACOBO INUKI MELOPI",
  //         "especialidad": "INFECTOLOGIA",
  //         "estado": "CIUDAD DE MEXICO",
  //         "circulo": "OMNIA",
  //         "tabulador": "",
  //         "estatus": "VI",
  //         "vigenciaConvenio": "01 agosto 2025 - 31 agosto 2025",
  //         "banVerConvenio": true,
  //         "banDescargaConvenio": true,
  //         "uid": null,
  //         "banVerAviso": false,
  //         "banConvenioActualizado": false
  //     }
  // }
  // ''';
  
