part of 'academic_data_page.dart';

class _DatosAcademicosBindings extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<DatosAcademicosController>()) {
      Get.lazyPut<DatosAcademicosController>(DatosAcademicosController.new);
    }
  }
}
