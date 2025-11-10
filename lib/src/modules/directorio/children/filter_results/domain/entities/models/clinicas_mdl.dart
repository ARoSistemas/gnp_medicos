import 'dart:convert';

class ClinicaMdl {
  ClinicaMdl({
    required this.categorizador,
    required this.claveGestion,
    required this.claveTipoClinica,
    required this.tipoClinica,
    required this.nombreComercial,
    required this.sitioWeb,
    required this.telefono,
    required this.maps,
    required this.longitud,
    required this.telefonoCompleto,
    required this.cp,
    required this.extensionTelefono,
    required this.claveEstado,
    required this.estado,
    required this.calleNumero,
    required this.claveMunicipio,
    required this.direccionCompleta,
    required this.municipio,
    required this.colonia,
    required this.ladaTelefono,
    required this.latitud,
    required this.bndirectorio,
    required this.nivelHospitalarioAbreviado,
    required this.nivelHospitalarioCompleto,
    required this.nivelHosptilarioNuevoEsquema,
    required this.nivelHosptilarioViejoEsquema,
    required this.nivelHosptilarioNuevaGama,
    required this.banFueraRed,
  });

  factory ClinicaMdl.fromJson(String str) =>
      ClinicaMdl.fromMap(json.decode(str));

  factory ClinicaMdl.fromMap(Map<String, dynamic> json) {
    final dynamic tmp = json['categorizador'];
    double categorizadorDouble = 0;
    if (tmp == null) {
      categorizadorDouble = (tmp is int) ? tmp.toDouble() : 0.0;
    }
    return ClinicaMdl(
      categorizador: categorizadorDouble,
      claveGestion: json['claveGestion'] ?? '',
      claveTipoClinica: json['claveTipoClinica'] ?? 0,
      tipoClinica: json['tipoClinica'] ?? '',
      nombreComercial: json['nombreComercial'] ?? '',
      sitioWeb: json['sitioWeb'] ?? '',
      telefono: json['telefono'] ?? '',
      maps: json['maps'] ?? '',
      longitud: json['longitud'] ?? '',
      telefonoCompleto: json['telefonoCompleto'] ?? '',
      cp: json['cp'] ?? '',
      extensionTelefono: json['extensionTelefono'] ?? '',
      claveEstado: json['claveEstado'] ?? '',
      estado: json['estado'] ?? '',
      calleNumero: json['calleNumero'] ?? '',
      claveMunicipio: json['claveMunicipio'] ?? '',
      direccionCompleta: json['direccionCompleta'] ?? '',
      municipio: json['municipio'] ?? '',
      colonia: json['colonia'] ?? '',
      ladaTelefono: json['ladaTelefono'] ?? '',
      latitud: json['latitud'] ?? '',
      bndirectorio: json['bndirectorio'] ?? '',
      nivelHospitalarioAbreviado: json['nivelHospitalarioAbreviado'] ?? '',
      nivelHospitalarioCompleto: json['nivelHospitalarioCompleto'] ?? '',
      nivelHosptilarioNuevoEsquema: json['nivelHosptilarioNuevoEsquema'] ?? '',
      nivelHosptilarioViejoEsquema: json['nivelHosptilarioViejoEsquema'] ?? '',
      nivelHosptilarioNuevaGama: json['nivelHosptilarioNuevaGama'] ?? '',
      banFueraRed: json['banFueraRed'] ?? false,
    );
  }

  double categorizador;
  String claveGestion;
  int claveTipoClinica;
  String tipoClinica;
  String nombreComercial;
  String sitioWeb;
  String telefono;
  String maps;
  String longitud;
  String telefonoCompleto;
  String cp;
  String extensionTelefono;
  String claveEstado;
  String estado;
  String calleNumero;
  String claveMunicipio;
  String direccionCompleta;
  String municipio;
  String colonia;
  String ladaTelefono;
  String latitud;
  String bndirectorio;
  String nivelHospitalarioAbreviado;
  String nivelHospitalarioCompleto;
  String nivelHosptilarioNuevoEsquema;
  String nivelHosptilarioViejoEsquema;
  String nivelHosptilarioNuevaGama;
  bool banFueraRed;

  ClinicaMdl copyWith({
    double? categorizador,
    String? claveGestion,
    int? claveTipoClinica,
    String? tipoClinica,
    String? nombreComercial,
    String? sitioWeb,
    String? telefono,
    String? maps,
    String? longitud,
    String? telefonoCompleto,
    String? cp,
    String? extensionTelefono,
    String? claveEstado,
    String? estado,
    String? calleNumero,
    String? claveMunicipio,
    String? direccionCompleta,
    String? municipio,
    String? colonia,
    String? ladaTelefono,
    String? latitud,
    String? bndirectorio,
    String? nivelHospitalarioAbreviado,
    String? nivelHospitalarioCompleto,
    String? nivelHosptilarioNuevoEsquema,
    String? nivelHosptilarioViejoEsquema,
    String? nivelHosptilarioNuevaGama,
    bool? banFueraRed,
  }) => ClinicaMdl(
    categorizador: categorizador ?? this.categorizador,
    claveGestion: claveGestion ?? this.claveGestion,
    claveTipoClinica: claveTipoClinica ?? this.claveTipoClinica,
    tipoClinica: tipoClinica ?? this.tipoClinica,
    nombreComercial: nombreComercial ?? this.nombreComercial,
    sitioWeb: sitioWeb ?? this.sitioWeb,
    telefono: telefono ?? this.telefono,
    maps: maps ?? this.maps,
    longitud: longitud ?? this.longitud,
    telefonoCompleto: telefonoCompleto ?? this.telefonoCompleto,
    cp: cp ?? this.cp,
    extensionTelefono: extensionTelefono ?? this.extensionTelefono,
    claveEstado: claveEstado ?? this.claveEstado,
    estado: estado ?? this.estado,
    calleNumero: calleNumero ?? this.calleNumero,
    claveMunicipio: claveMunicipio ?? this.claveMunicipio,
    direccionCompleta: direccionCompleta ?? this.direccionCompleta,
    municipio: municipio ?? this.municipio,
    colonia: colonia ?? this.colonia,
    ladaTelefono: ladaTelefono ?? this.ladaTelefono,
    latitud: latitud ?? this.latitud,
    bndirectorio: bndirectorio ?? this.bndirectorio,
    nivelHospitalarioAbreviado:
        nivelHospitalarioAbreviado ?? this.nivelHospitalarioAbreviado,
    nivelHospitalarioCompleto:
        nivelHospitalarioCompleto ?? this.nivelHospitalarioCompleto,
    nivelHosptilarioNuevoEsquema:
        nivelHosptilarioNuevoEsquema ?? this.nivelHosptilarioNuevoEsquema,
    nivelHosptilarioViejoEsquema:
        nivelHosptilarioViejoEsquema ?? this.nivelHosptilarioViejoEsquema,
    nivelHosptilarioNuevaGama:
        nivelHosptilarioNuevaGama ?? this.nivelHosptilarioNuevaGama,
    banFueraRed: banFueraRed ?? this.banFueraRed,
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'categorizador': categorizador,
    'claveGestion': claveGestion,
    'claveTipoClinica': claveTipoClinica,
    'tipoClinica': tipoClinica,
    'nombreComercial': nombreComercial,
    'sitioWeb': sitioWeb,
    'telefono': telefono,
    'maps': maps,
    'longitud': longitud,
    'telefonoCompleto': telefonoCompleto,
    'cp': cp,
    'extensionTelefono': extensionTelefono,
    'claveEstado': claveEstado,
    'estado': estado,
    'calleNumero': calleNumero,
    'claveMunicipio': claveMunicipio,
    'direccionCompleta': direccionCompleta,
    'municipio': municipio,
    'colonia': colonia,
    'ladaTelefono': ladaTelefono,
    'latitud': latitud,
    'bndirectorio': bndirectorio,
    'nivelHospitalarioAbreviado': nivelHospitalarioAbreviado,
    'nivelHospitalarioCompleto': nivelHospitalarioCompleto,
    'nivelHosptilarioNuevoEsquema': nivelHosptilarioNuevoEsquema,
    'nivelHosptilarioViejoEsquema': nivelHosptilarioViejoEsquema,
    'nivelHosptilarioNuevaGama': nivelHosptilarioNuevaGama,
    'banFueraRed': banFueraRed,
  };
}
