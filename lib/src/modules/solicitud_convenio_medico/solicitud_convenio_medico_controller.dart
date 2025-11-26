import 'package:get/get.dart';
import 'package:medicos/core/services/threads/threads_service.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/models/incoming/solicitudes_model.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/children/nueva_solicitud/domain/repositories/solicitud_convenio_medico_repository.dart';

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
  final ThreadsService threadsService = Get.find();

  @override
  Future<void> onInit() async {
    super.onInit();
    const _SolicitudConvenioMedicoModel nuevaSolicitudModel =
        _SolicitudConvenioMedicoModel();
    change(nuevaSolicitudModel, status: RxStatus.success());
    await getRequestsAgreement();
  }

  Future<void> getRequestsAgreement() async {
    await threadsService.execute(
      func: () async {
        isLoading.value = true;
        requestsAgreement = await _requestAgreementRepository
            .getRequestsAgreement(
              user.uid,
              user.token.jwt,
            );
        isLoading.value = false;
      },
      onError: () {
        isLoading.value = false;
      }
    );
  }
}
