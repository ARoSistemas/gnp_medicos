import 'dart:convert';

class EstadoMdl {
  EstadoMdl({
    required this.claveEstado,
    required this.estado,
  });

  factory EstadoMdl.fromJson(String str) => EstadoMdl.fromMap(json.decode(str));

  factory EstadoMdl.fromMap(Map<String, dynamic> json) => EstadoMdl(
    claveEstado: json['claveEstado'] ?? '',
    estado: json['estado'] ?? '',
  );

  factory EstadoMdl.empty() => EstadoMdl(
    claveEstado: '',
    estado: '',
  );

  String claveEstado;
  String estado;

  EstadoMdl copyWith({
    String? claveEstado,
    String? estado,
  }) => EstadoMdl(
    claveEstado: claveEstado ?? this.claveEstado,
    estado: estado ?? this.estado,
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'claveEstado': claveEstado,
    'estado': estado,
  };
}
