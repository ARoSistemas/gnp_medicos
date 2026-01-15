part of 'request_documents_page.dart';

class _RequestDocumentsBindings extends Bindings {
  @override
  void dependencies() {
    Get..lazyPut<RequestDocumentsController>(
        RequestDocumentsController.new,
    )

    ..put(RequestDocumentsRepository());
  }
}
