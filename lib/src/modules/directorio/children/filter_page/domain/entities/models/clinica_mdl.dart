import 'dart:convert';

class ClinicaMdl {
  ClinicaMdl({
    required this.claveTipoClinica,
    required this.tipoClinica,
  });

  factory ClinicaMdl.fromJson(String str) =>
      ClinicaMdl.fromMap(json.decode(str));

  factory ClinicaMdl.fromMap(Map<String, dynamic> json) => ClinicaMdl(
    claveTipoClinica: json['claveTipoClinica'] ?? '',
    tipoClinica: json['tipoClinica'] ?? '',
  );

  factory ClinicaMdl.empty() => ClinicaMdl(
    claveTipoClinica: '',
    tipoClinica: '',
  );

  String claveTipoClinica;
  String tipoClinica;

  ClinicaMdl copyWith({
    String? claveTipoClinica,
    String? tipoClinica,
  }) => ClinicaMdl(
    claveTipoClinica: claveTipoClinica ?? this.claveTipoClinica,
    tipoClinica: tipoClinica ?? this.tipoClinica,
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'claveTipoClinica': claveTipoClinica,
    'tipoClinica': tipoClinica,
  };
}
