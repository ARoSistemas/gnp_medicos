import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';

part 'beneficios_model.dart';

class BeneficiosController extends GetxController
    with StateMixin<_BeneficiosModel> {
  final AppStateController appState = Get.find<AppStateController>();
  UserModel get user => appState.user;

  @override
  void onInit() {
    super.onInit();
    const _BeneficiosModel beneficiosModel = _BeneficiosModel();
    change(beneficiosModel, status: RxStatus.success());
  }

  /*  @override
  void onReady() {
    super.onReady();
  } */

  /*  @override
  void onClose() {
    super.onClose();
  } */
}
