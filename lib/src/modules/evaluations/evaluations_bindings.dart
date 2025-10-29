part of 'evaluations_page.dart';

class _EvaluationsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EvaluationsController>(
        EvaluationsController.new,
    );
  }
}
