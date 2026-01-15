part of 'directory_page.dart';

class _DirectoryBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<DirectoryRepository>(DirectoryRepository())
      ..put<DirectoryController>(DirectoryController());
  }
}
