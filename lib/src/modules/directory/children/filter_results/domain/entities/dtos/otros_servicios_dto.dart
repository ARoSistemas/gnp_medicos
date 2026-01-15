import 'dart:convert';

import 'package:medicos/src/modules/directory/children/filter_results/domain/entities/models/grupos_otros_servicios_mdl.dart';

class OtrosServiciosDto {
  OtrosServiciosDto({
    required this.registrosTotales,
    required this.pagActual,
    required this.pagTotales,
    required this.gruposSauxs,
  });

  factory OtrosServiciosDto.empty() => OtrosServiciosDto(
    registrosTotales: 0,
    pagActual: 0,
    pagTotales: 0,
    gruposSauxs: [],
  );

  factory OtrosServiciosDto.fromJson(String str) =>
      OtrosServiciosDto.fromMap(json.decode(str));

  factory OtrosServiciosDto.fromMap(Map<String, dynamic> json) =>
      OtrosServiciosDto(
        registrosTotales: json['registrosTotales'] ?? 0,
        pagActual: json['pagActual'] ?? 1,
        pagTotales: json['pagTotales'] ?? 1,
        gruposSauxs: json['gruposSauxs'] != null
            ? List<GruposSauxMdl>.from(
                (json['gruposSauxs'] as List).map(
                  (x) => GruposSauxMdl.fromMap(x),
                ),
              )
            : [],
      );

  int registrosTotales;
  int pagActual;
  int pagTotales;
  List<GruposSauxMdl> gruposSauxs;

  OtrosServiciosDto copyWith({
    int? registrosTotales,
    int? pagActual,
    int? pagTotales,
    List<GruposSauxMdl>? gruposSauxs,
  }) => OtrosServiciosDto(
    registrosTotales: registrosTotales ?? this.registrosTotales,
    pagActual: pagActual ?? this.pagActual,
    pagTotales: pagTotales ?? this.pagTotales,
    gruposSauxs: gruposSauxs ?? this.gruposSauxs,
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'registrosTotales': registrosTotales,
    'pagActual': pagActual,
    'pagTotales': pagTotales,
    'gruposSauxs': List<dynamic>.from(gruposSauxs.map((x) => x.toMap())),
  };
}
