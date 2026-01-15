import 'dart:convert';

class MedicoMdl {
  MedicoMdl({
    required this.categorizador,
    required this.claveConvenio,
    required this.codigoFiliacion,
    required this.rfc,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.nombre,
    required this.nombreConcatenado,
    required this.claveCirculoMedico,
    required this.circuloMedico,
    required this.claveEspecialidad,
    required this.especialidad,
    required this.claveSubespecialidad,
    required this.subespecialidad,
    required this.descripcionsubespecialidad,
    required this.descripcionMedico,
    required this.sitioWeb,
    required this.centroDeAtencion,
    required this.correo,
    required this.latitud,
    required this.maps,
    required this.longitud,
    required this.estado,
    required this.cp,
    required this.claveEstado,
    required this.claveMunicipio,
    required this.municipio,
    required this.colonia,
    required this.calleNumero,
    required this.extensionTelefono,
    required this.ladaTelefono,
    required this.telefono,
    required this.direccionCompleta,
    required this.telefonoCompleto,
    required this.claveTabuladorNg,
    required this.tabuladorNg,
    required this.ngOrd,
  });

  factory MedicoMdl.empty() => MedicoMdl(
    categorizador: 0,
    claveConvenio: '',
    codigoFiliacion: '',
    rfc: '',
    apellidoPaterno: '',
    apellidoMaterno: '',
    nombre: '',
    nombreConcatenado: '',
    claveCirculoMedico: '',
    circuloMedico: '',
    claveEspecialidad: '',
    especialidad: '',
    claveSubespecialidad: '',
    subespecialidad: '',
    descripcionsubespecialidad: '',
    descripcionMedico: '',
    sitioWeb: '',
    centroDeAtencion: '',
    correo: '',
    latitud: '',
    maps: '',
    longitud: '',
    estado: '',
    cp: '',
    claveEstado: '',
    claveMunicipio: '',
    municipio: '',
    colonia: '',
    calleNumero: '',
    extensionTelefono: '',
    ladaTelefono: '',
    telefono: '',
    direccionCompleta: '',
    telefonoCompleto: '',
    claveTabuladorNg: '',
    tabuladorNg: '',
    ngOrd: 0,
  );

  factory MedicoMdl.fromJson(String str) => MedicoMdl.fromMap(json.decode(str));

  factory MedicoMdl.fromMap(Map<String, dynamic> json) {
    /// La llave categorizador, puede venir como int o double
    final dynamic tmpCat = json['categorizador'];
    double cat = 0;
    if (tmpCat != null) {
      cat = (tmpCat is int) ? cat = tmpCat.toDouble() : cat = tmpCat;
    }
    return MedicoMdl(
      categorizador: cat,
      claveConvenio: json['claveConvenio'] ?? '',
      codigoFiliacion: json['codigoFiliacion'] ?? '',
      rfc: json['rfc'] ?? '',
      apellidoPaterno: json['apellidoPaterno'] ?? '',
      apellidoMaterno: json['apellidoMaterno'] ?? '',
      nombre: json['nombre'] ?? '',
      nombreConcatenado: json['nombreConcatenado'] ?? '',
      claveCirculoMedico: json['claveCirculoMedico'] ?? '',
      circuloMedico: json['circuloMedico'] ?? '',
      claveEspecialidad: json['claveEspecialidad'] ?? '',
      especialidad: json['especialidad'] ?? '',
      claveSubespecialidad: json['claveSubespecialidad'] ?? '',
      subespecialidad: json['subespecialidad'] ?? '',
      descripcionsubespecialidad: json['descripcionsubespecialidad'] ?? '',
      descripcionMedico: json['descripcionMedico'] ?? '',
      sitioWeb: json['sitioWeb'] ?? '',
      centroDeAtencion: json['centroDeAtencion'] ?? '',
      correo: json['correo'] ?? '',
      latitud: json['latitud'] ?? '',
      maps: json['maps'] ?? '',
      longitud: json['longitud'] ?? '',
      estado: json['estado'] ?? '',
      cp: json['cp'] ?? '',
      claveEstado: json['claveEstado'] ?? '',
      claveMunicipio: json['claveMunicipio'] ?? '',
      municipio: json['municipio'] ?? '',
      colonia: json['colonia'] ?? '',
      calleNumero: json['calleNumero'] ?? '',
      extensionTelefono: json['extensionTelefono'] ?? '',
      ladaTelefono: json['ladaTelefono'] ?? '',
      telefono: json['telefono'] ?? '',
      direccionCompleta: json['direccionCompleta'] ?? '',
      telefonoCompleto: json['telefonoCompleto'] ?? '',
      claveTabuladorNg: json['claveTabuladorNG'] ?? '',
      tabuladorNg: json['tabuladorNG'] ?? '',
      ngOrd: json['ngOrd'] ?? 0,
    );
  }
  double categorizador;
  String claveConvenio;
  String codigoFiliacion;
  String rfc;
  String apellidoPaterno;
  String apellidoMaterno;
  String nombre;
  String nombreConcatenado;
  String claveCirculoMedico;
  String circuloMedico;
  String claveEspecialidad;
  String especialidad;
  String claveSubespecialidad;
  String subespecialidad;
  String descripcionsubespecialidad;
  String descripcionMedico;
  dynamic sitioWeb;
  dynamic centroDeAtencion;
  dynamic correo;
  String latitud;
  String maps;
  String longitud;
  String estado;
  String cp;
  String claveEstado;
  String claveMunicipio;
  String municipio;
  String colonia;
  String calleNumero;
  String extensionTelefono;
  String ladaTelefono;
  String telefono;
  String direccionCompleta;
  String telefonoCompleto;
  String claveTabuladorNg;
  String tabuladorNg;
  int ngOrd;

  MedicoMdl copyWith({
    double? categorizador,
    String? claveConvenio,
    String? codigoFiliacion,
    String? rfc,
    String? apellidoPaterno,
    String? apellidoMaterno,
    String? nombre,
    String? nombreConcatenado,
    String? claveCirculoMedico,
    String? circuloMedico,
    String? claveEspecialidad,
    String? especialidad,
    String? claveSubespecialidad,
    String? subespecialidad,
    String? descripcionsubespecialidad,
    String? descripcionMedico,
    dynamic sitioWeb,
    dynamic centroDeAtencion,
    dynamic correo,
    String? latitud,
    String? maps,
    String? longitud,
    String? estado,
    String? cp,
    String? claveEstado,
    String? claveMunicipio,
    String? municipio,
    String? colonia,
    String? calleNumero,
    String? extensionTelefono,
    String? ladaTelefono,
    String? telefono,
    String? direccionCompleta,
    String? telefonoCompleto,
    String? claveTabuladorNg,
    String? tabuladorNg,
    int? ngOrd,
  }) => MedicoMdl(
    categorizador: categorizador ?? this.categorizador,
    claveConvenio: claveConvenio ?? this.claveConvenio,
    codigoFiliacion: codigoFiliacion ?? this.codigoFiliacion,
    rfc: rfc ?? this.rfc,
    apellidoPaterno: apellidoPaterno ?? this.apellidoPaterno,
    apellidoMaterno: apellidoMaterno ?? this.apellidoMaterno,
    nombre: nombre ?? this.nombre,
    nombreConcatenado: nombreConcatenado ?? this.nombreConcatenado,
    claveCirculoMedico: claveCirculoMedico ?? this.claveCirculoMedico,
    circuloMedico: circuloMedico ?? this.circuloMedico,
    claveEspecialidad: claveEspecialidad ?? this.claveEspecialidad,
    especialidad: especialidad ?? this.especialidad,
    claveSubespecialidad: claveSubespecialidad ?? this.claveSubespecialidad,
    subespecialidad: subespecialidad ?? this.subespecialidad,
    descripcionsubespecialidad:
        descripcionsubespecialidad ?? this.descripcionsubespecialidad,
    descripcionMedico: descripcionMedico ?? this.descripcionMedico,
    sitioWeb: sitioWeb ?? this.sitioWeb,
    centroDeAtencion: centroDeAtencion ?? this.centroDeAtencion,
    correo: correo ?? this.correo,
    latitud: latitud ?? this.latitud,
    maps: maps ?? this.maps,
    longitud: longitud ?? this.longitud,
    estado: estado ?? this.estado,
    cp: cp ?? this.cp,
    claveEstado: claveEstado ?? this.claveEstado,
    claveMunicipio: claveMunicipio ?? this.claveMunicipio,
    municipio: municipio ?? this.municipio,
    colonia: colonia ?? this.colonia,
    calleNumero: calleNumero ?? this.calleNumero,
    extensionTelefono: extensionTelefono ?? this.extensionTelefono,
    ladaTelefono: ladaTelefono ?? this.ladaTelefono,
    telefono: telefono ?? this.telefono,
    direccionCompleta: direccionCompleta ?? this.direccionCompleta,
    telefonoCompleto: telefonoCompleto ?? this.telefonoCompleto,
    claveTabuladorNg: claveTabuladorNg ?? this.claveTabuladorNg,
    tabuladorNg: tabuladorNg ?? this.tabuladorNg,
    ngOrd: ngOrd ?? this.ngOrd,
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'categorizador': categorizador,
    'claveConvenio': claveConvenio,
    'codigoFiliacion': codigoFiliacion,
    'rfc': rfc,
    'apellidoPaterno': apellidoPaterno,
    'apellidoMaterno': apellidoMaterno,
    'nombre': nombre,
    'nombreConcatenado': nombreConcatenado,
    'claveCirculoMedico': claveCirculoMedico,
    'circuloMedico': circuloMedico,
    'claveEspecialidad': claveEspecialidad,
    'especialidad': especialidad,
    'claveSubespecialidad': claveSubespecialidad,
    'subespecialidad': subespecialidad,
    'descripcionsubespecialidad': descripcionsubespecialidad,
    'descripcionMedico': descripcionMedico,
    'sitioWeb': sitioWeb,
    'centroDeAtencion': centroDeAtencion,
    'correo': correo,
    'latitud': latitud,
    'maps': maps,
    'longitud': longitud,
    'estado': estado,
    'cp': cp,
    'claveEstado': claveEstado,
    'claveMunicipio': claveMunicipio,
    'municipio': municipio,
    'colonia': colonia,
    'calleNumero': calleNumero,
    'extensionTelefono': extensionTelefono,
    'ladaTelefono': ladaTelefono,
    'telefono': telefono,
    'direccionCompleta': direccionCompleta,
    'telefonoCompleto': telefonoCompleto,
    'claveTabuladorNG': claveTabuladorNg,
    'tabuladorNG': tabuladorNg,
    'ngOrd': ngOrd,
  };
}
