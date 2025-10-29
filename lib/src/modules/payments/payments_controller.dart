import 'package:get/get.dart';

part 'payments_model.dart';

class PaymentsController extends GetxController
  with StateMixin<_PaymentsModel> {
  @override
  void onInit() {
    super.onInit();
    const _PaymentsModel paymentsModel = _PaymentsModel();
    change(paymentsModel, status: RxStatus.success());
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
