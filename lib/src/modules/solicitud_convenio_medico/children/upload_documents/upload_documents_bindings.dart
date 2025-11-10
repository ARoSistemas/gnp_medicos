part of 'upload_documents_page.dart';

class _UploadDocumentsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadDocumentsController>(
        UploadDocumentsController.new,
    );
  }
}
