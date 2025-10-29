class OtSvMedicos {
  int? registrosTotales;
  int? pagActual;
  int? pagTotales;
  List<GrupoServiciosMedicos>? serviciosMedicos;

  OtSvMedicos({this.registrosTotales, this.pagActual, this.pagTotales, this.serviciosMedicos});

  OtSvMedicos.fromJson(Map<String, dynamic> json) {
    registrosTotales = json['registrosTotales'];
    pagActual = json['pagActual'];
    pagTotales = json['pagTotales'];
    if (json['gruposSauxs'] != null) {
      serviciosMedicos = [];
      json['gruposSauxs'].forEach((v) {
        serviciosMedicos?.add(new GrupoServiciosMedicos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['registrosTotales'] = this.registrosTotales;
    data['pagActual'] = this.pagActual;
    data['pagTotales'] = this.pagTotales;
    if (this.serviciosMedicos != null) {
      data['gruposSauxs'] =
          this.serviciosMedicos?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GrupoServiciosMedicos {
  String? etiquetaGrupoBusqueda;
  List<OtServiciosM>? listaServicios;

  GrupoServiciosMedicos({this.etiquetaGrupoBusqueda, this.listaServicios});

  GrupoServiciosMedicos.fromJson(Map<String, dynamic> json) {
    etiquetaGrupoBusqueda = json['etiquetaGrupoBusqueda'];
    if (json['sauxs'] != null) {
      listaServicios = [];
      json['sauxs'].forEach((v) {
        listaServicios?.add(new OtServiciosM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['etiquetaGrupoBusqueda'] = this.etiquetaGrupoBusqueda;
    if (this.listaServicios != null) {
      data['sauxs'] = this.listaServicios?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OtServiciosM {
  String? claveGestion;
  int? claveTipoServicio;
  String? tipoServicio;
  double? categorizador;
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
  String? nombreComercial;

  OtServiciosM(
      {this.categorizador,
        this.claveGestion,
        this.claveTipoServicio,
        this.tipoServicio,
        this.nombreComercial,
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
        this.maps});

  OtServiciosM.fromJson(Map<String, dynamic> json) {
    categorizador = json['categorizador'];
    claveGestion = json['claveGestion'];
    claveTipoServicio = json['claveTipoServicio'];
    tipoServicio = json['tipoServicio'];
    nombreComercial = json['nombreComercial'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categorizador'] = this.categorizador;
    data['claveGestion'] = this.claveGestion;
    data['claveTipoClinica'] = this.claveTipoServicio;
    data['tipoClinica'] = this.tipoServicio;
    data['nombreComercial'] = this.nombreComercial;
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
    return data;
  }
}