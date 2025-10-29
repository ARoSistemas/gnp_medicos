import 'dart:convert';

import 'package:medicos/shared/models/entities/jwt_payload_mdl.dart';

/// Token Entitie Model
/// Represents the JWT and refresh token for user authentication.
/// Includes methods for JSON serialization and deserialization.
class Token {
  Token({
    required this.jwt,
    required this.refreshtoken,
    required this.jwtLogin,
  });

  factory Token.fromRaw(String raw) => Token.fromMap(json.decode(raw));

  factory Token.fromMap(Map<String, dynamic> json) {
    final String jwt = json['jwt'] ?? '';
    return Token(
      jwt: jwt,
      refreshtoken: json['refreshtoken'] ?? '',
      jwtLogin: jwt.split('.').length != 3
          ? JwtPayload.empty()
          : parseJwt(json['jwt']),
    );
  }

  factory Token.empty() => Token(
    jwt: '',
    refreshtoken: '',
    jwtLogin: JwtPayload.empty(),
  );

  Token copyWith({
    String? jwt,
    String? refreshtoken,
    JwtPayload? jwtLogin,
  }) => Token(
    jwt: jwt ?? this.jwt,
    refreshtoken: refreshtoken ?? this.refreshtoken,
    jwtLogin: jwtLogin ?? this.jwtLogin,
  );

  Map<String, dynamic> toJson() => {
    'jwt': jwt,
    'refreshtoken': refreshtoken,
    'jwtLogin': jwtLogin.toJson(),
  };

  final String jwt;
  final String refreshtoken;
  final JwtPayload jwtLogin;
}
