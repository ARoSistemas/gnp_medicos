class AssistantUpdateModel {
  AssistantUpdateModel({
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.fechaNacimiento,
    required this.cveLada,
    required this.telefono,
    required this.idTipoAsistente,
    this.activo,
  });

  factory AssistantUpdateModel.fromJson(Map<String, dynamic> json) =>
      AssistantUpdateModel(
        nombre: json['nombre'],
        apellidoPaterno: json['apellidoPaterno'],
        apellidoMaterno: json['apellidoMaterno'],
        fechaNacimiento: json['fechaNacimiento'],
        cveLada: json['cveLada'],
        telefono: json['telefono'],
        idTipoAsistente: json['idTipoAsistente'],
        activo: json['activo'],
      );

  String nombre;
  String apellidoPaterno;
  String apellidoMaterno;
  String fechaNacimiento;
  String cveLada;
  String telefono;
  String idTipoAsistente;
  bool? activo;

  Map<String, dynamic> toJson() => {
    'nombre': nombre,
    'apellidoPaterno': apellidoPaterno,
    'apellidoMaterno': apellidoMaterno,
    'fechaNacimiento': fechaNacimiento,
    'cveLada': cveLada,
    'telefono': telefono,
    'idTipoAsistente': idTipoAsistente,
    'activo': activo,
  };
}
