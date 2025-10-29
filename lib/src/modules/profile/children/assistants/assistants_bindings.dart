part of 'assistants_page.dart';

class _AssistantsBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(AssistantsController.new)
      ..put(AssistantsRepository())
      ..put(AddAssistantsRepository());
  }
}
