import 'dart:convert';

class SauxMdl {
  SauxMdl({
    required this.claveGestion,
    required this.claveTipoServicio,
    required this.tipoServicio,
    required this.categorizador,
    required this.nombreComercial,
    required this.maps,
    required this.latitud,
    required this.longitud,
    required this.cp,
    required this.claveEstado,
    required this.estado,
    required this.claveMunicipio,
    required this.municipio,
    required this.colonia,
    required this.direccionCompleta,
    required this.calleNumero,
    required this.extensionTelefono,
    required this.ladaTelefono,
    required this.telefonoCompleto,
    required this.telefono,
  });

  factory SauxMdl.fromJson(String str) => SauxMdl.fromMap(json.decode(str));

  factory SauxMdl.fromMap(Map<String, dynamic> json) => SauxMdl(
    claveGestion: json['claveGestion'],
    claveTipoServicio: json['claveTipoServicio'],
    tipoServicio: json['tipoServicio'],
    categorizador: json['categorizador'],
    nombreComercial: json['nombreComercial'],
    maps: json['maps'],
    latitud: json['latitud'],
    longitud: json['longitud'],
    cp: json['cp'],
    claveEstado: json['claveEstado'],
    estado: json['estado'],
    claveMunicipio: json['claveMunicipio'],
    municipio: json['municipio'],
    colonia: json['colonia'],
    direccionCompleta: json['direccionCompleta'],
    calleNumero: json['calleNumero'],
    extensionTelefono: json['extensionTelefono'],
    ladaTelefono: json['ladaTelefono'],
    telefonoCompleto: json['telefonoCompleto'],
    telefono: json['telefono'],
  );
  String claveGestion;
  int claveTipoServicio;
  String tipoServicio;
  int categorizador;
  String nombreComercial;
  String maps;
  String latitud;
  String longitud;
  String cp;
  String claveEstado;
  String estado;
  String claveMunicipio;
  String municipio;
  String colonia;
  String direccionCompleta;
  String calleNumero;
  String extensionTelefono;
  String ladaTelefono;
  String telefonoCompleto;
  String telefono;

  SauxMdl copyWith({
    String? claveGestion,
    int? claveTipoServicio,
    String? tipoServicio,
    int? categorizador,
    String? nombreComercial,
    String? maps,
    String? latitud,
    String? longitud,
    String? cp,
    String? claveEstado,
    String? estado,
    String? claveMunicipio,
    String? municipio,
    String? colonia,
    String? direccionCompleta,
    String? calleNumero,
    String? extensionTelefono,
    String? ladaTelefono,
    String? telefonoCompleto,
    String? telefono,
  }) => SauxMdl(
    claveGestion: claveGestion ?? this.claveGestion,
    claveTipoServicio: claveTipoServicio ?? this.claveTipoServicio,
    tipoServicio: tipoServicio ?? this.tipoServicio,
    categorizador: categorizador ?? this.categorizador,
    nombreComercial: nombreComercial ?? this.nombreComercial,
    maps: maps ?? this.maps,
    latitud: latitud ?? this.latitud,
    longitud: longitud ?? this.longitud,
    cp: cp ?? this.cp,
    claveEstado: claveEstado ?? this.claveEstado,
    estado: estado ?? this.estado,
    claveMunicipio: claveMunicipio ?? this.claveMunicipio,
    municipio: municipio ?? this.municipio,
    colonia: colonia ?? this.colonia,
    direccionCompleta: direccionCompleta ?? this.direccionCompleta,
    calleNumero: calleNumero ?? this.calleNumero,
    extensionTelefono: extensionTelefono ?? this.extensionTelefono,
    ladaTelefono: ladaTelefono ?? this.ladaTelefono,
    telefonoCompleto: telefonoCompleto ?? this.telefonoCompleto,
    telefono: telefono ?? this.telefono,
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'claveGestion': claveGestion,
    'claveTipoServicio': claveTipoServicio,
    'tipoServicio': tipoServicio,
    'categorizador': categorizador,
    'nombreComercial': nombreComercial,
    'maps': maps,
    'latitud': latitud,
    'longitud': longitud,
    'cp': cp,
    'claveEstado': claveEstado,
    'estado': estado,
    'claveMunicipio': claveMunicipio,
    'municipio': municipio,
    'colonia': colonia,
    'direccionCompleta': direccionCompleta,
    'calleNumero': calleNumero,
    'extensionTelefono': extensionTelefono,
    'ladaTelefono': ladaTelefono,
    'telefonoCompleto': telefonoCompleto,
    'telefono': telefono,
  };
}
