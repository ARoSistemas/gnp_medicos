import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';

part 'formats_model.dart';

class FormatsController extends GetxController with StateMixin<_FormatsModel> {
  final AppStateController appState = Get.find<AppStateController>();
  UserModel get user => appState.user;

  @override
  void onInit() {
    super.onInit();
    const _FormatsModel formatsModel = _FormatsModel();
    change(formatsModel, status: RxStatus.success());
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
