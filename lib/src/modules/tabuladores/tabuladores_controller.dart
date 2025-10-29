import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';

part 'tabuladores_model.dart';

class TabuladoresController extends GetxController
    with StateMixin<_TabuladoresModel> {
  final AppStateController appState = Get.find<AppStateController>();
  UserModel get user => appState.user;

  @override
  void onInit() {
    super.onInit();
    const _TabuladoresModel tabuladoresModel = _TabuladoresModel();
    change(tabuladoresModel, status: RxStatus.success());
  }

  /* @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  } */
}
