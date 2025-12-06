import 'package:get/get.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';

part 'procedures_model.dart';

class ProceduresController extends GetxController
    with StateMixin<_ProceduresModel> {
  List<BreadcrumbWeb> breadcrumbs = [
    BreadcrumbWeb('Inicio', route: WelcomePage.page.name),
    const BreadcrumbWeb('Mis Trámites'),
  ];
  @override
  void onInit() {
    super.onInit();
    change(const _ProceduresModel(), status: RxStatus.success());
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
