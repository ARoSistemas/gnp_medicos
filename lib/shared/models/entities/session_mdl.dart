import 'dart:convert';
import 'package:medicos/shared/models/entities/user_mdl.dart';

/// User Entitie Model
/// Represents the user details returned from the login API.
/// Includes methods for JSON serialization and deserialization.
class SessionModel {
  SessionModel({
    required this.logged,
    required this.selected,
    required this.permissions,
  });

  factory SessionModel.fromRaw(String raw) => 
  SessionModel.fromMap(jsonDecode(raw));

  factory SessionModel.fromMap(Map<String, dynamic> json) => SessionModel(
    logged: json['logged'] != null ? 
    UserModel.fromMap(json['logged']) : UserModel.empty(),
    selected: json['selected'] != null ?
    UserModel.fromMap(json['selected']) : UserModel.empty(),
    permissions:  json['permissions'] ?? <String, dynamic>{}
  );

  factory SessionModel.empty() => SessionModel(
    logged: UserModel.empty(),
    selected: UserModel.empty(),
    permissions: <String, dynamic>{}
  );

  final UserModel logged;
  final UserModel selected;
  final Map<String, dynamic> permissions;

  SessionModel copyWith({
    UserModel? logged,
    UserModel? selected,
     Map<String, dynamic>? permissions,
  }) => SessionModel(
    logged: logged ?? this.logged,
    selected: selected ?? this.selected,
    permissions: permissions ?? this.permissions
  );

  Map<String, dynamic> toJson() => {
    'logged': logged.toJson(),
    'selected': selected.toJson(),
    'permissions': permissions
  };
}
