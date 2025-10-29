part of 'datos_fiscales_page.dart';

class _DatosFiscalesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DatosFiscalesController>(
        DatosFiscalesController.new,
    );
  }
}
