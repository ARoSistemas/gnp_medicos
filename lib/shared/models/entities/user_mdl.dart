import 'dart:convert';

import 'package:medicos/shared/models/entities/jwt_payload_mdl.dart';
import 'package:medicos/shared/models/entities/token_mdl.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/domain/dtos/permissions_dto.dart';

/// User Entitie Model
/// Represents the user details returned from the login API.
/// Includes methods for JSON serialization and deserialization.
class UserModel {
  UserModel({
    required this.token,
    required this.codigoFiliacion,
    required this.rfc,
    required this.nombreCompleto,
    required this.especialidad,
    required this.estado,
    required this.circulo,
    required this.tabulador,
    required this.estatus,
    required this.vigenciaConvenio,
    required this.banVerConvenio,
    required this.banDescargaConvenio,
    required this.uid,
    required this.banVerAviso,
    required this.banConvenioActualizado,
    required this.email,
    required this.pass,
    required this.permisos,
  });

  factory UserModel.fromRaw(String raw) => UserModel.fromMap(jsonDecode(raw));

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    token: json['token'] != null ? Token.fromMap(json['token']) : Token.empty(),
    codigoFiliacion: json['codigoFiliacion'] ?? '',
    rfc: json['rfc'] ?? '',
    nombreCompleto: json['nombreCompleto'] ?? '',
    especialidad: json['especialidad'] ?? '',
    estado: json['estado'] ?? '',
    circulo: json['circulo'] ?? '',
    tabulador: json['tabulador'] ?? '',
    estatus: json['estatus'] ?? '',
    vigenciaConvenio: json['vigenciaConvenio'] ?? '',
    banVerConvenio: json['banVerConvenio'] ?? false,
    banDescargaConvenio: json['banDescargaConvenio'] ?? false,
    uid: json['uid'] ?? '',
    banVerAviso: json['banVerAviso'] ?? false,
    banConvenioActualizado: json['banConvenioActualizado'] ?? false,
    email: '',
    pass: '',
    permisos: [],
  );

  factory UserModel.empty() => UserModel(
    token: Token(jwt: '', refreshtoken: '', jwtLogin: JwtPayload.empty()),
    codigoFiliacion: '',
    rfc: '',
    nombreCompleto: '',
    especialidad: '',
    estado: '',
    circulo: '',
    tabulador: '',
    estatus: '',
    vigenciaConvenio: '',
    banVerConvenio: false,
    banDescargaConvenio: false,
    uid: '',
    banVerAviso: false,
    banConvenioActualizado: false,
    email: '',
    pass: '',
    permisos: [],
  );

  final Token token;
  final String codigoFiliacion;
  final String rfc;
  final String nombreCompleto;
  final String especialidad;
  final String estado;
  final String circulo;
  final String tabulador;
  final String estatus;
  final String vigenciaConvenio;
  final String uid;
  final bool banVerConvenio;
  final bool banDescargaConvenio;
  final bool banVerAviso;
  final bool banConvenioActualizado;
  final String email;
  final String pass;
  final List<PermissionsDto> permisos;

  UserModel copyWith({
    Token? token,
    String? codigoFiliacion,
    String? rfc,
    String? nombreCompleto,
    String? especialidad,
    String? estado,
    String? circulo,
    String? tabulador,
    String? estatus,
    String? vigenciaConvenio,
    bool? banVerConvenio,
    bool? banDescargaConvenio,
    String? uid,
    bool? banVerAviso,
    bool? banConvenioActualizado,
    String? email,
    String? pass,
    List<PermissionsDto>? permisos,
  }) => UserModel(
    token: token ?? this.token,
    codigoFiliacion: codigoFiliacion ?? this.codigoFiliacion,
    rfc: rfc ?? this.rfc,
    nombreCompleto: nombreCompleto ?? this.nombreCompleto,
    especialidad: especialidad ?? this.especialidad,
    estado: estado ?? this.estado,
    circulo: circulo ?? this.circulo,
    tabulador: tabulador ?? this.tabulador,
    estatus: estatus ?? this.estatus,
    vigenciaConvenio: vigenciaConvenio ?? this.vigenciaConvenio,
    banVerConvenio: banVerConvenio ?? this.banVerConvenio,
    banDescargaConvenio: banDescargaConvenio ?? this.banDescargaConvenio,
    uid: uid ?? this.uid,
    banVerAviso: banVerAviso ?? this.banVerAviso,
    banConvenioActualizado:
        banConvenioActualizado ?? this.banConvenioActualizado,
    email: email ?? this.email,
    pass: pass ?? this.pass,
    permisos: permisos ?? this.permisos,
  );

  Map<String, dynamic> toJson() => {
    'token': token.toJson(),
    'codigoFiliacion': codigoFiliacion,
    'rfc': rfc,
    'nombreCompleto': nombreCompleto,
    'especialidad': especialidad,
    'estado': estado,
    'circulo': circulo,
    'tabulador': tabulador,
    'estatus': estatus,
    'vigenciaConvenio': vigenciaConvenio,
    'banVerConvenio': banVerConvenio,
    'banDescargaConvenio': banDescargaConvenio,
    'uid': uid,
    'banVerAviso': banVerAviso,
    'banConvenioActualizado': banConvenioActualizado,
  };
}
