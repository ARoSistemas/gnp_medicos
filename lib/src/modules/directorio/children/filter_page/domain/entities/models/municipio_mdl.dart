import 'dart:convert';

class MunicipioMdl {
  MunicipioMdl({
    required this.claveMunicipio,
    required this.municipio,
  });

  factory MunicipioMdl.fromJson(String str) =>
      MunicipioMdl.fromMap(json.decode(str));

  factory MunicipioMdl.fromMap(Map<String, dynamic> json) => MunicipioMdl(
    claveMunicipio: json['claveMunicipio'] ?? '',
    municipio: json['municipio'] ?? '',
  );

  factory MunicipioMdl.empty() => MunicipioMdl(
    claveMunicipio: '',
    municipio: '',
  );

  String claveMunicipio;
  String municipio;

  MunicipioMdl copyWith({
    String? claveMunicipio,
    String? municipio,
  }) => MunicipioMdl(
    claveMunicipio: claveMunicipio ?? this.claveMunicipio,
    municipio: municipio ?? this.municipio,
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'claveMunicipio': claveMunicipio,
    'municipio': municipio,
  };
}
