import 'dart:convert';

import 'package:medicos/src/modules/directory/children/filter_results/domain/entities/models/clinicas_mdl.dart';

class GruposClinicaMdl {
  GruposClinicaMdl({
    required this.etiquetaGrupoBusqueda,
    required this.clinicas,
  });

  factory GruposClinicaMdl.empty() => GruposClinicaMdl(
    etiquetaGrupoBusqueda: '',
    clinicas: [],
  );

  factory GruposClinicaMdl.fromJson(String str) =>
      GruposClinicaMdl.fromMap(json.decode(str));

  factory GruposClinicaMdl.fromMap(Map<String, dynamic> json) =>
      GruposClinicaMdl(
        etiquetaGrupoBusqueda: json['etiquetaGrupoBusqueda'] ?? '',
        clinicas: json['clinicas'] != null
            ? List<ClinicaMdl>.from(
                (json['clinicas'] as List).map(
                  (x) => ClinicaMdl.fromMap(x),
                ),
              )
            : [],
      );

  String etiquetaGrupoBusqueda;
  List<ClinicaMdl> clinicas;

  GruposClinicaMdl copyWith({
    String? etiquetaGrupoBusqueda,
    List<ClinicaMdl>? clinicas,
  }) => GruposClinicaMdl(
    etiquetaGrupoBusqueda: etiquetaGrupoBusqueda ?? this.etiquetaGrupoBusqueda,
    clinicas: clinicas ?? this.clinicas,
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'etiquetaGrupoBusqueda': etiquetaGrupoBusqueda,
    'clinicas': List<dynamic>.from(clinicas.map((x) => x.toMap())),
  };
}
