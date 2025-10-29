class HospitalMedicoModel {
  HospitalMedicoModel({
    required this.clave,
    required this.descripcion,
  });

  factory HospitalMedicoModel.fromJson(Map<String, dynamic> json) =>
      HospitalMedicoModel(
        clave: json['clave'],
        descripcion: json['descripcion'],
      );
  final String clave;
  final String descripcion;

  Map<String, dynamic> toJson() => {
    'clave': clave,
    'descripcion': descripcion,
  };
}
