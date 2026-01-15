import 'dart:convert';

class EstadoDto {
  EstadoDto({
    required this.estado,
    required this.municipios,
  });

  factory EstadoDto.fromMap(Map<String, dynamic> json) => EstadoDto(
    estado: json['estado'] ?? '',
    municipios: (json['municipios'] as List?)
          ?.map((e) => e.toString())
          .toList()
      ?? <String>[]
  );

  String estado;
  List<String> municipios;

  EstadoDto copyWith({
    String? estado,
    List<String>? municipios
  }) => EstadoDto(
    estado: estado ?? this.estado,
    municipios: municipios ?? this.municipios,
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'estado': estado,
    'municipios': municipios,
  };
}
