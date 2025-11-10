import 'dart:convert';

import 'package:medicos/src/modules/directorio/children/filter_results/domain/entities/models/grupos_clinicas_mdl.dart';

class ClinicasDto {
  ClinicasDto({
    required this.registrosTotales,
    required this.pagActual,
    required this.pagTotales,
    required this.gruposClinicas,
  });

  factory ClinicasDto.empty() => ClinicasDto(
    registrosTotales: 0,
    pagActual: 0,
    pagTotales: 0,
    gruposClinicas: [],
  );

  factory ClinicasDto.fromJson(String str) =>
      ClinicasDto.fromMap(json.decode(str));

  factory ClinicasDto.fromMap(Map<String, dynamic> json) {
    /// La llave categorizador, puede venir como int o double
    final dynamic pActualTmp = json['categorizador'];

    int pActual = 1;
    if (pActualTmp != null) {
      pActual = (pActualTmp is double) ? pActualTmp.toInt() : pActualTmp;
    }

    final dynamic pTotalesTmp = json['pagTotales'];
    int pTotales = 1;
    if (pTotalesTmp != null) {
      pTotales = (pTotalesTmp is double) ? pTotalesTmp.toInt() : pTotalesTmp;
    }

    return ClinicasDto(
      registrosTotales: json['registrosTotales'] ?? 0,
      pagActual: pActual,
      pagTotales: pTotales,
      gruposClinicas: json['gruposClinicas'] != null
          ? List<GruposClinicaMdl>.from(
              (json['gruposClinicas'] as List).map(
                (x) => GruposClinicaMdl.fromMap(x),
              ),
            )
          : [],
    );
  }
  int registrosTotales;
  int pagActual;
  int pagTotales;
  List<GruposClinicaMdl> gruposClinicas;

  ClinicasDto copyWith({
    int? registrosTotales,
    int? pagActual,
    int? pagTotales,
    List<GruposClinicaMdl>? gruposClinicas,
  }) => ClinicasDto(
    registrosTotales: registrosTotales ?? this.registrosTotales,
    pagActual: pagActual ?? this.pagActual,
    pagTotales: pagTotales ?? this.pagTotales,
    gruposClinicas: gruposClinicas ?? this.gruposClinicas,
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'registrosTotales': registrosTotales,
    'pagActual': pagActual,
    'pagTotales': pagTotales,
    'gruposClinicas': List<dynamic>.from(gruposClinicas.map((x) => x.toMap())),
  };
}
