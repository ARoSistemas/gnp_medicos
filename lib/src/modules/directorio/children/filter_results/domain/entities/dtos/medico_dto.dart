import 'dart:convert';

import 'package:medicos/src/modules/directorio/children/filter_results/domain/entities/models/grupos_medico_mdl.dart';

class MedicosDto {
  MedicosDto({
    required this.registrosTotales,
    required this.pagActual,
    required this.pagTotales,
    required this.gruposMedicos,
  });

  factory MedicosDto.empty() => MedicosDto(
    registrosTotales: 0,
    pagActual: 0,
    pagTotales: 0,
    gruposMedicos: [],
  );

  factory MedicosDto.fromJson(String str) =>
      MedicosDto.fromMap(json.decode(str));

  factory MedicosDto.fromMap(Map<String, dynamic> json) => MedicosDto(
    registrosTotales: json['registrosTotales'] ?? 0,
    pagActual: json['pagActual'] ?? 1,
    pagTotales: json['pagTotales'] ?? 1,
    gruposMedicos: json['gruposMedicos'] != null
        ? List<GruposMedicoMdl>.from(
            (json['gruposMedicos'] as List).map(
              (x) => GruposMedicoMdl.fromMap(x),
            ),
          )
        : [],
  );

  int registrosTotales;
  int pagActual;
  int pagTotales;
  List<GruposMedicoMdl> gruposMedicos;

  MedicosDto copyWith({
    int? registrosTotales,
    int? pagActual,
    int? pagTotales,
    List<GruposMedicoMdl>? gruposMedicos,
  }) => MedicosDto(
    registrosTotales: registrosTotales ?? this.registrosTotales,
    pagActual: pagActual ?? this.pagActual,
    pagTotales: pagTotales ?? this.pagTotales,
    gruposMedicos: gruposMedicos ?? this.gruposMedicos,
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'registrosTotales': registrosTotales,
    'pagActual': pagActual,
    'pagTotales': pagTotales,
    'gruposMedicos': List<dynamic>.from(gruposMedicos.map((x) => x.toMap())),
  };
}
