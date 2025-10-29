part of 'contacto_page.dart';

class _ContactoBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactoController>(
      ContactoController.new,
    );
  }
}
