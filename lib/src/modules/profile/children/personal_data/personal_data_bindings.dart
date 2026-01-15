part of 'personal_data_page.dart';

class _DatosPersonalesBindings extends Bindings {
  @override
  void dependencies() {
    if(!Get.isRegistered<DatosPersonalesController>()){
      Get.lazyPut<DatosPersonalesController>(
          DatosPersonalesController.new,
      );
    }
  }
}
