import 'dart:convert';

class TypeDocumentModel {
  TypeDocumentModel({
    required this.cveTipoDocumento,
    required this.descripcion,
  });

  factory TypeDocumentModel.fromRaw(String raw) =>
      TypeDocumentModel.fromMap(jsonDecode(raw));

  factory TypeDocumentModel.fromMap(Map<String, dynamic> json) =>
      TypeDocumentModel(
        cveTipoDocumento: json['cve_tipo_documento'],
        descripcion: json['descripcion'],
      );

  String typeDocumentToJson(TypeDocumentModel data) =>
      json.encode(data.toJson());

  final String cveTipoDocumento;
  final String descripcion;

  Map<String, dynamic> toJson() => {
    'cve_tipo_documento': cveTipoDocumento,
    'descripcion': descripcion,
  };
}
