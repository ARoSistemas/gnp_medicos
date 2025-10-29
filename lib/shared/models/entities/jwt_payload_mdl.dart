import 'dart:convert';

import 'package:medicos/shared/models/entities/claims_mdl.dart';

/// JWT Payload Entitie Model
/// Represents the payload of a JWT token.
/// Includes methods for JSON serialization and deserialization.
class JwtPayload {
  JwtPayload({
    required this.iss,
    required this.sub,
    required this.aud,
    required this.iat,
    required this.exp,
    required this.projectId,
    required this.uid,
    required this.claims,
  });

  factory JwtPayload.empty() => JwtPayload(
    iss: '',
    sub: '',
    aud: '',
    iat: 0,
    exp: 0,
    projectId: '',
    uid: '',
    claims: Claims.empty(),
  );

  factory JwtPayload.fromJson(Map<String, dynamic> json) => JwtPayload(
    iss: json['iss'],
    sub: json['sub'],
    aud: json['aud'],
    iat: json['iat'],
    exp: json['exp'],
    projectId: json['projectid'],
    uid: json['uid'],
    claims: Claims.fromJson(json['claims']),
  );

  Map<String, dynamic> toJson() => {
    'iss': iss,
    'sub': sub,
    'aud': aud,
    'iat': iat,
    'exp': exp,
    'projectId': projectId,
    'uid': uid,
    'claims': claims.toJson(),
  };

  final String iss;
  final String sub;
  final String aud;
  final int iat;
  final int exp;
  final String projectId;
  final String uid;
  final Claims claims;
}

/// Parses a JWT token and returns its payload as a [JwtPayload] object.
/// If the token is invalid, returns an empty [JwtPayload].
JwtPayload parseJwt(String token) {
  final List<String> parts = token.split('.');
  if (parts.length != 3) {
    return JwtPayload.empty();
  }

  final String payload = parts[1];
  final String normalized = base64Url.normalize(payload);
  final String decoded = utf8.decode(base64Url.decode(normalized));
  final Map<String, dynamic> payloadMap = jsonDecode(decoded);

  return JwtPayload.fromJson(payloadMap);
}
