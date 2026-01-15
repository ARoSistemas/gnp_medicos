import 'dart:convert';

import 'package:medicos/src/modules/directory/children/filter_results/domain/entities/models/saux_mdl.dart';

class GruposSauxMdl {
  GruposSauxMdl({
    required this.etiquetaGrupoBusqueda,
    required this.sauxs,
  });

  factory GruposSauxMdl.fromJson(String str) =>
      GruposSauxMdl.fromMap(json.decode(str));

  factory GruposSauxMdl.fromMap(Map<String, dynamic> json) => GruposSauxMdl(
    etiquetaGrupoBusqueda: json['etiquetaGrupoBusqueda'] ?? '',
    sauxs: json['sauxs'] != null
        ? List<SauxMdl>.from(
            (json['sauxs'] as List).map((x) => SauxMdl.fromMap(x)),
          )
        : [],
  );
  String etiquetaGrupoBusqueda;
  List<SauxMdl> sauxs;

  GruposSauxMdl copyWith({
    String? etiquetaGrupoBusqueda,
    List<SauxMdl>? sauxs,
  }) => GruposSauxMdl(
    etiquetaGrupoBusqueda: etiquetaGrupoBusqueda ?? this.etiquetaGrupoBusqueda,
    sauxs: sauxs ?? this.sauxs,
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'etiquetaGrupoBusqueda': etiquetaGrupoBusqueda,
    'sauxs': List<dynamic>.from(sauxs.map((x) => x.toMap())),
  };
}
