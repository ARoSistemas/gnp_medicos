import 'dart:convert';

class EspecialidadMdl {
  EspecialidadMdl({
    required this.claveEspecialidad,
    required this.especialidad,
  });

  factory EspecialidadMdl.fromJson(String str) =>
      EspecialidadMdl.fromMap(json.decode(str));

  factory EspecialidadMdl.fromMap(Map<String, dynamic> json) => EspecialidadMdl(
    claveEspecialidad: json['claveEspecialidad'] ?? '',
    especialidad: json['especialidad'] ?? '',
  );

  factory EspecialidadMdl.empty() => EspecialidadMdl(
    claveEspecialidad: '',
    especialidad: '',
  );

  String claveEspecialidad;
  String especialidad;

  EspecialidadMdl copyWith({
    String? claveEspecialidad,
    String? especialidad,
  }) => EspecialidadMdl(
    claveEspecialidad: claveEspecialidad ?? this.claveEspecialidad,
    especialidad: especialidad ?? this.especialidad,
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'claveEspecialidad': claveEspecialidad,
    'Especialidad': especialidad,
  };
}
