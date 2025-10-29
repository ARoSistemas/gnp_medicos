// import 'dart:convert';

// RegisterUserModel registerUserModelFromJson(String str) =>
//     RegisterUserModel.fromJson(json.decode(str));

// String registerUserModelToJson(RegisterUserModel data) =>
//     json.encode(data.toJson());

// class RegisterUserModel {

//   RegisterUserModel({
//     required this.nombre,
//     required this.paterno,
//     required this.materno,
//     required this.telefono,
//     required this.rfc,
//     required this.mail,
//     required this.password,
//   });

//   factory RegisterUserModel.fromJson(Map<String, dynamic> json) =>
//       RegisterUserModel(
//         nombre: json['nombre'],
//         paterno: json['paterno'],
//         materno: json['materno'],
//         telefono: json['telefono'],
//         rfc: json['rfc'],
//         mail: json['mail'],
//         password: json['password'],
//       );
//   String nombre;
//   String paterno;
//   String materno;
//   String telefono;
//   String rfc;
//   String mail;
//   String password;

//   Map<String, dynamic> toJson() => {
//     'nombre': nombre,
//     'paterno': paterno,
//     'materno': materno,
//     'telefono': telefono,
//     'rfc': rfc,
//     'mail': mail,
//     'password': password,
//   };
// }
