part of 'fiscal_data_page.dart';

class _DatosFiscalesBindings extends Bindings {
  @override
  void dependencies() {
    if(!Get.isRegistered<DatosFiscalesController>()){
      Get.lazyPut<DatosFiscalesController>(
          DatosFiscalesController.new,
      );
    }
  }
}
