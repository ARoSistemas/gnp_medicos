
class SearchResultList{
  List<SearchResult>? lista = [];
  String? etiquetaDeBusqueda;
  SearchResultList({this.lista, this.etiquetaDeBusqueda});
}

class SearchResult {
  String? titulo;
  String? texto;
  String? complemnto;
  String? subEsp;
  String? extra;
  String? nivel;
  String? tipo;
  String? alertaTitulo;
  String? alertaMensaje;
  String? telefono;
  String? extension;
  String? latitud;
  String? longitud;
  bool? selected;
  int? registrosTotales;
  int? pagActual;
  int? pagTotales;
  String? alertaConsulta;

  List<String>? etiquetas;

  SearchResult({
    this.titulo,
    this.texto,
    this.complemnto,
    this.subEsp,
    this.extra,
    this.tipo,
    this.alertaTitulo,
    this.alertaMensaje,
    this.nivel,
    this.selected,
    this.telefono,
    this.extension,
    this.longitud,
    this.latitud,
    this.registrosTotales,
    this.pagActual,
    this.pagTotales,
    this.alertaConsulta,
    this.etiquetas,
  });

  SearchResult.fromJson(Map<String, dynamic> json) {
    titulo = json['titulo'];
    texto = json['texto'];
    complemnto = json['complemnto'];
    subEsp = json['subEsp'];
    extra = json['extra'];
    nivel = json['nivel'];
    telefono = json["telefono"];
    extension = json['extension'];
    selected = json['selected'];
    registrosTotales = json['registrosTotales'];
    pagActual = json['pagActual'];
    pagTotales = json['pagTotales'];
    alertaConsulta = json['alertaConsulta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titulo'] = this.titulo;
    data['texto'] = this.texto;
    data['complemnto'] = this.complemnto;
    data['subEsp'] = this.subEsp;
    data['extra'] = this.extra;
    data['nivel'] = this.nivel;
    data['telefono'] = this.telefono;
    data['selected'] = this.selected;
    data['registrosTotales'] = this.registrosTotales;
    data['pagActual'] = this.pagActual;
    data['pagTotales'] = this.pagTotales;
    data['alertaConsulta'] = this.alertaConsulta;
    return data;
  }
}