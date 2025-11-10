import 'dart:convert';

import 'package:medicos/src/modules/directorio/children/filter_results/domain/entities/models/grupos_hospitalario_mdl.dart';

class HospitalesDto {
  HospitalesDto({
    required this.registrosTotales,
    required this.pagActual,
    required this.pagTotales,
    required this.alertaConsulta,
    required this.gruposHospitalarios,
  });

  factory HospitalesDto.empty() => HospitalesDto(
    registrosTotales: 0,
    pagActual: 0,
    pagTotales: 0,
    alertaConsulta: '',
    gruposHospitalarios: [],
  );

  factory HospitalesDto.fromJson(String str) =>
      HospitalesDto.fromMap(json.decode(str));

  factory HospitalesDto.fromMap(Map<String, dynamic> json) => HospitalesDto(
    registrosTotales: json['registrosTotales'],
    pagActual: json['pagActual'] ?? 1,
    pagTotales: json['pagTotales'] ?? 1,
    alertaConsulta: json['alertaConsulta'],
    gruposHospitalarios: json['gruposHospitalarios'] != null
        ? List<GruposHospitalarioMdl>.from(
            (json['gruposHospitalarios'] as List).map(
              (x) => GruposHospitalarioMdl.fromMap(x),
            ),
          )
        : [],
  );
  
  int registrosTotales;
  int pagActual;
  int pagTotales;
  String alertaConsulta;
  List<GruposHospitalarioMdl> gruposHospitalarios;

  HospitalesDto copyWith({
    int? registrosTotales,
    int? pagActual,
    int? pagTotales,
    String? alertaConsulta,
    List<GruposHospitalarioMdl>? gruposHospitalarios,
  }) => HospitalesDto(
    registrosTotales: registrosTotales ?? this.registrosTotales,
    pagActual: pagActual ?? this.pagActual,
    pagTotales: pagTotales ?? this.pagTotales,
    alertaConsulta: alertaConsulta ?? this.alertaConsulta,
    gruposHospitalarios: gruposHospitalarios ?? this.gruposHospitalarios,
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'registrosTotales': registrosTotales,
    'pagActual': pagActual,
    'pagTotales': pagTotales,
    'alertaConsulta': alertaConsulta,
    'gruposHospitalarios': List<dynamic>.from(
      gruposHospitalarios.map((x) => x.toMap()),
    ),
  };
}
