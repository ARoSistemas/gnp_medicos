class SolicitudModel {
  SolicitudModel({
    required this.cveSolicitud,
    required this.nombreMedico,
    required this.cveEspecialidad,
    required this.descripcionEspecialidad,
    required this.cveSubespecialidad,
    required this.descripcionSubespecialidad,
    required this.numeroTelefonoDirecto,
    required this.direccionConsultorioMedico,
    required this.cveHospitalAtencion,
    required this.cveEstatus,
    required this.descripcionEstatus,
    required this.correo,
    required this.fechaSolicitud,
  });

  //  (json['cveHospitalAtencion'] as List).map((x) => x),

  factory SolicitudModel.fromMap(Map<String, dynamic> json) => SolicitudModel(
    cveSolicitud: json['cveSolicitud'],
    nombreMedico: json['nombreMedico'],
    cveEspecialidad: json['cveEspecialidad'],
    descripcionEspecialidad: json['descripcionEspecialidad'],
    cveSubespecialidad: json['cveSubespecialidad'],
    descripcionSubespecialidad: json['descripcionSubespecialidad'],
    numeroTelefonoDirecto: json['numeroTelefonoDirecto'],
    direccionConsultorioMedico: json['direccionConsultorioMedico'],
    cveHospitalAtencion: List<String>.from(
      (json['cveHospitalAtencion'] as List).map((x) => x),
    ),
    cveEstatus: json['cveEstatus'],
    descripcionEstatus: json['descripcionEstatus'],
    correo: json['correo'],
    fechaSolicitud: json['fechaSolicitud'],
  );

  String cveSolicitud;
  String nombreMedico;
  String cveEspecialidad;
  String descripcionEspecialidad;
  String cveSubespecialidad;
  String descripcionSubespecialidad;
  String numeroTelefonoDirecto;
  String direccionConsultorioMedico;
  List<String> cveHospitalAtencion;
  String cveEstatus;
  String descripcionEstatus;
  String correo;
  String fechaSolicitud;

  // String tiposAsistentesModelToJson(List<SolicitudModel> data) =>
  //     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  Map<String, dynamic> toJson() => {
    'cveSolicitud': cveSolicitud,
    'nombreMedico': nombreMedico,
    'cveEspecialidad': cveEspecialidad,
    'descripcionEspecialidad': descripcionEspecialidad,
    'cveSubespecialidad': cveSubespecialidad,
    'descripcionSubespecialidad': descripcionSubespecialidad,
    'numeroTelefonoDirecto': numeroTelefonoDirecto,
    'direccionConsultorioMedico': direccionConsultorioMedico,
    'cveHospitalAtencion': List<dynamic>.from(
      cveHospitalAtencion.map((x) => x),
    ),
    'cveEstatus': cveEstatus,
    'descripcionEstatus': descripcionEstatus,
    'correo': correo,
    'fechaSolicitud': fechaSolicitud,
  };
}
