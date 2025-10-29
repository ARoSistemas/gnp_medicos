part of 'procedures_page.dart';

class _ProceduresBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProceduresController>(
        ProceduresController.new,
    );
  }
}
