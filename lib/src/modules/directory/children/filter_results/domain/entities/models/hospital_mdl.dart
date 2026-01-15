import 'dart:convert';

class HospitalMdl {
  HospitalMdl({
    required this.idHospital,
    required this.razonSocial,
    required this.nombreComercial,
    required this.rfc,
    required this.codigoFiliacion,
    required this.categorizador,
    required this.nivelHosptilarioNuevoEsquema,
    required this.nivelHosptilarioViejoEsquema,
    required this.nivelHosptilarioNuevaGama,
    required this.nivelHospitalarioAbreviado,
    required this.nivelHospitalarioCompleto,
    required this.latitud,
    required this.longitud,
    required this.maps,
    required this.cp,
    required this.estado,
    required this.claveEstado,
    required this.municipio,
    required this.claveMunicipio,
    required this.colonia,
    required this.calleNumero,
    required this.direccionCompleta,
    required this.sitioWeb,
    required this.ladaTelefono,
    required this.extensionTelefono,
    required this.telefono,
    required this.telefonoCompleto,
    required this.centroDeAtencion,
    required this.banTipoMensaje,
    required this.mensaje,
    required this.accesoHospitalario,
  });

  factory HospitalMdl.empty() => HospitalMdl(
    idHospital: '',
    razonSocial: '',
    nombreComercial: '',
    rfc: '',
    codigoFiliacion: '',
    categorizador: 0,
    nivelHosptilarioNuevoEsquema: '',
    nivelHosptilarioViejoEsquema: '',
    nivelHosptilarioNuevaGama: '',
    nivelHospitalarioAbreviado: '',
    nivelHospitalarioCompleto: '',
    latitud: '',
    longitud: '',
    maps: '',
    cp: '',
    estado: '',
    claveEstado: '',
    municipio: '',
    claveMunicipio: '',
    colonia: '',
    calleNumero: '',
    direccionCompleta: '',
    sitioWeb: '',
    ladaTelefono: '',
    extensionTelefono: '',
    telefono: '',
    telefonoCompleto: '',
    centroDeAtencion: false,
    banTipoMensaje: '',
    mensaje: '',
    accesoHospitalario: '',
  );

  factory HospitalMdl.fromJson(String str) =>
      HospitalMdl.fromMap(json.decode(str));

  factory HospitalMdl.fromMap(Map<String, dynamic> json) => HospitalMdl(
    idHospital: json['idHospital'] ?? '',
    razonSocial: json['razonSocial'] ?? '',
    nombreComercial: json['nombreComercial'] ?? '',
    rfc: json['rfc'] ?? '',
    codigoFiliacion: json['codigoFiliacion'] ?? '',
    categorizador: json['categorizador'] ?? 0,
    nivelHosptilarioNuevoEsquema: json['nivelHosptilarioNuevoEsquema'] ?? '',
    nivelHosptilarioViejoEsquema: json['nivelHosptilarioViejoEsquema'] ?? '',
    nivelHosptilarioNuevaGama: json['nivelHosptilarioNuevaGama'] ?? '',
    nivelHospitalarioAbreviado: json['nivelHospitalarioAbreviado'] ?? '',
    nivelHospitalarioCompleto: json['nivelHospitalarioCompleto'] ?? '',
    latitud: json['latitud'] ?? '',
    longitud: json['longitud'] ?? '',
    maps: json['maps'] ?? '',
    cp: json['cp'] ?? '',
    estado: json['estado'] ?? '',
    claveEstado: json['claveEstado'] ?? '',
    municipio: json['municipio'] ?? '',
    claveMunicipio: json['claveMunicipio'] ?? '',
    colonia: json['colonia'] ?? '',
    calleNumero: json['calleNumero'] ?? '',
    direccionCompleta: json['direccionCompleta'] ?? '',
    sitioWeb: json['sitioWeb'] ?? '',
    ladaTelefono: json['ladaTelefono'] ?? '',
    extensionTelefono: json['extensionTelefono'] ?? '',
    telefono: json['telefono'] ?? '',
    telefonoCompleto: json['telefonoCompleto'] ?? '',
    centroDeAtencion: json['centroDeAtencion'] ?? false,
    banTipoMensaje: json['banTipoMensaje'] ?? '',
    mensaje: json['mensaje'] ?? '',
    accesoHospitalario: json['accesoHospitalario'] ?? '',
  );

  String idHospital;
  String razonSocial;
  String nombreComercial;
  String rfc;
  String codigoFiliacion;
  int categorizador;
  String nivelHosptilarioNuevoEsquema;
  String nivelHosptilarioViejoEsquema;
  String nivelHosptilarioNuevaGama;
  String nivelHospitalarioAbreviado;
  String nivelHospitalarioCompleto;
  String latitud;
  String longitud;
  String maps;
  String cp;
  String estado;
  String claveEstado;
  String municipio;
  String claveMunicipio;
  String colonia;
  String calleNumero;
  String direccionCompleta;
  String sitioWeb;
  String ladaTelefono;
  String extensionTelefono;
  String telefono;
  String telefonoCompleto;
  bool centroDeAtencion;
  String banTipoMensaje;
  String mensaje;
  String accesoHospitalario;

  HospitalMdl copyWith({
    String? idHospital,
    String? razonSocial,
    String? nombreComercial,
    String? rfc,
    String? codigoFiliacion,
    int? categorizador,
    String? nivelHosptilarioNuevoEsquema,
    String? nivelHosptilarioViejoEsquema,
    String? nivelHosptilarioNuevaGama,
    String? nivelHospitalarioAbreviado,
    String? nivelHospitalarioCompleto,
    String? latitud,
    String? longitud,
    String? maps,
    String? cp,
    String? estado,
    String? claveEstado,
    String? municipio,
    String? claveMunicipio,
    String? colonia,
    String? calleNumero,
    String? direccionCompleta,
    String? sitioWeb,
    String? ladaTelefono,
    String? extensionTelefono,
    String? telefono,
    String? telefonoCompleto,
    bool? centroDeAtencion,
    String? banTipoMensaje,
    String? mensaje,
    String? accesoHospitalario,
  }) => HospitalMdl(
    idHospital: idHospital ?? this.idHospital,
    razonSocial: razonSocial ?? this.razonSocial,
    nombreComercial: nombreComercial ?? this.nombreComercial,
    rfc: rfc ?? this.rfc,
    codigoFiliacion: codigoFiliacion ?? this.codigoFiliacion,
    categorizador: categorizador ?? this.categorizador,
    nivelHosptilarioNuevoEsquema:
        nivelHosptilarioNuevoEsquema ?? this.nivelHosptilarioNuevoEsquema,
    nivelHosptilarioViejoEsquema:
        nivelHosptilarioViejoEsquema ?? this.nivelHosptilarioViejoEsquema,
    nivelHosptilarioNuevaGama:
        nivelHosptilarioNuevaGama ?? this.nivelHosptilarioNuevaGama,
    nivelHospitalarioAbreviado:
        nivelHospitalarioAbreviado ?? this.nivelHospitalarioAbreviado,
    nivelHospitalarioCompleto:
        nivelHospitalarioCompleto ?? this.nivelHospitalarioCompleto,
    latitud: latitud ?? this.latitud,
    longitud: longitud ?? this.longitud,
    maps: maps ?? this.maps,
    cp: cp ?? this.cp,
    estado: estado ?? this.estado,
    claveEstado: claveEstado ?? this.claveEstado,
    municipio: municipio ?? this.municipio,
    claveMunicipio: claveMunicipio ?? this.claveMunicipio,
    colonia: colonia ?? this.colonia,
    calleNumero: calleNumero ?? this.calleNumero,
    direccionCompleta: direccionCompleta ?? this.direccionCompleta,
    sitioWeb: sitioWeb ?? this.sitioWeb,
    ladaTelefono: ladaTelefono ?? this.ladaTelefono,
    extensionTelefono: extensionTelefono ?? this.extensionTelefono,
    telefono: telefono ?? this.telefono,
    telefonoCompleto: telefonoCompleto ?? this.telefonoCompleto,
    centroDeAtencion: centroDeAtencion ?? this.centroDeAtencion,
    banTipoMensaje: banTipoMensaje ?? this.banTipoMensaje,
    mensaje: mensaje ?? this.mensaje,
    accesoHospitalario: accesoHospitalario ?? this.accesoHospitalario,
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'idHospital': idHospital,
    'razonSocial': razonSocial,
    'nombreComercial': nombreComercial,
    'rfc': rfc,
    'codigoFiliacion': codigoFiliacion,
    'categorizador': categorizador,
    'nivelHosptilarioNuevoEsquema': nivelHosptilarioNuevoEsquema,
    'nivelHosptilarioViejoEsquema': nivelHosptilarioViejoEsquema,
    'nivelHosptilarioNuevaGama': nivelHosptilarioNuevaGama,
    'nivelHospitalarioAbreviado': nivelHospitalarioAbreviado,
    'nivelHospitalarioCompleto': nivelHospitalarioCompleto,
    'latitud': latitud,
    'longitud': longitud,
    'maps': maps,
    'cp': cp,
    'estado': estado,
    'claveEstado': claveEstado,
    'municipio': municipio,
    'claveMunicipio': claveMunicipio,
    'colonia': colonia,
    'calleNumero': calleNumero,
    'direccionCompleta': direccionCompleta,
    'sitioWeb': sitioWeb,
    'ladaTelefono': ladaTelefono,
    'extensionTelefono': extensionTelefono,
    'telefono': telefono,
    'telefonoCompleto': telefonoCompleto,
    'centroDeAtencion': centroDeAtencion,
    'banTipoMensaje': banTipoMensaje,
    'mensaje': mensaje,
    'accesoHospitalario': accesoHospitalario,
  };
}
