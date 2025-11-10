import 'dart:convert';

class OtroServicioMdl {
  OtroServicioMdl({
    required this.claveTipoProveedor,
    required this.tipoProveedor,
  });

  factory OtroServicioMdl.fromJson(String str) =>
      OtroServicioMdl.fromMap(json.decode(str));

  factory OtroServicioMdl.fromMap(Map<String, dynamic> json) => OtroServicioMdl(
    claveTipoProveedor: json['claveTipoProveedor'] ?? 0,
    tipoProveedor: json['tipoProveedor'] ?? '',
  );

  factory OtroServicioMdl.empty() => OtroServicioMdl(
    claveTipoProveedor: 0,
    tipoProveedor: '',
  );

  int claveTipoProveedor;
  String tipoProveedor;

  OtroServicioMdl copyWith({
    int? claveTipoProveedor,
    String? tipoProveedor,
  }) => OtroServicioMdl(
    claveTipoProveedor: claveTipoProveedor ?? this.claveTipoProveedor,
    tipoProveedor: tipoProveedor ?? this.tipoProveedor,
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'claveTipoProveedor': claveTipoProveedor,
    'tipoProveedor': tipoProveedor,
  };
}
