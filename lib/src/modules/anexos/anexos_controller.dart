import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/utils/exception_manager.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/widgets/custom_notification.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/anexos/domain/dtos/anneses_dto.dart';
import 'package:medicos/src/modules/anexos/domain/repository/annexes_repository.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';

part 'anexos_model.dart';

class AnexosController extends GetxController with StateMixin<AnexosModel> {
  final AppStateController appState = Get.find();
  final AnnexesRepository _apiConn = Get.find();

  UserModel get user => appState.user;

  List<BreadcrumbWeb> breadcrumbs = [
    BreadcrumbWeb('Inicio', route: WelcomePage.page.name),
    const BreadcrumbWeb('Anexos'),
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    change(state, status: RxStatus.loading());

    final bool anexos = await getAnnexes();

    if (!anexos) {
      change(state, status: RxStatus.error());
    }
  }

  /// We obtain the data for the annexes List
  Future<bool> getAnnexes() => appService.threads.execute(
    customExceptionMessages: {
      Exception(): ExceptionAlertProperties(
        message: 'Error al obtener Anexos. Inténtalo de nuevo más tarde',
      ),
    },
    func: () async {
      /// We obtain the data for the annexes
      final Response<List<AnnexesDto>> hasData = await _apiConn.fetchAnnexes(
        user.token.jwt,
      );

      /// We save the temporary data
      final List<AnnexesDto> tmpData = hasData.body!;

      /// We build  the model
      final AnexosModel anexos = AnexosModel.empty().copyWith(
        items: tmpData,
      );
      change(
        anexos,
        status: tmpData.isEmpty ? RxStatus.empty() : RxStatus.success(),
      );
    },
    onError: () {
      change(state, status: RxStatus.error());
    },
  );

  /// Download and share the annex file
  Future<void> downloadAnexo(String fileName) => appService.threads.execute(
    customExceptionMessages: {
      Exception(): ExceptionAlertProperties(
        message: 'Error al obtener el Anexo. Inténtalo de nuevo más tarde',
      ),
    },
    func: () async {
      /// Change state to loading
      change(state, status: RxStatus.loading());

      /// We download the annex file
      final Uint8List? response = await _apiConn.downloadAnnexes(
        fileName,
        user.token.jwt,
      );

      /// Change state to success
      change(state, status: RxStatus.success());

      /// if response is null show error message
      if (response == null) {
        /// message
        AppService.i.notifications.show(
          type: AlertType.error,
          message:
              'No se pudo descargar el anexo. Inténtalo de nuevo más tarde.',
        );
        return;
      }

      /// if file has been downloaded, share it
      await appService.fileStorage.downloadAndShareFile(
        data: response,
        fileName: fileName,
      );
    },
    onError: () => change(state, status: RxStatus.success()),
  );

  ///
}
