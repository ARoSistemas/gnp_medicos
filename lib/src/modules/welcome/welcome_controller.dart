import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';
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
}
