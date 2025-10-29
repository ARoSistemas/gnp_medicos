part of 'solicitud_documentacion_controller.dart';

final class _SolicitudDocumentacionModel {
  const _SolicitudDocumentacionModel({
    this.name = 'SolicitudDocumentacion',
  });

  _SolicitudDocumentacionModel copyWith({
    String? name,
  }) => _SolicitudDocumentacionModel(
    name: name ?? this.name,
  );

  final String name;
}
