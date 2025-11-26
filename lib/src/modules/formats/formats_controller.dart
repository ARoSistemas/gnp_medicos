import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/services/threads/threads_service.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/services/alerts/notification_service.dart';
import 'package:medicos/shared/widgets/custom_notification.dart';
import 'package:medicos/src/modules/formats/domain/remote/formats_repository.dart';
import 'package:medicos/src/modules/formats/entities/dto/format_dto.dart';


part 'formats_model.dart';

class FormatsController extends GetxController with StateMixin<_FormatsModel> {
  final NotificationServiceImpl _notification = appService.notifications;
  final AppStateController appState = Get.find<AppStateController>();
  final ThreadsService threadsService = Get.find();
  final FormatsRepository apiConn = Get.find();
  UserModel get user => appState.user;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getFormatos();
  }

   Future<void> getFormatos() async {
    await threadsService.execute(
      func: () async {
        final Response<List<FormatDto>> res = await apiConn.getFormats();
        final _FormatsModel newState = _FormatsModel.empty().copyWith(
          formatsList: res.body,
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
      final Uint8List? response = await apiConn
      .downloadFormat(filename);
     change(state, status: RxStatus.success());
      if (response != null) {
        await appService.fileStorage.downloadAndShareFile(
          data: response, 
          fileName: filename
        );
      } else {
        _notification.show(
          title: 'Error',
          message: 'No se logró obtener el formato.',
          type: AlertType.error,
        );
      }
    } on Exception catch (e) {
      change(state, status: RxStatus.success());
      _notification.show(
        title: 'Error',
        message: 'Ocurrió el detalle $e.',
        type: AlertType.error,
      );
    }
  }
}
