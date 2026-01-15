import 'dart:convert';

class CirculoMedicoMdl {
  CirculoMedicoMdl({
    required this.claveCirculoMedico,
    required this.circuloMedico,
  });

  factory CirculoMedicoMdl.fromJson(String str) =>
      CirculoMedicoMdl.fromMap(json.decode(str));

  factory CirculoMedicoMdl.fromMap(Map<String, dynamic> json) =>
      CirculoMedicoMdl(
        claveCirculoMedico: json['claveCirculoMedico'] ?? '',
        circuloMedico: json['circuloMedico'] ?? '',
      );

  factory CirculoMedicoMdl.empty() => CirculoMedicoMdl(
    claveCirculoMedico: '',
    circuloMedico: '',
  );

  String claveCirculoMedico;
  String circuloMedico;

  CirculoMedicoMdl copyWith({
    String? claveCirculoMedico,
    String? circuloMedico,
  }) => CirculoMedicoMdl(
    claveCirculoMedico: claveCirculoMedico ?? this.claveCirculoMedico,
    circuloMedico: circuloMedico ?? this.circuloMedico,
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'claveCirculoMedico': claveCirculoMedico,
    'circuloMedico': circuloMedico,
  };
}
