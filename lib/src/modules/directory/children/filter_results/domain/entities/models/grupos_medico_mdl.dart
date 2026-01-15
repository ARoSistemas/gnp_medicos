import 'dart:convert';

import 'package:medicos/src/modules/directory/children/filter_results/domain/entities/models/medico_mdl.dart';

class GruposMedicoMdl {
  GruposMedicoMdl({
    required this.etiquetaGrupoBusqueda,
    required this.medicos,
  });

  factory GruposMedicoMdl.empty() => GruposMedicoMdl(
    etiquetaGrupoBusqueda: '',
    medicos: [],
  );

  factory GruposMedicoMdl.fromJson(String str) =>
      GruposMedicoMdl.fromMap(json.decode(str));

  factory GruposMedicoMdl.fromMap(Map<String, dynamic> json) => GruposMedicoMdl(
    etiquetaGrupoBusqueda: json['etiquetaGrupoBusqueda'] ?? '',
    medicos: json['medicos'] != null
        ? List<MedicoMdl>.from(
            (json['medicos'] as List).map((x) => MedicoMdl.fromMap(x)),
          )
        : [],
  );

  String etiquetaGrupoBusqueda;
  List<MedicoMdl> medicos;

  GruposMedicoMdl copyWith({
    String? etiquetaGrupoBusqueda,
    List<MedicoMdl>? medicos,
  }) => GruposMedicoMdl(
    etiquetaGrupoBusqueda: etiquetaGrupoBusqueda ?? this.etiquetaGrupoBusqueda,
    medicos: medicos ?? this.medicos,
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'etiquetaGrupoBusqueda': etiquetaGrupoBusqueda,
    'medicos': List<dynamic>.from(medicos.map((x) => x.toMap())),
  };
}
