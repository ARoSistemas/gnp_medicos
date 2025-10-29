part of '../app_service.dart';

class StorageService extends GetxService {
  Future<void> init() async {
    await GetStorage.init();
  }
}
