import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/src/modules/welcome/widgets/modal_acept_terms.dart';
part 'welcome_model.dart';

class WelcomeController extends GetxController with StateMixin<_WelcomeModel> {
  final AppStateController appState = Get.find();
  String get jwt => appState.user.token.jwt;
  UserModel get user => appState.user;

  @override
  void onInit() {
    super.onInit();
    const _WelcomeModel welcomeModel = _WelcomeModel();
    change(welcomeModel, status: RxStatus.success());
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await _showBottomSheet();
  }

  Future<void> _showBottomSheet() async {
    if (!kIsWeb) {
      await showModalBottomSheet(
        context: Get.context!,
        builder: (context) => const ModalAceptTerms(),
        isScrollControlled: true,
        isDismissible: false,
      );
    }
  }
}
