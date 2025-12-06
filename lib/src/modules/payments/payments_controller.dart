import 'package:get/get.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';

part 'payments_model.dart';

class PaymentsController extends GetxController
    with StateMixin<_PaymentsModel> {
  List<BreadcrumbWeb> breadcrumbs = [
    BreadcrumbWeb('Inicio', route: WelcomePage.page.name),
    const BreadcrumbWeb('Mis Pagos'),
  ];

  // @override
  // void onInit() {
  //   super.onInit();
  //   const _PaymentsModel state = _PaymentsModel();
  //   change(state, status: RxStatus.success());
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
