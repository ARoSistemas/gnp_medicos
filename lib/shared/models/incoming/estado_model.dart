

class EstadoModel {

    EstadoModel({
        required this.cveEstado,
        required this.descripcion,
    });

    factory EstadoModel.fromJson(Map<String, dynamic> json) => EstadoModel(
        cveEstado: json['cve_estado'],
        descripcion: json['descripcion'],
    );
    final String cveEstado;
    final String descripcion;

    Map<String, dynamic> toJson() => {
        'cve_estado': cveEstado,
        'descripcion': descripcion,
    };
}
