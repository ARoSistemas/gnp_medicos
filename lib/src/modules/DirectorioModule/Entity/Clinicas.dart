  class ResultadoClinicas {
  int? registrosTotales;
  int? pagActual;
  int? pagTotales;
  List<GruposClinicas>? gruposClinicas;

  ResultadoClinicas({this.registrosTotales, this.pagActual, this.pagTotales, this.gruposClinicas});

  ResultadoClinicas.fromJson(Map<String, dynamic> json) {
    registrosTotales = json['registrosTotales'];
    pagActual = json['pagActual'];
    pagTotales = json['pagTotales'];
    if (json['gruposClinicas'] != null) {
      gruposClinicas = <GruposClinicas>[];
      json['gruposClinicas'].forEach((v) {
        gruposClinicas!.add(new GruposClinicas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['registrosTotales'] = this.registrosTotales;
    data['pagActual'] = this.pagActual;
    data['pagTotales'] = this.pagTotales;
    if (this.gruposClinicas != null) {
      data['gruposClinicas'] =
          this.gruposClinicas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GruposClinicas {
  String? etiquetaGrupoBusqueda;
  List<Clinicas>? clinicas;

  GruposClinicas({this.etiquetaGrupoBusqueda, this.clinicas});

  GruposClinicas.fromJson(Map<String, dynamic> json) {
    etiquetaGrupoBusqueda = json['etiquetaGrupoBusqueda'];
    if (json['clinicas'] != null) {
      clinicas = <Clinicas>[];
      json['clinicas'].forEach((v) {
        clinicas!.add(new Clinicas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['etiquetaGrupoBusqueda'] = this.etiquetaGrupoBusqueda;
    if (this.clinicas != null) {
      data['clinicas'] = this.clinicas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Clinicas {
  num? categorizador;
  String? claveGestion;
  int? claveTipoClinica;
  String? tipoClinica;
  String? nombreComercial;
  String? sitioWeb;
  String? latitud;
  String? longitud;
  String? cp;
  String? estado;
  String? claveEstado;
  String? municipio;
  String? claveMunicipio;
  String? colonia;
  String? calleNumero;
  String? direccionCompleta;
  String? ladaTelefono;
  String? extensionTelefono;
  String? telefono;
  String? telefonoCompleto;
  String? maps;
  String? nivelHospitalarioCompleto;
  String? nivelHospitalarioAbreviado;
  String? nivelHosptilarioNuevaGama;
  String? nivelHosptilarioNuevoEsquema;
  String? nivelHosptilarioViejoEsquema;

  Clinicas(
      {this.categorizador,
        this.claveGestion,
        this.claveTipoClinica,
        this.tipoClinica,
        this.nombreComercial,
        this.sitioWeb,
        this.latitud,
        this.longitud,
        this.cp,
        this.estado,
        this.claveEstado,
        this.municipio,
        this.claveMunicipio,
        this.colonia,
        this.calleNumero,
        this.direccionCompleta,
        this.ladaTelefono,
        this.extensionTelefono,
        this.telefono,
        this.telefonoCompleto,
        this.maps,
        this.nivelHospitalarioCompleto,
        this.nivelHospitalarioAbreviado,
        this.nivelHosptilarioNuevaGama,
        this.nivelHosptilarioNuevoEsquema,
        this.nivelHosptilarioViejoEsquema,
      });

  Clinicas.fromJson(Map<String, dynamic> json) {
    categorizador = json['categorizador'];
    claveGestion = json['claveGestion'];
    claveTipoClinica = json['claveTipoClinica'];
    tipoClinica = json['tipoClinica'];
    nombreComercial = json['nombreComercial'];
    sitioWeb = json['sitioWeb'];
    latitud = json['latitud'];
    longitud = json['longitud'];
    cp = json['cp'];
    estado = json['estado'];
    claveEstado = json['claveEstado'];
    municipio = json['municipio'];
    claveMunicipio = json['claveMunicipio'];
    colonia = json['colonia'];
    calleNumero = json['calleNumero'];
    direccionCompleta = json['direccionCompleta'];
    ladaTelefono = json['ladaTelefono'];
    extensionTelefono = json['extensionTelefono'];
    telefono = json['telefono'];
    telefonoCompleto = json['telefonoCompleto'];
    maps = json['maps'];
    nivelHospitalarioCompleto = json['nivelHospitalarioCompleto'];
    nivelHospitalarioAbreviado = json['nivelHospitalarioAbreviado'];
    nivelHosptilarioNuevaGama = json['nivelHosptilarioNuevaGama'];
    nivelHosptilarioNuevoEsquema = json['nivelHosptilarioNuevoEsquema'];
    nivelHosptilarioViejoEsquema = json['nivelHosptilarioViejoEsquema'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categorizador'] = this.categorizador;
    data['claveGestion'] = this.claveGestion;
    data['claveTipoClinica'] = this.claveTipoClinica;
    data['tipoClinica'] = this.tipoClinica;
    data['nombreComercial'] = this.nombreComercial;
    data['sitioWeb'] = this.sitioWeb;
    data['latitud'] = this.latitud;
    data['longitud'] = this.longitud;
    data['cp'] = this.cp;
    data['estado'] = this.estado;
    data['claveEstado'] = this.claveEstado;
    data['municipio'] = this.municipio;
    data['claveMunicipio'] = this.claveMunicipio;
    data['colonia'] = this.colonia;
    data['calleNumero'] = this.calleNumero;
    data['direccionCompleta'] = this.direccionCompleta;
    data['ladaTelefono'] = this.ladaTelefono;
    data['extensionTelefono'] = this.extensionTelefono;
    data['telefono'] = this.telefono;
    data['telefonoCompleto'] = this.telefonoCompleto;
    data['maps'] = this.maps;
    data['nivelHospitalarioCompleto'] = this.nivelHospitalarioCompleto;
    data['nivelHospitalarioAbreviado'] = this.nivelHospitalarioAbreviado;
    data['nivelHosptilarioNuevaGama'] = this.nivelHosptilarioNuevaGama;
    data['nivelHosptilarioNuevoEsquema'] = this.nivelHosptilarioNuevoEsquema;
    data['nivelHosptilarioViejoEsquema'] = this.nivelHosptilarioViejoEsquema;
    return data;
  }
}