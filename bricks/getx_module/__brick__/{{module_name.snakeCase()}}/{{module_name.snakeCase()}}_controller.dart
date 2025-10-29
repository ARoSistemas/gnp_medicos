import 'package:get/get.dart';

part '{{module_name.snakeCase()}}_model.dart';

class {{module_name.pascalCase()}}Controller extends GetxController
  with StateMixin<_{{module_name.pascalCase()}}Model> {
  @override
  void onInit() {
    super.onInit();
    const _{{module_name.pascalCase()}}Model {{module_name.camelCase()}}Model = _{{module_name.pascalCase()}}Model();
    change({{module_name.camelCase()}}Model, status: RxStatus.success());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
