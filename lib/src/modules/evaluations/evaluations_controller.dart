import 'package:get/get.dart';

part 'evaluations_model.dart';

class EvaluationsController extends GetxController
  with StateMixin<_EvaluationsModel> {
  @override
  void onInit() {
    super.onInit();
    const _EvaluationsModel evaluationsModel = _EvaluationsModel();
    change(evaluationsModel, status: RxStatus.success());
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
