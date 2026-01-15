part of 'change_password_page.dart';

class _ChangePasswordBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordController>(
        ChangePasswordController.new,
    );
  }
}
