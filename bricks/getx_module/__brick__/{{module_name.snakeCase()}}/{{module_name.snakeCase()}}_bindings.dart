part of '{{module_name.snakeCase()}}_page.dart';

class _{{module_name.pascalCase()}}Bindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<{{module_name.pascalCase()}}Controller>(
        {{module_name.pascalCase()}}Controller.new,
    );
  }
}
