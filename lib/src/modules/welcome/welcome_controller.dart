import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';
import 'package:medicos/src/modules/welcome/widgets/modal_informative.dart';
part 'welcome_model.dart';

class WelcomeController extends GetxController with StateMixin<_WelcomeModel> {
  final AppStateController appState = Get.find();
  String get jwt => appState.user.token.jwt;
  UserModel get user => appState.user;

  /// Breadcrumbs para la navegacion
  List<BreadcrumbWeb> breadcrumbsInicio = [
    BreadcrumbWeb('Inicio', route: WelcomePage.page.name),
  ];

  @override
  void onInit() {
    super.onInit();
    change(const _WelcomeModel(), status: RxStatus.success());
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
        builder: (context) => ModalInformative(
          message: msg.homeTerms.value,
          okMessage: msg.acceptAndContinue.value,
        ),
        isScrollControlled: true,
        isDismissible: false,
      );
    } else {
      await showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) =>  Dialog(
          child: ModalInformative(
            message: msg.homeTerms.value,
            okMessage: msg.acceptAndContinue.value,
          ),
        ),
      );
    }
  }
}
