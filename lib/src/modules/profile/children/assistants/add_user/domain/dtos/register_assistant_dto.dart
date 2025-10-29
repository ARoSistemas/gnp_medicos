import 'dart:convert';

import 'package:medicos/src/modules/profile/children/assistants/add_user/domain/dtos/assistant_dto.dart';

class RegisterAssistantModel {
  RegisterAssistantModel({
    required this.codigoFiliacionMedico,
    required this.idTipoAsistente,
    required this.asistente,
  });

  factory RegisterAssistantModel.fromRaw(String raw) =>
      RegisterAssistantModel.fromMap(jsonDecode(raw));

  factory RegisterAssistantModel.fromMap(Map<String, dynamic> json) =>
      RegisterAssistantModel(
        codigoFiliacionMedico: json['codigoFiliacionMedico'],
        idTipoAsistente: json['idTipoAsistente'],
        asistente: AssistantDto.fromMap(json['asistente']),
      );

  RegisterAssistantModel registerAssistantModelFromJson(String str) =>
      RegisterAssistantModel.fromMap(json.decode(str));

  String registerAssistantModelToJson(RegisterAssistantModel data) =>
      json.encode(data.toJson());

  Map<String, dynamic> toJson() => {
    'codigoFiliacionMedico': codigoFiliacionMedico,
    'idTipoAsistente': idTipoAsistente,
    'asistente': asistente.toMap(),
  };

  String codigoFiliacionMedico;
  String idTipoAsistente;
  AssistantDto asistente;
}
