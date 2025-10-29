class SubEspecialidadModel {
  SubEspecialidadModel({
    required this.cveSubespecialidad,
    required this.descripcion,
  });

  factory SubEspecialidadModel.fromJson(Map<String, dynamic> json) =>
      SubEspecialidadModel(
        cveSubespecialidad: json['cve_subespecialidad'],
        descripcion: json['descripcion'],
      );
  final String cveSubespecialidad;
  final String descripcion;

  Map<String, dynamic> toJson() => {
    'cve_subespecialidad': cveSubespecialidad,
    'descripcion': descripcion,
  };
}
