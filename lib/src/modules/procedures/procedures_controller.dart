import 'package:get/get.dart';

part 'procedures_model.dart';

class ProceduresController extends GetxController
  with StateMixin<_ProceduresModel> {
  @override
  void onInit() {
    super.onInit();
    const _ProceduresModel proceduresModel = _ProceduresModel();
    change(proceduresModel, status: RxStatus.success());
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
