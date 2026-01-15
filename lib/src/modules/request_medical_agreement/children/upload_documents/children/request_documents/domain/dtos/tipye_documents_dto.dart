import 'dart:convert';

class TypeDocumentModel {
  TypeDocumentModel({
    this.cveTipoDocumento,
    this.descripcion,
    this.nombre,
    this.path,
    this.tipo,
    this.cveSolicitud,
    this.id,
  });

  factory TypeDocumentModel.fromRaw(String raw) =>
      TypeDocumentModel.fromMap(jsonDecode(raw));

  factory TypeDocumentModel.fromMap(Map<String, dynamic> json) =>
      TypeDocumentModel(
        cveTipoDocumento: json['cve_tipo_documento'],
        descripcion: json['descripcion'],
        nombre: json['nombre'],
        path: json['path'],
        tipo: json['tipo'],
        cveSolicitud: json['cve_solicitud'],
        id: json['id'],
      );

  String typeDocumentToJson(TypeDocumentModel data) =>
      json.encode(data.toJson());

  final String? cveTipoDocumento;
  final String? descripcion;
  final String? nombre;
  final String? path;
  final String? tipo;
  final String? cveSolicitud;
  final String? id;

  Map<String, dynamic> toJson() => {
    'cve_tipo_documento': cveTipoDocumento,
    'descripcion': descripcion,
    'nombre': nombre,
    'path': path,
    'tipo': tipo,
    'cve_solicitud': cveSolicitud,
    'id': id,
  };
}
