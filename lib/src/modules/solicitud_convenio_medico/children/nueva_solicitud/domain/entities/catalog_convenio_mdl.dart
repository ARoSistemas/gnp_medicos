import 'dart:convert';

class CatalogConvenioModel {
  CatalogConvenioModel({
    required this.clave,
    required this.cveEstado,
    required this.descripcion,
  });

  factory CatalogConvenioModel.empty() => CatalogConvenioModel(
    clave: '',
    cveEstado: '',
    descripcion: '',
  );

  factory CatalogConvenioModel.fromRaw(String raw) =>
      CatalogConvenioModel.fromMap(jsonDecode(raw));


  factory CatalogConvenioModel.fromMap(Map<String, dynamic> json) =>
      CatalogConvenioModel(
        clave: json['clave'] ?? '',
        cveEstado: json['cve_estado'] ?? '',
        descripcion: json['descripcion'] ?? '',
      );
  final String clave;
  final String cveEstado;
  final String descripcion;

  CatalogConvenioModel copyWith({
    String? clave,
    String? cveEstado,
    String? descripcion,
  }) => CatalogConvenioModel(
    clave: clave ?? this.clave,
    cveEstado: cveEstado ?? this.cveEstado,
    descripcion: descripcion ?? this.descripcion,
  );

  Map<String, dynamic> toMap() => {
    'clave': clave,
    'cve_estado': cveEstado,
    'descripcion': descripcion,
  };
}
