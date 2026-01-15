import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:medicos/core/services/storage/istorage.dart';
import 'package:medicos/core/services/storage/storage_property.dart';
import 'package:medicos/shared/models/entities/session_mdl.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';

class UserStorage extends IStorage {
  @override
  final String boxName = 'medicos';

  @override
  final GetStorage box = GetStorage('medicos');

  @override
  final Set<StorageProperty> properties = {
    StorageProperty<String>(
      key: 'user',
      defaultValue: '',
      value: '',
      encrypt: true
    ),
    StorageProperty<String>(
      key: 'session',
      defaultValue: '',
      value: '',
      encrypt: true
    ),
    StorageProperty<String>(
      key: 'email',
      defaultValue: '',
      value: '',
      encrypt: true
    ),
  };

  StorageProperty<String> get user =>
    properties.firstWhere((p) => p.key == 'user') as StorageProperty<String>;

  StorageProperty<String> get sessionWeb =>
    properties.firstWhere((p) => p.key == 'session') as StorageProperty<String>;

  StorageProperty<String> get email =>
    properties.firstWhere((p) => p.key == 'email') as StorageProperty<String>;


  void saveUser(UserModel userMdl) {
    save(user, jsonEncode(userMdl.toJsonStored()));
  }

  void saveSessionWeb(SessionModel session) {
    save(sessionWeb, jsonEncode(session.toJson()));
  }

  void saveEmail(String mail) {
    save(email, mail);
  }

  UserModel? getUser() {
    final String value = user.value;
    if (value.isEmpty) {
      return null;
    }
    return UserModel.fromMap(json.decode(value));
  }

  SessionModel? getSessionWeb() {
    final String value = sessionWeb.value;
    if (value.isEmpty) {
      return null;
    }
    return SessionModel.fromMap(json.decode(value));
  }

  String? getEmail() {
    final String value = email.value;
    if (value.isEmpty) {
      return null;
    }
    return value;
  }

  Future<void> cleanUser() async {
    user.value = user.defaultValue;
    await box.remove(user.key);
  }

  Future<void> cleanSessionWeb() async {
    sessionWeb.value = sessionWeb.defaultValue;
    await box.remove(sessionWeb.key);
  }

  Future<void> cleanEmail() async {
    email.value = email.defaultValue;
    await box.remove(email.key);
  }
}
