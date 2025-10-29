
class Parametros{

  String? origen;
  String? cvCirculoM;
  String? cvEspecialidad;
  bool? bandera;
  String? nombre;
  String? buscador;
  String? cvPlanH;
  String? cvTipo;
  String? cvEstado;
  String? cvMunicipio;
  int? claveConvenio;
  String? claveGestion;
  String? razonSocial;
  String? rfc;
  String? nombreComercial;
  String? idHospital;
  String? codigoFiliacion;
  String? claveLineaComercial;
  String? claveNivelHospitalario;
  String? productoTecnico;
  String? productoComercial;
  bool? filtros;
  int? pagina;
  DateTime? dateTime;
  String? descEstado;
  String? descMunicipio;
  String? tipoClinica;

  Parametros({
    this.origen,
    this.cvCirculoM,
    this.cvEspecialidad,
    this.bandera,
    this.nombre,
    this.buscador,
    this.cvPlanH,
    this.cvTipo,
    this.cvEstado,
    this.cvMunicipio,
    this.claveConvenio,
    this.claveGestion,
    this.razonSocial,
    this.rfc,
    this.nombreComercial,
    this.idHospital,
    this.codigoFiliacion,
    this.claveLineaComercial,
    this.claveNivelHospitalario,
    this.productoTecnico,
    this.productoComercial,
    this.filtros,
    this.pagina,
    this.dateTime,
    this.descEstado,
    this.descMunicipio,
    this.tipoClinica
  });

  Parametros.fromJson(Map<String, dynamic> json) {
    origen = json['origen'];
    cvCirculoM = json['cvCirculoM'];
    cvEspecialidad = json['cvEspecialidad'];
    bandera = json['bandera'];
    nombre = json['nombre'];
    buscador = json['buscador'];
    cvPlanH = json['cvPlanH'];
    cvTipo = json['cvTipo'];
    cvEstado = json["cvEstado"];
    cvMunicipio = json['cvMunicipio'];
    claveConvenio = json['claveConvenio'];
    claveGestion = json['claveGestion'];
    razonSocial = json['razonSocial'];
    rfc = json['rfc'];
    nombreComercial = json['nombreComercial'];
    idHospital = json['idHospital'];
    codigoFiliacion = json['codigoFiliacion'];
    claveLineaComercial = json['claveLineaComercial'];
    claveNivelHospitalario = json['claveNivelHospitalario'];
    productoTecnico = json['productoTecnico'];
    productoComercial = json['productoComercial'];
    filtros = json['filtros'];
    pagina = json['pagina'];
    descEstado = json['descEstado'];
    descMunicipio = json['descMunicipio'];
    tipoClinica = json['tipoClinica'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['origen'] = this.origen;
    data['cvCirculoM'] = this.cvCirculoM;
    data['cvEspecialidad'] = this.cvEspecialidad;
    data['bandera'] = this.bandera;
    data['nombre'] = this.nombre;
    data['buscador'] = this.buscador;
    data['cvPlanH'] = this.cvPlanH;
    data['cvTipo'] = this.cvTipo;
    data['cvEstado'] = this.cvEstado;
    data['cvMunicipio'] = this.cvMunicipio;
    data['claveConvenio'] = this.claveConvenio;
    data['claveGestion'] = this.claveGestion;
    data['razonSocial'] = this.razonSocial;
    data['rfc'] = this.rfc;
    data['nombreComercial'] = this.nombreComercial;
    data['idHospital'] = this.idHospital;
    data['codigoFiliacion'] = this.codigoFiliacion;
    data['claveLineaComercial'] = this.claveLineaComercial;
    data['claveNivelHospitalario'] = this.claveNivelHospitalario;
    data['productoTecnico'] = this.productoTecnico;
    data['productoComercial'] = this.productoComercial;
    data['filtros'] = this.filtros;
    data['pagina'] = this.pagina;
    data['descEstado'] = this.descEstado;
    data['descMunicipio'] = this.descMunicipio;
    data['tipoClinica'] = this.tipoClinica;
    return data;
  }
}
