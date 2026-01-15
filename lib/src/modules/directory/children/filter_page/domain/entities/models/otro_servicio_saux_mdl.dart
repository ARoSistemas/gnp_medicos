import 'dart:convert';

class OtroServicioSauxMdl {
  OtroServicioSauxMdl({
    required this.registrosTotales,
    required this.pagActual,
    required this.pagTotales,
    required this.gruposSauxs,
  });

  factory OtroServicioSauxMdl.fromJson(String str) =>
      OtroServicioSauxMdl.fromMap(json.decode(str));

  factory OtroServicioSauxMdl.fromMap(Map<String, dynamic> json) =>
      OtroServicioSauxMdl(
        registrosTotales: json['registrosTotales'] ?? 0,
        pagActual: json['pagActual'] ?? 0,
        pagTotales: json['pagTotales'] ?? 0,
        gruposSauxs: json['gruposSauxs'] != null
            ? List<GruposSaux>.from(
                (json['gruposSauxs'] as List).map((x) => GruposSaux.fromMap(x)),
              )
            : [],
      );
  int registrosTotales;
  int pagActual;
  int pagTotales;
  List<GruposSaux> gruposSauxs;

  OtroServicioSauxMdl copyWith({
    int? registrosTotales,
    int? pagActual,
    int? pagTotales,
    List<GruposSaux>? gruposSauxs,
  }) => OtroServicioSauxMdl(
    registrosTotales: registrosTotales ?? this.registrosTotales,
    pagActual: pagActual ?? this.pagActual,
    pagTotales: pagTotales ?? this.pagTotales,
    gruposSauxs: gruposSauxs ?? this.gruposSauxs,
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'registrosTotales': registrosTotales,
    'pagActual': pagActual,
    'pagTotales': pagTotales,
    'gruposSauxs': List<dynamic>.from(gruposSauxs.map((x) => x.toMap())),
  };
}

class GruposSaux {
  GruposSaux({
    required this.etiquetaGrupoBusqueda,
    required this.sauxs,
  });

  factory GruposSaux.fromJson(String str) =>
      GruposSaux.fromMap(json.decode(str));

  factory GruposSaux.fromMap(Map<String, dynamic> json) => GruposSaux(
    etiquetaGrupoBusqueda: json['etiquetaGrupoBusqueda'] ?? '',
    sauxs: json['sauxs'] != null
        ? List<Saux>.from((json['sauxs'] as List).map((x) => Saux.fromMap(x)))
        : [],
  );
  String etiquetaGrupoBusqueda;
  List<Saux> sauxs;

  GruposSaux copyWith({
    String? etiquetaGrupoBusqueda,
    List<Saux>? sauxs,
  }) => GruposSaux(
    etiquetaGrupoBusqueda: etiquetaGrupoBusqueda ?? this.etiquetaGrupoBusqueda,
    sauxs: sauxs ?? this.sauxs,
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'etiquetaGrupoBusqueda': etiquetaGrupoBusqueda,
    'sauxs': List<dynamic>.from(sauxs.map((x) => x.toMap())),
  };
}

class Saux {
  Saux({
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

  factory Saux.fromJson(String str) => Saux.fromMap(json.decode(str));

  factory Saux.fromMap(Map<String, dynamic> json) => Saux(
    claveGestion: json['claveGestion'] ?? '',
    claveTipoServicio: json['claveTipoServicio'] ?? 0,
    tipoServicio: json['tipoServicio'] ?? '',
    categorizador: json['categorizador'] ?? 0.0,
    nombreComercial: json['nombreComercial'] ?? '',
    maps: json['maps'] ?? '',
    latitud: json['latitud'] ?? '',
    longitud: json['longitud'] ?? '',
    cp: json['cp'] ?? '',
    claveEstado: json['claveEstado'] ?? '',
    estado: json['estado'] ?? '',
    claveMunicipio: json['claveMunicipio'] ?? '',
    municipio: json['municipio'] ?? '',
    colonia: json['colonia'] ?? '',
    direccionCompleta: json['direccionCompleta'] ?? '',
    calleNumero: json['calleNumero'] ?? '',
    extensionTelefono: json['extensionTelefono'] ?? '',
    ladaTelefono: json['ladaTelefono'] ?? '',
    telefonoCompleto: json['telefonoCompleto'] ?? '',
    telefono: json['telefono'] ?? '',
  );
  String claveGestion;
  int claveTipoServicio;
  String tipoServicio;
  double categorizador;
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

  Saux copyWith({
    String? claveGestion,
    int? claveTipoServicio,
    String? tipoServicio,
    double? categorizador,
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
  }) => Saux(
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
