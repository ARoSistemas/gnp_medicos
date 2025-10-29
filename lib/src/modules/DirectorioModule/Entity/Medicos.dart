class ResultadoMedicos {
  int? registrosTotales;
  int? pagActual;
  int? pagTotales;
  List<GruposMedicos>? gruposMedicos;

  ResultadoMedicos({ this.gruposMedicos});

  ResultadoMedicos.fromJson(Map<String, dynamic> json) {
    registrosTotales = json['registrosTotales'];
    pagActual = json['pagActual'];
    pagTotales = json['pagTotales'];
    if (json['gruposMedicos'] != null) {
      gruposMedicos = <GruposMedicos>[];
      json['gruposMedicos'].forEach((v) {
        gruposMedicos?.add(new GruposMedicos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.gruposMedicos != null) {
      data['gruposMedicos'] =
          this.gruposMedicos?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class GruposMedicos {
  //bool banNivelContratado;
  String? etiquetaGrupoBusqueda;
  List<Medicos>? medicos;

  GruposMedicos({this.etiquetaGrupoBusqueda, this.medicos});

  GruposMedicos.fromJson(Map<String, dynamic> json) {
    // banNivelContratado = json['banNivelContratado'];
    etiquetaGrupoBusqueda = json['etiquetaGrupoBusqueda'];
    if (json['medicos'] != null) {
      medicos = <Medicos>[];
      json['medicos'].forEach((v) {
        medicos!.add(new Medicos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['banNivelContratado'] = this.banNivelContratado;
    data['etiquetaGrupoBusqueda'] = this.etiquetaGrupoBusqueda;
    if (this.medicos != null) {
      data['medicos'] = this.medicos?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Medicos {
  double? categorizador;
  String? claveConvenio;
  String? codigoFiliacion;
  String? rfc;
  String? apellidoPaterno;
  String? apellidoMaterno;
  String? nombre;
  String? nombreConcatenado;
  String? claveCirculoMedico;
  String? circuloMedico;
  String? claveEspecialidad;
  String? especialidad;
  String? claveSubespecialidad;
  String? subespecialidad;
  String? descripcionsubespecialidad;
  String? descripcionMedico;
  String? sitioWeb;
  String? centroDeAtencion;
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
  String? correo;
  String? tabuladorNG;
  String? claveTabuladorNG;

  Medicos({
    this.categorizador,
    this.claveConvenio,
    this.codigoFiliacion,
    this.rfc,
    this.apellidoPaterno,
    this.apellidoMaterno,
    this.nombre,
    this.nombreConcatenado,
    this.claveCirculoMedico,
    this.circuloMedico,
    this.claveEspecialidad,
    this.especialidad,
    this.claveSubespecialidad,
    this.subespecialidad,
    this.descripcionsubespecialidad,
    this.descripcionMedico,
    this.sitioWeb,
    this.centroDeAtencion,
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
    this.correo,
    this.tabuladorNG,
    this.claveTabuladorNG,
  });

  Medicos.fromJson(Map<String, dynamic> json) {
    categorizador = json['categorizador'];
    claveConvenio = json['claveConvenio'];
    codigoFiliacion = json['codigoFiliacion'];
    rfc = json['rfc'];
    apellidoPaterno = json['apellidoPaterno'];
    apellidoMaterno = json['apellidoMaterno'];
    nombre = json['nombre'];
    nombreConcatenado  = json['nombreConcatenado'];
    claveCirculoMedico = json['claveCirculoMedico'];
    circuloMedico = json['circuloMedico'];
    claveEspecialidad = json['claveEspecialidad'];
    especialidad = json['especialidad'];
    claveSubespecialidad = json['claveSubespecialidad'];
    subespecialidad = json['subespecialidad'];
    descripcionsubespecialidad = json['descripcionsubespecialidad'];
    descripcionMedico = json['descripcionMedico'];
    sitioWeb = json['sitioWeb'];
    centroDeAtencion = json['centroDeAtencion'];
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
    correo = json['correo'];
    tabuladorNG = json['tabuladorNG'];
    claveTabuladorNG = json['claveTabuladorNG'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categorizador'] = this.categorizador;
    data['claveConvenio'] = this.claveConvenio;
    data['codigoFiliacion'] = this.codigoFiliacion;
    data['rfc'] = this.rfc;
    data['apellidoPaterno'] = this.apellidoPaterno;
    data['apellidoMaterno'] = this.apellidoMaterno;
    data['nombre'] = this.nombre;
    data['nombreConcatenado'] = this.nombreConcatenado;
    data['claveCirculoMedico'] = this.claveCirculoMedico;
    data['circuloMedico'] = this.circuloMedico;
    data['claveEspecialidad'] = this.claveEspecialidad;
    data['especialidad'] = this.especialidad;
    data['claveSubespecialidad'] = this.claveSubespecialidad;
    data['subespecialidad'] = this.subespecialidad;
    data['descripcionsubespecialidad'] = this.descripcionsubespecialidad;
    data['descripcionMedico'] = this.descripcionMedico ;
    data['sitioWeb'] = this.sitioWeb;
    data['centroDeAtencion'] = this.centroDeAtencion;
    data['latitud'] = this.latitud;
    data['longitud'] = this.longitud;
    data['cp'] = this.cp;
    data['estado'] = this.estado;
    data['claveEstado'] = this.claveEstado;
    data['claveEstado'] = this.municipio;
    data['claveMunicipio'] = this.claveMunicipio;
    data['colonia'] = this.colonia;
    data['calleNumero'] = this.calleNumero;
    data['direccionCompleta'] = this.direccionCompleta;
    data['ladaTelefono'] = this.ladaTelefono;
    data['extensionTelefono'] = this.extensionTelefono;
    data['telefono'] = this.telefono;
    data['telefonoCompleto'] = this.telefonoCompleto;
    data['maps'] = this.maps;
    data['correo'] = this.correo;
    return data;
  }
}