import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/widgets/layout/menu_web/menu_web.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';
import 'package:medicos/src/modules/welcome/widgets/modal_acept_terms.dart';

part 'welcome_model.dart';

class WelcomeController extends GetxController with StateMixin<_WelcomeModel> {
  final AppStateController appState = Get.find();

  /// JWT token del usuario autenticado
  String get jwt => appState.user.token.jwt;
  UserModel get user => appState.user;

  /// Breadcrumbs para la navegacion
  List<MenuWebBreadcrumb> breadcrumbsInicio = [
    MenuWebBreadcrumb('Inicio', route: WelcomePage.page.name),
  ];

  @override
  void onInit() {
    super.onInit();
    appState.userPermissions = {
      '/convenio-medico': true,
      '/tabuladores': true,
      '/mis-pagos': true,
      '/solicitar-convenio': true,
      '/mis-tramites': true,
      '/beneficios': true,
      '/anexos': true,
      '/formatos': true,
      '/evaluaciones': true,
      '/directorio-medico': true,
    };
    appState.buildMenuWeb('Inicio', []);

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
        builder: (context) => const ModalAceptTerms(),
        isScrollControlled: true,
        isDismissible: false,
      );
    }
  }
}
