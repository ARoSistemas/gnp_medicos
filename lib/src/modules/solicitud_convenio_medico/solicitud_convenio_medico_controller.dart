import 'package:get/get.dart';
import 'package:medicos/core/utils/logger.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/models/incoming/solicitudes_model.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/domain/repositories/solicitud_convenio_medico_repository.dart';

part 'solicitud_convenio_medico_model.dart';

class SolicitudConvenioMedicoController extends GetxController
    with StateMixin<_SolicitudConvenioMedicoModel> {
  final SolicitudConvenioMedicoRepository _requestAgreementRepository = Get.put(
    SolicitudConvenioMedicoRepository(),
  );
  final AppStateController appState = Get.find<AppStateController>();
  UserModel get user => appState.user;

  final RxBool isLoading = false.obs;
  List<SolicitudModel> requestsAgreement = [];
  @override
  Future<void> onInit() async {
    super.onInit();
    const _SolicitudConvenioMedicoModel nuevaSolicitudModel =
        _SolicitudConvenioMedicoModel();
    change(nuevaSolicitudModel, status: RxStatus.success());
    await getRequestsAgreement();
  }

  /* 
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  } */

  Future<void> getRequestsAgreement() async {
    try {
      isLoading.value = true;
      requestsAgreement = await _requestAgreementRepository
          .getRequestsAgreement(
            appState.user.uid,
            appState.user.token.jwt,
          );
      isLoading.value = false;
    } on Exception catch (e) {
      logger.d(e);
    }
  }
}
