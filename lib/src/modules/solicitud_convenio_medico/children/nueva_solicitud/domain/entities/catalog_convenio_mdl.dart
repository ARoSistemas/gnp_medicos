import 'dart:convert';

class CatalogConveioModel {
  CatalogConveioModel({
    required this.clave,
    required this.cveEstado,
    required this.descripcion,
  });

  factory CatalogConveioModel.empty() => CatalogConveioModel(
    clave: '',
    cveEstado: '',
    descripcion: '',
  );

  factory CatalogConveioModel.fromRaw(String raw) =>
      CatalogConveioModel.fromMap(jsonDecode(raw));


  factory CatalogConveioModel.fromMap(Map<String, dynamic> json) =>
      CatalogConveioModel(
        clave: json['clave'] ?? '',
        cveEstado: json['cve_estado'] ?? '',
        descripcion: json['descripcion'] ?? '',
      );
  final String clave;
  final String cveEstado;
  final String descripcion;

  CatalogConveioModel copyWith({
    String? clave,
    String? cveEstado,
    String? descripcion,
  }) => CatalogConveioModel(
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
