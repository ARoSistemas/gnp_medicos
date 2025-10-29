import 'dart:async';

import 'package:get_storage/get_storage.dart' hide Data;

import 'package:medicos/core/services/security/cipher_service.dart';
import 'package:medicos/core/services/storage/storage_property.dart';

abstract class IStorage {
  abstract final String boxName;
  abstract final GetStorage box;
  abstract final Set<StorageProperty> properties;

  Future<void> loadAll() async {
    await init();
    properties.forEach(load);
  }

  void saveAll() => properties.forEach(save);

  Future<bool> init() => GetStorage.init(boxName);

  void save(StorageProperty p, [dynamic newValue]) {
    if (newValue != null) {
      p.value = newValue;
    }
    final dynamic v = p.value;
    if (v is Enum) {
      unawaited(box.write(p.key, v.index));
    } else {
      final dynamic value = p.encrypt
          ? cipherService.encrypt(p.value)
          : p.value;
      unawaited(box.write(p.key, value));
    }
  }

  void load(StorageProperty p) {
    final dynamic loadedValue = box.read(p.key);
    if (loadedValue != null) {
      final dynamic val = p.value;
      if (val is Enum) {
        p.value = p.enumLoad?.call(loadedValue) ?? p.defaultValue;
      } else {
        p.value = p.encrypt ? cipherService.decrypt(loadedValue) : loadedValue;
      }
    } else {
      p.value = p.defaultValue;
    }
  }

  void resetValues() {
    for (final StorageProperty p in properties) {
      p.value = p.defaultValue;
      save(p);
    }
  }
}
