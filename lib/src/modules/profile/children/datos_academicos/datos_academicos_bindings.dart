part of 'datos_academicos_page.dart';

class _DatosAcademicosBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DatosAcademicosController>(
        DatosAcademicosController.new,
    );
  }
}
