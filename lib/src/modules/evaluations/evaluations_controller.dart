import 'package:get/get.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';

part 'evaluations_model.dart';

class EvaluationsController extends GetxController
    with StateMixin<_EvaluationsModel> {
  List<BreadcrumbWeb> breadcrumbs = [
    BreadcrumbWeb('Inicio', route: WelcomePage.page.name),
    const BreadcrumbWeb('Evaluaciones'),
  ];

  @override
  void onInit() {
    super.onInit();
    change(const _EvaluationsModel(), status: RxStatus.success());
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
