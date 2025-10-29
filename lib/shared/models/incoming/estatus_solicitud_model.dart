
class EstatusSolicitudModel {

  EstatusSolicitudModel({
    required this.cveEstatusSolicitud,
    required this.descripcion,
  });

  factory EstatusSolicitudModel.fromJson(Map<String, dynamic> json) =>
      EstatusSolicitudModel(
        cveEstatusSolicitud: json['cve_estatus_solicitud'],
        descripcion: json['descripcion'],
      );
  final String cveEstatusSolicitud;
  final String descripcion;

  Map<String, dynamic> toJson() => {
    'cve_estatus_solicitud': cveEstatusSolicitud,
    'descripcion': descripcion,
  };
}
