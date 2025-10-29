
import 'package:get/get.dart';

import 'directorio_controller.dart';

class DirectorioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DirectorioController>(() => DirectorioController());
  }
}
