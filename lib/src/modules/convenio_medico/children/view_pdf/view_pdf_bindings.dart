part of 'view_pdf_page.dart';

class _ViewPdfBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewPdfController>(
        ViewPdfController.new,
    );
  }
}
