import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<AppStateController>(AppStateController(), permanent: true);
  }
}
