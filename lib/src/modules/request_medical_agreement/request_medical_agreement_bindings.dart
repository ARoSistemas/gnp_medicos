part of 'request_medical_agreement_page.dart';

class _RequestMedicalAgreementBindings extends Bindings {
  @override
  void dependencies() {
    Get..lazyPut(RequestMedicalAgreementController.new)
    ..put(FormatsRepository());
  }
}
