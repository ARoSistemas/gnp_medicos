part of 'directorio_page.dart';

class _DirectorioBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DirectorioController>(
        DirectorioController.new,
    );
  }
}
