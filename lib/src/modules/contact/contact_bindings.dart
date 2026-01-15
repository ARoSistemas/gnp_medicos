part of 'contact_page.dart';

class _ContactBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<ContactController>(ContactController());
  }
}
