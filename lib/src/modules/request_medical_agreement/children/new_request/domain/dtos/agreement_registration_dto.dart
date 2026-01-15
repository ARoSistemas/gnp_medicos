import 'dart:convert';

class AgreementRegistration {
  AgreementRegistration({
    required this.nombreMedico,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.cveEspecialidad,
    required this.cveSubespecialidad,
    required this.numeroTelefonoDirecto,
    required this.direccionConsultorioMedico,
    required this.cvesHospitalesAtencion,
    required this.cveEstatus,
    required this.correo,
    required this.rfc,
    required this.cveEstado,
    required this.codigoAfiliacion,
    required this.uid,
  });

  factory AgreementRegistration.fromRaw(String raw) =>
      AgreementRegistration.fromMap(jsonDecode(raw));

  factory AgreementRegistration.fromMap(Map<String, dynamic> json) =>
      AgreementRegistration(
        nombreMedico: json['nombreMedico'],
        apellidoPaterno: json['apellidoPaterno'],
        apellidoMaterno: json['apellidoMaterno'],
        cveEspecialidad: json['cveEspecialidad'],
        cveSubespecialidad: json['cveSubespecialidad'],
        numeroTelefonoDirecto: json['numeroTelefonoDirecto'],
        direccionConsultorioMedico: json['direccionConsultorioMedico'],
        cvesHospitalesAtencion: json['cvesHospitalesAtencion'],
        cveEstatus: json['cveEstatus'],
        correo: json['correo'],
        rfc: json['rfc'],
        cveEstado: json['cveEstado'],
        codigoAfiliacion: json['codigoAfiliacion'],
        uid: json['uid'],
      );
  String registrationAgreementToJson(AgreementRegistration data) =>
      json.encode(data.toJson());
  

  String nombreMedico;
  String apellidoPaterno;
  String apellidoMaterno;
  String cveEspecialidad;
  String cveSubespecialidad;
  String numeroTelefonoDirecto;
  String direccionConsultorioMedico;
  List cvesHospitalesAtencion;
  String cveEstatus;
  String correo;
  String rfc;
  String cveEstado;
  String codigoAfiliacion;
  String uid;

  Map<String, dynamic> toJson() => {
    'nombreMedico': nombreMedico,
    'apellidoPaterno': apellidoPaterno,
    'apellidoMaterno': apellidoMaterno,
    'cveEspecialidad': cveEspecialidad,
    'cveSubespecialidad': cveSubespecialidad,
    'numeroTelefonoDirecto': numeroTelefonoDirecto,
    'direccionConsultorioMedico': direccionConsultorioMedico,
    'cvesHospitalesAtencion': cvesHospitalesAtencion,
    'cveEstatus': cveEstatus,
    'correo': correo,
    'rfc': rfc,
    'cveEstado': cveEstado,
    'codigoAfiliacion': codigoAfiliacion,
    'uid': uid,
  };
}
