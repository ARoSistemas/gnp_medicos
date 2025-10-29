class TiposAsistentesModel {
  TiposAsistentesModel({
    required this.idTipoAsistente,
    required this.nombre,
  });
  factory TiposAsistentesModel.fromMap(Map<String, dynamic> json) =>
      TiposAsistentesModel(
        idTipoAsistente: json['idTipoAsistente'] ?? '',
        nombre: json['nombre'] ?? '',
      );

  // String tiposAsistentesModelToJson(List<TiposAsistentesModel> data) =>
  //     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  Map<String, dynamic> toJson() => {
    'idTipoAsistente': idTipoAsistente,
    'nombre': nombre,
  };

  String idTipoAsistente;
  String nombre;
}
