part of 'payments_page.dart';

class _PaymentsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentsController>(
        PaymentsController.new,
    );
  }
}
