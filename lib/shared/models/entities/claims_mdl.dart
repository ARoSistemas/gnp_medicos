/// Claims Entitie Model
/// Represents the claims contained within the JWT payload.
/// Includes methods for JSON serialization and deserialization.
class Claims {
  Claims({
    required this.rol,
    required this.negociosOperables,
    required this.idParticipante,
    required this.mail,
    required this.apeMaterno,
    required this.givenName,
    required this.apePaterno,
    required this.cuentaBloqueda,
    required this.tipoUsuario,
    required this.cedula,
    required this.roles,
  });

  factory Claims.empty() => Claims(
    rol: '',
    negociosOperables: '',
    idParticipante: '',
    mail: '',
    apeMaterno: '',
    givenName: '',
    apePaterno: '',
    cuentaBloqueda: false,
    tipoUsuario: '',
    cedula: '',
    roles: [],
  );

  factory Claims.fromJson(Map<String, dynamic> json) => Claims(
    rol: json['rol'] ?? '',
    negociosOperables: json['negociosOperables'] ?? '',
    idParticipante: json['idparticipante'] ?? '',
    mail: json['mail'] ?? '',
    apeMaterno: json['apematerno'] ?? '',
    givenName: json['givenname'] ?? '',
    apePaterno: json['apepaterno'] ?? '',
    cuentaBloqueda: json['cuentabloqueda'] ?? false,
    tipoUsuario: json['tipousuario'] ?? '',
    cedula: json['cedula'] ?? '',
    roles: List<String>.from(json['roles'] ?? []),
  );

  Map<String, dynamic> toJson() => {
    'rol': rol,
    'negociosOperables': negociosOperables,
    'idParticipante': idParticipante,
    'mail': mail,
    'apeMaterno': apeMaterno,
    'givenName': givenName,
    'apePaterno': apePaterno,
    'cuentaBloqueda': cuentaBloqueda,
    'tipoUsuario': tipoUsuario,
    'cedula': cedula,
  };

  final String rol;
  final String negociosOperables;
  final String idParticipante;
  final String mail;
  final String apeMaterno;
  final String givenName;
  final String apePaterno;
  final bool cuentaBloqueda;
  final String tipoUsuario;
  final String cedula;
  final List<String> roles;
}
