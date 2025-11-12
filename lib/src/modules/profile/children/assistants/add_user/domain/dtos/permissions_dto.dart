import 'dart:convert';

class PermissionsDto {
  PermissionsDto({
    required this.id,
    required this.descripcion,
    required this.activo,
    required this.submodulos,
    required this.orden,
  });

  factory PermissionsDto.empty() => PermissionsDto(
    id: '',
    descripcion: '',
    activo: false,
    submodulos: [],
    orden: 100,
  );

  factory PermissionsDto.fromMap(Map<String, dynamic> json) => PermissionsDto(
    id: json['id'],
    descripcion: json['descripcion'],
    activo: json['activo'],
    orden: json['orden'] ?? 100,
    submodulos: List<PermissionsDto>.from(
      ((json['submodulos'] ?? []) as List<dynamic>).map(
        (x) => PermissionsDto.fromMap(x),
      ),
    ),
  );

  List<PermissionsDto> fromRaw(String raw) => List<PermissionsDto>.from(
    (jsonDecode(raw) as List<dynamic>).map(
      (x) => PermissionsDto.fromMap(x as Map<String, dynamic>),
    ),
  );

  String permissionsDtoToJson(List<PermissionsDto> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  Map<String, dynamic> toJson() => {
    'id': id,
    'descripcion': descripcion,
    'activo': activo,
    'submodulos': List<dynamic>.from(submodulos.map((x) => x.toJson())),
    'orden': orden,
  };

  String id;
  String descripcion;
  bool activo;
  List<PermissionsDto> submodulos;
  int orden;

  PermissionsDto copyWith({
    String? id,
    String? descripcion,
    bool? activo,
    List<PermissionsDto>? submodulos,
    int? orden,
  }) => PermissionsDto(
    id: id ?? this.id,
    descripcion: descripcion ?? this.descripcion,
    activo: activo ?? this.activo,
    submodulos: submodulos ?? this.submodulos,
    orden: orden ?? this.orden,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'descripcion': descripcion,
    'activo': activo,
    'submodulos': List<dynamic>.from(submodulos.map((x) => x.toMap())),
    'orden': orden,
  };

  //   final String rHardCode = '''
  //   [
  //     {
  //         "id": "/mis-tramites",
  //         "descripcion": "Mis trámites",
  //         "activo": false
  //     },
  //     {
  //         "id": "/beneficios",
  //         "descripcion": "Beneficios",
  //         "activo": false
  //     },
  //     {
  //         "id": "/solicitar-convenio",
  //         "descripcion": "Solicitar convenio",
  //         "activo": false
  //     },
  //     {
  //         "id": "/convenio-medico",
  //         "descripcion": "Convenio Médico",
  //         "activo": false
  //     },
  //     {
  //         "id": "/directorio-medico",
  //         "descripcion": "Directorio médico",
  //         "activo": false
  //     },
  //     {
  //         "id": "/formatos",
  //         "descripcion": "Formatos",
  //         "activo": false
  //     },
  //     {
  //         "id": "/mi-perfil",
  //         "descripcion": "Mi Perfil",
  //         "activo": false,
  //         "submodulos": [
  //             {
  //                 "id": "/datos-fiscales",
  //                 "descripcion": "Datos fiscales",
  //                 "activo": false
  //             },
  //             {
  //                 "id": "/datos-academicos",
  //                 "descripcion": "Datos académicos",
  //                 "activo": false
  //             },
  //             {
  //                 "id": "/datos-personales",
  //                 "descripcion": "Datos personales",
  //                 "activo": false
  //             }
  //         ]
  //     },
  //     {
  //         "id": "/anexos",
  //         "descripcion": "Anexos",
  //         "activo": false
  //     },
  //     {
  //         "id": "/tabuladores",
  //         "descripcion": "Tabuladores",
  //         "activo": false
  //     },
  //     {
  //         "id": "/mis-pagos",
  //         "descripcion": "Mis pagos",
  //         "activo": false
  //     }
  // ]
  // oyi-prhx-cwz

  //   ''';
}
