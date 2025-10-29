import 'dart:convert';

import 'package:medicos/src/modules/profile/children/assistants/add_user/domain/dtos/assistant_dto.dart';

class RegisterAssistants {
  RegisterAssistants({
    required this.idRelacionMedicoAsistente,
    required this.codigoFiliacionMedico,
    required this.asistente,
    required this.tipoAsistente,
    required this.activo,
  });

  factory RegisterAssistants.fromRaw(String raw) =>
      RegisterAssistants.fromMap(json.decode(raw));

  factory RegisterAssistants.fromMap(Map<String, dynamic> json) =>
      RegisterAssistants(
        idRelacionMedicoAsistente: json['idRelacionMedicoAsistente'] ?? 0,
        codigoFiliacionMedico: json['codigoFiliacionMedico'] ?? '',
        asistente: json['asistente'] != null
            ? AssistantDto.fromMap(json['asistente'] ?? {})
            : AssistantDto.empty(),
        tipoAsistente: TipoAsistente.fromMap(json['tipoAsistente'] ?? {}),
        activo: json['activo'] ?? false,
      );

  RegisterAssistants copyWith({
    int? idRelacionMedicoAsistente,
    String? codigoFiliacionMedico,
    AssistantDto? asistente,
    TipoAsistente? tipoAsistente,
    bool? activo,
  }) => RegisterAssistants(
    idRelacionMedicoAsistente:
        idRelacionMedicoAsistente ?? this.idRelacionMedicoAsistente,
    codigoFiliacionMedico: codigoFiliacionMedico ?? this.codigoFiliacionMedico,
    asistente: asistente ?? this.asistente,
    tipoAsistente: tipoAsistente ?? this.tipoAsistente,
    activo: activo ?? this.activo,
  );

  Map<String, dynamic> toMap() => {
    'idRelacionMedicoAsistente': idRelacionMedicoAsistente,
    'codigoFiliacionMedico': codigoFiliacionMedico,
    'asistente': asistente.toMap(),
    'tipoAsistente': tipoAsistente.toMap(),
    'activo': activo,
  };

  int idRelacionMedicoAsistente;
  String codigoFiliacionMedico;
  AssistantDto asistente;
  TipoAsistente tipoAsistente;
  bool activo;
}

class TipoAsistente {
  TipoAsistente({
    required this.idTipoAsistente,
    required this.nombre,
  });

  factory TipoAsistente.fromRaw(String raw) =>
      TipoAsistente.fromMap(json.decode(raw));

  factory TipoAsistente.fromMap(Map<String, dynamic> json) => TipoAsistente(
    idTipoAsistente: json['idTipoAsistente'],
    nombre: json['nombre'],
  );

  factory TipoAsistente.empty() => TipoAsistente(
    idTipoAsistente: '',
    nombre: '',
  );

  TipoAsistente copyWith({
    String? idTipoAsistente,
    String? nombre,
  }) => TipoAsistente(
    idTipoAsistente: idTipoAsistente ?? this.idTipoAsistente,
    nombre: nombre ?? this.nombre,
  );

  Map<String, dynamic> toMap() => {
    'idTipoAsistente': idTipoAsistente,
    'nombre': nombre,
  };

  String idTipoAsistente;
  String nombre;
}
