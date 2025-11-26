class AsisstantDto {
  AsisstantDto({
    required this.codigoFiliacion,
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.rfc,
    required this.especialidad,
    required this.estado,
    required this.circulo,
    required this.tabulador,
    required this.estatus,
    required this.fechaInicio,
    required this.fechaFin,
    required this.banVerConvenio,
    required this.banDescargaConvenio,
    required this.banVerAviso,
    required this.banConvenioActualizado,
    required this.email,
    required this.uid,
  });

  factory AsisstantDto.fromMap(Map<String, dynamic> json) => AsisstantDto(
    codigoFiliacion: json['codigoFiliacion'] ?? '',
    nombre: json['nombre'] ?? '',
    apellidoPaterno: json['apellidoPaterno'] ?? '',
    apellidoMaterno: json['apellidoMaterno'] ?? '',
    rfc: json['rfc'] ?? '',
    especialidad: json['especialidad'] ?? '',
    estado: json['estado'] ?? '',
    circulo: json['circulo'] ?? '',
    tabulador: json['tabulador'] ?? '',
    estatus: json['estatus'] ?? '',
    fechaInicio: json['fechaInicio'] ?? '',
    fechaFin: json['fechaFin'] ?? '',
    banVerConvenio: json['banVerConvenio'] ?? false,
    banDescargaConvenio: json['banDescargaConvenio'] ?? false,
    banVerAviso: json['banVerAviso'] ?? false,
    banConvenioActualizado: json['banConvenioActualizado'] ?? false,
    email: json['email'] ?? '',
    uid: json['uid'] ?? '',
  );

  factory AsisstantDto.empty() => AsisstantDto(
    codigoFiliacion: '',
    nombre: '',
    apellidoPaterno: '',
    apellidoMaterno: '',
    rfc: '',
    especialidad: '',
    estado: '',
    circulo: '',
    tabulador: '',
    estatus: '',
    fechaInicio: '',
    fechaFin: '',
    banVerConvenio: false,
    banDescargaConvenio: false,
    banVerAviso: false,
    banConvenioActualizado: false,
    email: '',
    uid: '',
  );

  AsisstantDto copyWith({
    String? codigoFiliacion,
    String? nombre,
    String? apellidoPaterno,
    String? apellidoMaterno,
    String? rfc,
    String? especialidad,
    String? estado,
    String? circulo,
    String? tabulador,
    String? estatus,
    String? fechaInicio,
    String? fechaFin,
    bool? banVerConvenio,
    bool? banDescargaConvenio,
    bool? banVerAviso,
    bool? banConvenioActualizado,
    String? email,
    String? uid,
  }) => AsisstantDto(
    codigoFiliacion: codigoFiliacion ?? this.codigoFiliacion,
    nombre: nombre ?? this.nombre,
    apellidoPaterno: apellidoPaterno ?? this.apellidoPaterno,
    apellidoMaterno: apellidoMaterno ?? this.apellidoMaterno,
    rfc: rfc ?? this.rfc,
    especialidad: especialidad ?? this.especialidad,
    estado: estado ?? this.estado,
    circulo: circulo ?? this.circulo,
    tabulador: tabulador ?? this.tabulador,
    estatus: estatus ?? this.estatus,
    fechaInicio: fechaInicio ?? this.fechaInicio,
    fechaFin: fechaFin ?? this.fechaFin,
    banVerConvenio: banVerConvenio ?? this.banVerConvenio,
    banDescargaConvenio: banDescargaConvenio ?? this.banDescargaConvenio,
    banVerAviso: banVerAviso ?? this.banVerAviso,
    banConvenioActualizado:
        banConvenioActualizado ?? this.banConvenioActualizado,
    email: email ?? this.email,
    uid: uid ?? this.uid
  );

  Map<String, dynamic> toMap() => {
    'codigoFiliacion': codigoFiliacion,
    'nombre': nombre,
    'apellidoPaterno': apellidoPaterno,
    'apellidoMaterno': apellidoMaterno,
    'rfc': rfc,
    'especialidad': especialidad,
    'estado': estado,
    'circulo': circulo,
    'tabulador': tabulador,
    'estatus': estatus,
    'fechaInicio': fechaInicio,
    'fechaFin': fechaFin,
    'banVerConvenio': banVerConvenio,
    'banDescargaConvenio': banDescargaConvenio,
    'banVerAviso': banVerAviso,
    'banConvenioActualizado': banConvenioActualizado,
    'email': email,
    'uid': uid,
  };

  String codigoFiliacion;
  String nombre;
  String apellidoPaterno;
  String apellidoMaterno;
  String rfc;
  String especialidad;
  String estado;
  String circulo;
  String tabulador;
  String estatus;
  String fechaInicio;
  String fechaFin;
  bool banVerConvenio;
  bool banDescargaConvenio;
  bool banVerAviso;
  bool banConvenioActualizado;
  String email;
  String uid;

  static String rResponseOk = '''
[
  {
    "codigoFiliacion":"0000799393",
    "nombre":"JUAN JACOBO",
    "apellidoPaterno":"INUKI",
    "apellidoMaterno":"MELOPI",
    "rfc":"AAGJ500515KP8",
    "especialidad":"INFECTOLOGIA",
    "estado":"CIUDAD DE MEXICO",
    "circulo":"OMNIA",
    "tabulador":"",
    "estatus":"VI",
    "fechaInicio":"2025-08-01",
    "fechaFin":"2025-08-31",
    "banVerConvenio":true,
    "banDescargaConvenio":true,
    "banVerAviso":false,
    "banConvenioActualizado":false
  }
]
  ''';
}
