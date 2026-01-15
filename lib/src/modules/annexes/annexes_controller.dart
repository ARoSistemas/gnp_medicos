import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/utils/exception_manager.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/widgets/custom_alert.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/annexes/domain/dtos/annexes_dto.dart';
import 'package:medicos/src/modules/annexes/domain/repository/annexes_repository.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';

part 'annexes_model.dart';

class AnnexesController extends GetxController with StateMixin<AnnexesModel> {
  final AppStateController appState = Get.find();
  final AnnexesRepository _apiConn = Get.find();

  UserModel get user => appState.user;

  List<BreadcrumbWeb> breadcrumbs = [
    BreadcrumbWeb(msg.home.tr(), route: WelcomePage.page.name),
    BreadcrumbWeb(msg.annexes.tr()),
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
        message: msg.errorGettingAnnexes.tr(),
      ),
    },
    func: () async {
      final Map? dataFirebase = await appService.shared.realtimeService
      .getDataOnce('appConfig/modulos/anexos');
      final List<String> whiteList = List<String>
      .from(dataFirebase?['listaBlanca'] ?? []);
      /// We obtain the data for the annexes
      final Response<List<AnnexesDto>> hasData = await _apiConn.fetchAnnexes(
        user.token.jwt,
      );

      /// We save the temporary data
      final List<AnnexesDto> tmpData = hasData.body ?? [];

      final List<AnnexesDto> annexesFiltered = tmpData.where((e) => 
        whiteList.contains(e.id)
      ).toList();
      /// We build  the model
      final AnnexesModel anexos = AnnexesModel.empty().copyWith(
        items: annexesFiltered,
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
        message: msg.errorDownloadingAnnex.tr(),
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
        appService.alert.show(
          type: AlertType.error,
          message: msg.couldNotDownloadAnnex.tr(),
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

  String getNameImage(String file) =>
      'imagen_anexo_${file.toLowerCase().replaceAll('.pdf', '.png')}';

  ///
}
