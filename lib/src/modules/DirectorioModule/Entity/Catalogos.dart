class Planes {
  String? clavePlan;
  String? plan;

  Planes({this.clavePlan, this.plan});

  factory Planes.fromJson(Map<String, dynamic> parsedJson) {

    return Planes(
        clavePlan: parsedJson['clavePlan'],
        plan: parsedJson['plan']
    );

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clavePlan'] = this.clavePlan;
    data['plan'] = this.plan;
    return data;
  }
}

class TipoClinica {
  String? claveTipoClinica;
  String? tipoClinica;

  TipoClinica({this.claveTipoClinica, this.tipoClinica});

  factory TipoClinica.fromJson(Map<String, dynamic> parsedJson){

    return TipoClinica(
      claveTipoClinica: parsedJson["claveTipoClinica"],
      tipoClinica: parsedJson["tipoClinica"]
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['claveTipoClinica'] = this.claveTipoClinica;
    data['tipoClinica'] = this.tipoClinica;
    return data;
  }
}

class Especialidad {
  String? claveEspecialidad;
  String? especialidad;

  Especialidad({this.claveEspecialidad, this.especialidad});

  factory Especialidad.fromJson(Map<String, dynamic> parsedJson) {
   return Especialidad(
     claveEspecialidad: parsedJson["claveEspecialidad"],
     especialidad: parsedJson["especialidad"]
   );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['claveEspecialidad'] = this.claveEspecialidad;
    data['especialidad'] = this.especialidad;
    return data;
  }
}

class SubEspecialidad {
  String? claveSubespecialidad;
  String? subespecialidad;

  SubEspecialidad({this.claveSubespecialidad, this.subespecialidad});

  factory SubEspecialidad.fromJson(Map<String, dynamic> parsedJson) {
   return SubEspecialidad(
     claveSubespecialidad: parsedJson["claveSubespecialidad"],
     subespecialidad: parsedJson["subespecialidad"]
   );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['claveSubespecialidad'] = this.claveSubespecialidad;
    data['subespecialidad'] = this.subespecialidad;
    return data;
  }
}

class CirculoMedico {
  String? claveCirculoMedico;
  String? circuloMedico;

  CirculoMedico({this.claveCirculoMedico, this.circuloMedico});

  factory CirculoMedico.fromJson(Map<String, dynamic> parsedJson) {

    return CirculoMedico(
        claveCirculoMedico: parsedJson['claveCirculoMedico'],
        circuloMedico: parsedJson['circuloMedico']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['claveCirculoMedico'] = this.claveCirculoMedico;
    data['circuloMedico'] = this.circuloMedico;
    return data;
  }
}

class Estados {
  String? claveEstado;
  String? estado;

  Estados({this.claveEstado, this.estado});

  factory Estados.fromJson(Map<String, dynamic> parsedJson) {

    return Estados(
        claveEstado: parsedJson['claveEstado'],
        estado: parsedJson['estado']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['claveEstado'] = this.claveEstado;
    data['estado'] = this.estado;
    return data;
  }
}

class Municipios {
  String? claveEstado;
  String? claveMunicipio;
  String? municipio;
  String? cp;

  Municipios({this.claveEstado, this.claveMunicipio, this.municipio, this.cp});

  factory Municipios.fromJson(Map<String, dynamic> parsedJson) {

    return Municipios(
        claveEstado: parsedJson['claveEstado'],
        claveMunicipio: parsedJson['claveMunicipio'],
        municipio: parsedJson['municipio'],
        cp: parsedJson['cp']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['claveEstado'] = this.claveEstado;
    data['claveMunicipio'] = this.claveMunicipio;
    data['municipio'] = this.municipio;
    data['cp'] = this.cp;
    return data;
  }
}

class NivelHospitalario {
  String? claveNivelHospitalario;
  String? nivelHospitalario;
  bool? banContratado;
  String? relacion;
  String? mensaje;

  NivelHospitalario(
      {this.claveNivelHospitalario,
        this.nivelHospitalario,
        this.banContratado,
        this.relacion,
        this.mensaje});

  factory NivelHospitalario.fromJson(Map<String, dynamic> parsedJson) {

    return NivelHospitalario(
        claveNivelHospitalario: parsedJson['claveNivelHospitalario'],
        nivelHospitalario: parsedJson['nivelHospitalario'],
        banContratado: parsedJson['banContratado'],
        relacion: parsedJson['relacion'],
        mensaje: parsedJson['mensaje']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['claveNivelHospitalario'] = this.claveNivelHospitalario;
    data['nivelHospitalario'] = this.nivelHospitalario;
    data['banContratado'] = this.banContratado;
    data['relacion'] = this.relacion;
    data['mensaje'] = this.mensaje;
    return data;
  }
}

class TipoServicios {
  int? claveTipoProveedor;
  String? tipoProveedor;

  TipoServicios({this.claveTipoProveedor, this.tipoProveedor});

  factory TipoServicios.fromJson(Map<String, dynamic> parsedJson) {

    return TipoServicios(
        claveTipoProveedor: parsedJson['claveTipoProveedor'],
        tipoProveedor: parsedJson['tipoProveedor']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['claveTipoProveedor'] = this.claveTipoProveedor;
    data['tipoProveedor'] = this.tipoProveedor;
    return data;
  }
}


class PolizasUsuario {
  String? nombres;
  String? apePaterno;
  String? apeMaterno;
  String? numPoliza;
  String? circuloMedico;
  String? planComercial;
  String? cvePlanComercial;
  String? cveCirculoMedico;
  String? cveProdComercial;
  String? cveProdTecnico;

  PolizasUsuario({this.nombres, this.apePaterno, this.apeMaterno, this.numPoliza, this.circuloMedico, this.planComercial, this.cvePlanComercial, this.cveCirculoMedico, this.cveProdComercial, this.cveProdTecnico});

  factory PolizasUsuario.fromJson(Map<String, dynamic> parsedJson) {

    return PolizasUsuario(
        nombres: parsedJson['nombres'],
        apePaterno: parsedJson['apePaterno'],
        apeMaterno: parsedJson['apeMaterno'],
        numPoliza: parsedJson['numPoliza'],
        circuloMedico: parsedJson['circuloMedico'],
        planComercial: parsedJson['planComercial'],
        cvePlanComercial: parsedJson['cvePlanComercial'],
        cveCirculoMedico: parsedJson['cveCirculoMedico'],
        cveProdComercial: parsedJson['cveProdComercial'],
        cveProdTecnico: parsedJson['cveProdTecnico'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombres'] = this.nombres;
    data['apePaterno'] = this.apePaterno;
    data['apeMaterno'] = this.apeMaterno;
    data['numPoliza'] = this.numPoliza;
    data['circuloMedico'] = this.circuloMedico;
    data['planComercial'] = this.planComercial;
    data['cvePlanComercial'] = this.cvePlanComercial;
    data['cveCirculoMedico'] = this.cveCirculoMedico;
    data['cveProdComercial'] = this.cveProdComercial;
    data['cveProdTecnico'] = this.cveProdTecnico;
    return data;
  }
}