import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';

part 'anexos_model.dart';

class AnexosController extends GetxController with StateMixin<_AnexosModel> {
  final AppStateController appState = Get.find<AppStateController>();
  UserModel get user => appState.user;

  @override
  void onInit() {
    super.onInit();
    const _AnexosModel anexosModel = _AnexosModel();
    change(anexosModel, status: RxStatus.success());
  }

  /* @override
  void onReady() {
    super.onReady();
  } */

  /*  @override
  void onClose() {
    super.onClose();
  } */
}
