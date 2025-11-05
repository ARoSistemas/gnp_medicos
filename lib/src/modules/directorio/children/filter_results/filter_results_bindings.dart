part of 'filter_results_page.dart';

class _FilterResultsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilterResultsController>(FilterResultsController.new);
  }
}
