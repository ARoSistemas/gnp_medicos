part of 'new_request_page.dart';

class _NewRequestBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewRequestController>(
        NewRequestController.new,
    );
  }
}
