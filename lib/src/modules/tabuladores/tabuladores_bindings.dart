part of 'tabuladores_page.dart';

class _TabuladoresBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabuladoresController>(
        TabuladoresController.new,
    );
  }
}
