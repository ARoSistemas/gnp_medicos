class CirculoMedico {
  CirculoMedico.fromJson();
}

class Especialidad {
  Especialidad({this.especialidad});

  factory Especialidad.fromJson(Map<String, dynamic> json) => Especialidad(
    especialidad: json['especialidad'],
  );
  final String? especialidad;
}

class TipoClinica {
  TipoClinica(this.tipoProveedor);

  factory TipoClinica.fromJson(Map<String, dynamic> json) =>
      TipoClinica.fromJson(
        json['tipoProveedor'],
      );
  final String tipoProveedor;
}

class TipoServicios {
  TipoServicios(this.tipoProveedor);

  factory TipoServicios.fromJson(Map<String, dynamic> json) =>
      TipoServicios.fromJson(
        json['tipoProveedor'],
      );
  final String tipoProveedor;
}

class Estados {
  Estados(this.claveEstado);

  factory Estados.fromJson(Map<String, dynamic> json) => Estados(
    json['claveEstado'],
  );

  final String claveEstado;
}

class Municipios {
  Municipios(this.municipio);

  factory Municipios.fromJson(Map<String, dynamic> json) => Municipios(
    json['municipios'],
  );
  final String municipio;
}

class Planes {
  Planes(this.plan);

  factory Planes.fromJson(Map<String, dynamic> json) => Planes(
    json['plan'],
  );
  final String plan;
}

class SubEspecialidad {
  SubEspecialidad(this.subEspecialidad);

  factory SubEspecialidad.fromJson(Map<String, dynamic> json) =>
      SubEspecialidad(
        json['subEspecialidad'],
      );
  final String subEspecialidad;
}
