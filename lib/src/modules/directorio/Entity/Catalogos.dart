class CirculoMedico {
  CirculoMedico.fromJson(Map<String, dynamic> json);
}

class Especialidad {
  Especialidad.fromJson(Map<String, dynamic> json);
}

class TipoClinica {
  TipoClinica.fromJson(Map<String, dynamic> json);
}

class TipoServicios {
  TipoServicios.fromJson(Map<String, dynamic> json);
}

class Estados {
  String? claveEstado;
  Estados.fromJson(Map<String, dynamic> json) {
    claveEstado = json['claveEstado'];
  }
}

class Municipios {
  Municipios.fromJson(Map<String, dynamic> json);
}

class Planes {
  Planes.fromJson(Map<String, dynamic> json);
}

class SubEspecialidad {
  SubEspecialidad.fromJson(Map<String, dynamic> json);
}