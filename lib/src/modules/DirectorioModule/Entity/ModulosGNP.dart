class ResultadosModulosGNP {
  int? registrosTotales;
  String? tipoAgrupacion;
  List<GruposModulos>? gruposModulos;

  ResultadosModulosGNP({this.registrosTotales, this.tipoAgrupacion, this.gruposModulos});

  ResultadosModulosGNP.fromJson(Map<String, dynamic> json) {
    registrosTotales = json['registrosTotales'];
    tipoAgrupacion = json['tipoAgrupacion'];
    if (json['gruposModulos'] != null) {
      gruposModulos = [];
      json['gruposModulos'].forEach((v) {
        gruposModulos?.add(new GruposModulos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['registrosTotales'] = this.registrosTotales;
    data['tipoAgrupacion'] = this.tipoAgrupacion;
    if (this.gruposModulos != null) {
      data['gruposModulos'] =
          this.gruposModulos?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GruposModulos {
  String? etiquetaGrupoBusqueda;
  List<Modulos>? modulos;

  GruposModulos({this.etiquetaGrupoBusqueda, this.modulos});

  GruposModulos.fromJson(Map<String, dynamic> json) {
    etiquetaGrupoBusqueda = json['etiquetaGrupoBusqueda'];
    if (json['modulos'] != null) {
      modulos = [];
      json['modulos'].forEach((v) {
        modulos!.add(new Modulos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['etiquetaGrupoBusqueda'] = this.etiquetaGrupoBusqueda;
    if (this.modulos != null) {
      data['modulos'] = this.modulos?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Modulos {
  double? categorizador;
  String? claveConvenio;
  String? nombreModulo;
  String? codigoFiliacion;
  String? centroDeAtencion;
  String? horarioInicioSemana;
  String? horarioFinSemana;
  String? horarioInicioFinDeSemana;
  String? horarioFinFinDeSemana;
  String? diaSinServicio;
  String? horarioConcatenado;
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

  Modulos(
      {this.categorizador,
        this.claveConvenio,
        this.nombreModulo,
        this.codigoFiliacion,
        this.centroDeAtencion,
        this.horarioInicioSemana,
        this.horarioFinSemana,
        this.horarioInicioFinDeSemana,
        this.horarioFinFinDeSemana,
        this.diaSinServicio,
        this.horarioConcatenado,
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

  Modulos.fromJson(Map<String, dynamic> json) {
    categorizador = json['categorizador'];
    claveConvenio = json['claveConvenio'];
    nombreModulo = json['nombreModulo'];
    codigoFiliacion = json['codigoFiliacion'];
    centroDeAtencion = json['centroDeAtencion'];
    horarioInicioSemana = json['horarioInicioSemana'];
    horarioFinSemana = json['horarioFinSemana'];
    horarioInicioFinDeSemana = json['horarioInicioFinDeSemana'];
    horarioFinFinDeSemana = json['horarioFinFinDeSemana'];
    diaSinServicio = json['diaSinServicio'];
    horarioConcatenado = json['horarioConcatenado'];
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
    data['claveConvenio'] = this.claveConvenio;
    data['nombreModulo'] = this.nombreModulo;
    data['codigoFiliacion'] = this.codigoFiliacion;
    data['centroDeAtencion'] = this.centroDeAtencion;
    data['horarioInicioSemana'] = this.horarioInicioSemana;
    data['horarioFinSemana'] = this.horarioFinSemana;
    data['horarioInicioFinDeSemana'] = this.horarioInicioFinDeSemana;
    data['horarioFinFinDeSemana'] = this.horarioFinFinDeSemana;
    data['diaSinServicio'] = this.diaSinServicio;
    data['horarioConcatenado'] = this.horarioConcatenado;
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