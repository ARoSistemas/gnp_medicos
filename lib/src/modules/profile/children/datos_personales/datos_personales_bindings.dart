part of 'datos_personales_page.dart';

class _DatosPersonalesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DatosPersonalesController>(
        DatosPersonalesController.new,
    );
  }
}
