import 'dart:convert';

class AssistantDto {
  AssistantDto({
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.fechaNacimiento,
    required this.cveLada,
    required this.telefono,
    required this.activo,
    required this.email,
    required this.idAsistente,
    required this.idTipoAsistente,
    required this.nombreTipoAsistente,
  });

  factory AssistantDto.empty() => AssistantDto(
    nombre: '',
    apellidoPaterno: '',
    apellidoMaterno: '',
    fechaNacimiento: '',
    cveLada: '',
    telefono: '',
    activo: false,
    email: '',
    idAsistente: '',
    idTipoAsistente: '',
    nombreTipoAsistente: '',
  );

  factory AssistantDto.fromRaw(String raw) =>
      AssistantDto.fromMap(jsonDecode(raw));

  factory AssistantDto.fromMap(Map<String, dynamic> json) => AssistantDto(
    idAsistente: json['idAsistente'] ?? '',
    nombre: json['nombre'] ?? '',
    apellidoPaterno: json['apellidoPaterno'] ?? '',
    apellidoMaterno: json['apellidoMaterno'] ?? '',
    fechaNacimiento: json['fechaNacimiento'] ?? '',
    cveLada: json['cveLada'] ?? '',
    telefono: json['telefono'] ?? '',
    email: json['email'] ?? '',
    activo: json['activo'] ?? false,
    idTipoAsistente: json['idTipoAsistente'] ?? '',
    nombreTipoAsistente: json['nombreTipoAsistente'] ?? '',
  );

  AssistantDto copyWith({
    String? idAsistente,
    String? nombre,
    String? apellidoPaterno,
    String? apellidoMaterno,
    String? fechaNacimiento,
    String? cveLada,
    String? telefono,
    String? email,
    bool? activo,
    String? idTipoAsistente,
    String? nombreTipoAsistente,
  }) => AssistantDto(
    idAsistente: idAsistente ?? this.idAsistente,
    nombre: nombre ?? this.nombre,
    apellidoPaterno: apellidoPaterno ?? this.apellidoPaterno,
    apellidoMaterno: apellidoMaterno ?? this.apellidoMaterno,
    fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
    cveLada: cveLada ?? this.cveLada,
    telefono: telefono ?? this.telefono,
    email: email ?? this.email,
    activo: activo ?? this.activo,
    idTipoAsistente: idTipoAsistente ?? this.idTipoAsistente,
    nombreTipoAsistente: nombreTipoAsistente ?? this.nombreTipoAsistente,
  );

  Map<String, dynamic> toMap() => {
    'idAsistente': idAsistente,
    'nombre': nombre,
    'apellidoPaterno': apellidoPaterno,
    'apellidoMaterno': apellidoMaterno,
    'fechaNacimiento': fechaNacimiento,
    'cveLada': cveLada,
    'telefono': telefono,
    'email': email,
    'activo': activo,
  };

  String idAsistente;
  String nombre;
  String apellidoPaterno;
  String apellidoMaterno;
  String fechaNacimiento;
  String cveLada;
  String telefono;
  String email;
  String idTipoAsistente;
  String nombreTipoAsistente;
  bool activo;
}
