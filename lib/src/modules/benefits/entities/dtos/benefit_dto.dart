// To parse this JSON data, do
//
//     final benefitDto = benefitDtoFromJson(jsonString);

import 'dart:convert';

class BenefitDto {
  BenefitDto({
    required this.orden,
    required this.nombre,
    required this.leyenda,
    required this.imagen,
    required this.archivo,
  });

  factory BenefitDto.fromJson(Map<String, dynamic> json) => BenefitDto(
    orden: json['orden'] ?? '',
    nombre: json['nombre'] ?? '',
    leyenda: json['leyenda'] ?? '',
    imagen: json['imagen'] ?? '',
    archivo: json['archivo'] ?? '',
  );

  factory BenefitDto.empty() => BenefitDto(
    orden: 1000,
    nombre: '',
    leyenda: '',
    imagen: '',
    archivo: ''
  );

  BenefitDto benefitDtoFromJson(String str) =>
      BenefitDto.fromJson(json.decode(str));

  String benefitDtoToJson(BenefitDto data) => json.encode(
    data.toJson(),
  );

  final int orden;
  final String nombre;
  final String leyenda;
  final String imagen;
  final String archivo;

  Map<String, dynamic> toJson() => {
    'orden': orden,
    'nombre': nombre,
    'leyenda': leyenda,
    'imagen': imagen,
    'archivo': archivo,
  };
}
