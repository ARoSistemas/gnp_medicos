part of 'item_map_page.dart';

class _ItemMapBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<ItemMapController>(ItemMapController.new)
      ..put<ItemMapRepository>(ItemMapRepository());
  }
}
