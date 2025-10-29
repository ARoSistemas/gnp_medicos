import 'package:get/get.dart';

import 'package:medicos/src/modules/directorio/directorio_controller.dart';

class DirectorioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DirectorioController>(DirectorioController.new);
  }
}
