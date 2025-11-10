import 'dart:convert';

import 'package:medicos/src/modules/directorio/children/filter_results/domain/entities/models/hospital_mdl.dart';

class GruposHospitalarioMdl {
  GruposHospitalarioMdl({
    required this.banNivelContratado,
    required this.etiquetaGrupoBusqueda,
    required this.hospitales,
  });

  factory GruposHospitalarioMdl.empty() => GruposHospitalarioMdl(
    banNivelContratado: false,
    etiquetaGrupoBusqueda: '',
    hospitales: [],
  );

  factory GruposHospitalarioMdl.fromJson(String str) =>
      GruposHospitalarioMdl.fromMap(json.decode(str));

  factory GruposHospitalarioMdl.fromMap(Map<String, dynamic> json) =>
      GruposHospitalarioMdl(
        banNivelContratado: json['banNivelContratado'] ?? false,
        etiquetaGrupoBusqueda: json['etiquetaGrupoBusqueda'] ?? '',
        hospitales: json['hospitales'] != null
            ? List<HospitalMdl>.from(
                (json['hospitales'] as List).map((x) => HospitalMdl.fromMap(x)),
              )
            : [],
      );

  bool banNivelContratado;
  String etiquetaGrupoBusqueda;
  List<HospitalMdl> hospitales;

  GruposHospitalarioMdl copyWith({
    bool? banNivelContratado,
    String? etiquetaGrupoBusqueda,
    List<HospitalMdl>? hospitales,
  }) => GruposHospitalarioMdl(
    banNivelContratado: banNivelContratado ?? this.banNivelContratado,
    etiquetaGrupoBusqueda: etiquetaGrupoBusqueda ?? this.etiquetaGrupoBusqueda,
    hospitales: hospitales ?? this.hospitales,
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'banNivelContratado': banNivelContratado,
    'etiquetaGrupoBusqueda': etiquetaGrupoBusqueda,
    'hospitales': List<dynamic>.from(hospitales.map((x) => x.toMap())),
  };
}
