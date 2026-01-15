import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/services/threads/threads_service.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/widgets/custom_alert.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/formats/domain/remote/formats_repository.dart';
import 'package:medicos/src/modules/formats/entities/dto/format_dto.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';

part 'formats_model.dart';

class FormatsController extends GetxController with StateMixin<_FormatsModel> {
  final AppStateController appState = Get.find<AppStateController>();
  final ThreadsService threadsService = Get.find();
  final FormatsRepository apiConn = Get.find();
  UserModel get user => appState.user;

  List<BreadcrumbWeb> breadcrumbs = [
    BreadcrumbWeb(msg.home.tr(), route: WelcomePage.page.name),
    BreadcrumbWeb(msg.formats.tr()),
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    await getFormatos();
  }

  Future<void> getFormatos() async {
    await threadsService.execute(
      func: () async {
        final Map? dataFirebase = await appService.shared.realtimeService
            .getDataOnce('appConfig/modulos/formatos');
        final List<String> whiteList = List<String>.from(
          dataFirebase?['listaBlanca'] ?? [],
        );
        final Response<List<FormatDto>> res = await apiConn.getFormats();
        final List<FormatDto>? formatsFiltered = res.body
            ?.where((e) => whiteList.contains(e.id))
            .toList();
        final _FormatsModel newState = _FormatsModel.empty().copyWith(
          formatsList: formatsFiltered,
        );
        if (newState.formatsList.isEmpty) {
          change(newState, status: RxStatus.empty());
        } else {
          change(newState, status: RxStatus.success());
        }
      },
      onError: () {
        change(
          _FormatsModel.empty(),
          status: RxStatus.error(),
        );
      },
    );
  }

  Future<void> downloadFormato(String filename) async {
    try {
      change(state, status: RxStatus.loading());
      final Uint8List? response = await apiConn.downloadFormat(filename);
      change(state, status: RxStatus.success());
      if (response != null) {
        await appService.fileStorage.downloadAndShareFile(
          data: response,
          fileName: filename,
        );
      } else {
        appService.alert.show(
          title: msg.error.tr(),
          message: msg.errorGettingFormat.tr(),
          type: AlertType.error,
        );
      }
    } on Exception catch (e) {
      change(state, status: RxStatus.success());
      appService.alert.show(
        title: msg.error.tr(),
        message: msg.errorDetail.tr(args: [e.toString()]),
        type: AlertType.error,
      );
    }
  }

  String getNameImage(String file) =>
      'imagen_formato_${file.toLowerCase().replaceAll('.pdf', '.png')}';
}
