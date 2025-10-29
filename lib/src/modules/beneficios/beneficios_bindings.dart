part of 'beneficios_page.dart';

class _BeneficiosBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BeneficiosController>(
        BeneficiosController.new,
    );
  }
}
