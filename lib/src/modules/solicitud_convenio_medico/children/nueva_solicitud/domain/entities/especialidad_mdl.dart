import 'dart:convert';

class Especialidad {
  Especialidad({
    required this.cveEspecialidad,
    required this.descripcion,
  });

  factory Especialidad.empty() => Especialidad(
    cveEspecialidad: '',
    descripcion: '',
  );

  factory Especialidad.fromRaw(String raw) =>
      Especialidad.fromMap(jsonDecode(raw));


  factory Especialidad.fromMap(Map<String, dynamic> json) =>
      Especialidad(
        cveEspecialidad: json['cve_especialidad'] ?? '',
        descripcion: json['descripcion'] ?? '',
      );
  final String cveEspecialidad;
  final String descripcion;

  Especialidad copyWith({
    String? cveEspecialidad,
    String? descripcion,
  }) => Especialidad(
    cveEspecialidad: cveEspecialidad ?? this.cveEspecialidad,
    descripcion: descripcion ?? this.descripcion,
  );

  Map<String, dynamic> toMap() => {
    'cve_especialidad': cveEspecialidad,
    'descripcion': descripcion,
  };
}
