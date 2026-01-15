import 'dart:convert';

class CirculoDto {
  CirculoDto({
    required this.circuloMedico,
    required this.gama,
  });

  factory CirculoDto.fromJson(String str) => 
  CirculoDto.fromMap(json.decode(str));

  factory CirculoDto.fromMap(Map<String, dynamic> json) => CirculoDto(
    circuloMedico: json['circuloMedico'] ?? '',
    gama: json['gama'] ?? '',
  );

  String circuloMedico;
  String gama;

  CirculoDto copyWith({
    String? circuloMedico,
    String? gama
  }) => CirculoDto(
    circuloMedico: circuloMedico ?? this.circuloMedico,
    gama: gama ?? this.gama,
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'circuloMedico': circuloMedico,
    'gama': gama,
  };
}
