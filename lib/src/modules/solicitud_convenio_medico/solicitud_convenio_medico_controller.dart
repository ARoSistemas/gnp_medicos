import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/null_extensions.dart';
import 'package:medicos/core/services/threads/threads_service.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/models/incoming/solicitudes_model.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/children/nueva_solicitud/domain/repositories/solicitud_convenio_medico_repository.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/children/nueva_solicitud/nueva_solicitud_page.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';
import 'package:medicos/src/modules/welcome/widgets/modal_informative.dart';

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

  List<BreadcrumbWeb> breadcrumbs = [
    BreadcrumbWeb('Inicio', route: WelcomePage.page.name),
    const BreadcrumbWeb('Solicitar Convenio Médico'),
  ];

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
      },
    );
  }

  Future<void> goToNewRequest() async {
    final bool result = await Get.toNamed(NuevaSolicitudPage.page.name);

    if (result) {
      change(null, status: RxStatus.loading());
      requestsAgreement = [];
      await getRequestsAgreement();
      update();
    }
  }

  Future<void> getComment(String idRequest) async {
    await threadsService.execute(
      func: () async {
        isLoading.value = true;
        final Response<String> comments = await _requestAgreementRepository
            .getCommentsRequest(idRequest, user.token.jwt);
        isLoading.value = false;
        if (!kIsWeb) {
          await showModalBottomSheet(
            context: Get.context!,
            builder: (context) => ModalInformative(
              message: comments.body.value(),
              okMessage: msg.accept.value,
            ),
            isScrollControlled: true,
            isDismissible: false,
          );
        }
      },
      onError: () {
        isLoading.value = false;
      },
    );
  }
}
