import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:medicos/core/services/storage/istorage.dart';
import 'package:medicos/core/services/storage/storage_property.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';

class UserStorage extends IStorage {
  @override
  final String boxName = 'userBox';

  @override
  final GetStorage box = GetStorage('userBox');

  @override
  final Set<StorageProperty> properties = {
    StorageProperty<String>(
      key: 'user',
      defaultValue: '',
      value: '',
      encrypt: true
    ),
  };

  StorageProperty<String> get user =>
    properties.firstWhere((p) => p.key == 'user') as StorageProperty<String>;

  void saveUser(UserModel userMdl) {
    save(user, jsonEncode(userMdl.toJsonStored()));
  }

  UserModel? getUser() {
    final String value = user.value;
    if (user.value.isEmpty) {
      return null;
    }
    return UserModel.fromMap(json.decode(value));
  }

  Future<void> cleanUser() async {
    user.value = user.defaultValue;
    await box.remove(user.key);
  }
}
