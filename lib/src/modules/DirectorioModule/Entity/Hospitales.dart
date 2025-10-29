class ResultadoHospitales {
  int? registrosTotales;
  int? pagActual;
  int? pagTotales;
  String? alertaConsulta;
  List<GruposHospitalarios>? gruposHospitalarios;

  ResultadoHospitales(
      {this.registrosTotales,
      this.pagActual,
      this.pagTotales,
      this.alertaConsulta,
      this.gruposHospitalarios});

  ResultadoHospitales.fromJson(Map<String, dynamic> json) {
    registrosTotales = json['registrosTotales'];
    pagActual = json['pagActual'];
    pagTotales = json['pagTotales'];
    alertaConsulta = json['alertaConsulta'];
    if (json['gruposHospitalarios'] != null) {
      gruposHospitalarios = <GruposHospitalarios>[];
      json['gruposHospitalarios'].forEach((v) {
        gruposHospitalarios!.add(new GruposHospitalarios.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['registrosTotales'] = this.registrosTotales;
    data['pagActual'] = this.pagActual;
    data['pagTotales'] = this.pagTotales;
    data['alertaConsulta'] = this.alertaConsulta;
    if (this.gruposHospitalarios != null) {
      data['gruposHospitalarios'] =
          this.gruposHospitalarios!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GruposHospitalarios {
  bool? banNivelContratado;
  String? etiquetaGrupoBusqueda;
  List<Hospitales>? hospitales;

  GruposHospitalarios(
      {this.banNivelContratado, this.etiquetaGrupoBusqueda, this.hospitales});

  GruposHospitalarios.fromJson(Map<String, dynamic> json) {
    banNivelContratado = json['banNivelContratado'];
    etiquetaGrupoBusqueda = json['etiquetaGrupoBusqueda'];
    if (json['hospitales'] != null) {
      hospitales = <Hospitales>[];
      json['hospitales'].forEach((v) {
        hospitales!.add(new Hospitales.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banNivelContratado'] = this.banNivelContratado;
    data['etiquetaGrupoBusqueda'] = this.etiquetaGrupoBusqueda;
    if (this.hospitales != null) {
      data['hospitales'] = this.hospitales!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hospitales {
  String? idHospital;
  String? razonSocial;
  String? nombreComercial;
  String? rfc;
  String? codigoFiliacion;
  double? categorizador;
  String? nivelHosptilarioNuevoEsquema;
  String? nivelHosptilarioViejoEsquema;
  String? nivelHospitalarioAbreviado;
  String? nivelHospitalarioCompleto;
  String? latitud;
  String? longitud;
  String? maps;
  String? cp;
  String? estado;
  String? claveEstado;
  String? municipio;
  String? claveMunicipio;
  String? colonia;
  String? calleNumero;
  String? direccionCompleta;
  String? sitioWeb;
  String? ladaTelefono;
  String? extensionTelefono;
  String? telefono;
  String? telefonoCompleto;
  bool? centroDeAtencion;
  String? banTipoMensaje;
  String? mensaje;
  String? accesoHospitalario;

  Hospitales({
    this.idHospital,
    this.razonSocial,
    this.nombreComercial,
    this.rfc,
    this.codigoFiliacion,
    this.categorizador,
    this.nivelHosptilarioNuevoEsquema,
    this.nivelHosptilarioViejoEsquema,
    this.nivelHospitalarioAbreviado,
    this.nivelHospitalarioCompleto,
    this.latitud,
    this.longitud,
    this.maps,
    this.cp,
    this.estado,
    this.claveEstado,
    this.municipio,
    this.claveMunicipio,
    this.colonia,
    this.calleNumero,
    this.direccionCompleta,
    this.sitioWeb,
    this.ladaTelefono,
    this.extensionTelefono,
    this.telefono,
    this.telefonoCompleto,
    this.centroDeAtencion,
    this.banTipoMensaje,
    this.mensaje,
    this.accesoHospitalario,
  });

  Hospitales.fromJson(Map<String, dynamic> json) {
    idHospital = json['idHospital'];
    razonSocial = json['razonSocial'];
    nombreComercial = json['nombreComercial'];
    rfc = json['rfc'];
    codigoFiliacion = json['codigoFiliacion'];
    categorizador = json['categorizador'];
    nivelHosptilarioNuevoEsquema = json['nivelHosptilarioNuevoEsquema'];
    nivelHosptilarioViejoEsquema = json['nivelHosptilarioViejoEsquema'];
    nivelHospitalarioAbreviado = json['nivelHospitalarioAbreviado'];
    nivelHospitalarioCompleto = json['nivelHospitalarioCompleto'];
    latitud = json['latitud'];
    longitud = json['longitud'];
    maps = json['maps'];
    cp = json['cp'];
    estado = json['estado'];
    claveEstado = json['claveEstado'];
    municipio = json['municipio'];
    claveMunicipio = json['claveMunicipio'];
    colonia = json['colonia'];
    calleNumero = json['calleNumero'];
    direccionCompleta = json['direccionCompleta'];
    sitioWeb = json['sitioWeb'];
    ladaTelefono = json['ladaTelefono'];
    extensionTelefono = json['extensionTelefono'];
    telefono = json['telefono'];
    telefonoCompleto = json['telefonoCompleto'];
    centroDeAtencion = json['centroDeAtencion'];
    banTipoMensaje = json['banTipoMensaje'];
    mensaje = json['mensaje'];
    accesoHospitalario = json['accesoHospitalario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idHospital'] = this.idHospital;
    data['razonSocial'] = this.razonSocial;
    data['nombreComercial'] = this.nombreComercial;
    data['codigoFiliacion'] = this.codigoFiliacion;
    data['categorizador'] = this.categorizador;
    data['nivelHosptilarioNuevoEsquema'] = this.nivelHosptilarioNuevoEsquema;
    data['nivelHosptilarioViejoEsquema'] = this.nivelHosptilarioViejoEsquema;
    data['nivelHospitalarioAbreviado'] = this.nivelHospitalarioAbreviado;
    data['nivelHospitalarioCompleto'] = this.nivelHospitalarioCompleto;
    data['latitud'] = this.latitud;
    data['longitud'] = this.longitud;
    data['maps'] = this.maps;
    data['cp'] = this.cp;
    data['estado'] = this.estado;
    data['claveEstado'] = this.claveEstado;
    data['municipio'] = this.municipio;
    data['claveMunicipio'] = this.claveMunicipio;
    data['colonia'] = this.colonia;
    data['calleNumero'] = this.calleNumero;
    data['direccionCompleta'] = this.direccionCompleta;
    data['sitioWeb'] = this.sitioWeb;
    data['ladaTelefono'] = this.ladaTelefono;
    data['extensionTelefono'] = this.extensionTelefono;
    data['telefono'] = this.telefono;
    data['telefonoCompleto'] = this.telefonoCompleto;
    data['centroDeAtencion'] = this.centroDeAtencion;
    data['banTipoMensaje'] = this.banTipoMensaje;
    data['mensaje'] = this.mensaje;
    return data;
  }
}
