import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';

part 'tabuladores_model.dart';

class TabuladoresController extends GetxController
    with StateMixin<_TabuladoresModel> {
  final AppStateController appState = Get.find<AppStateController>();
  UserModel get user => appState.user;

  List<BreadcrumbWeb> breadcrumbs = [
    BreadcrumbWeb('Inicio', route: WelcomePage.page.name),
    const BreadcrumbWeb('Tabuladores'),
  ];

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
