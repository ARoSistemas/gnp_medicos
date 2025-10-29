import 'dart:async';

import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/services/threads/threads_service.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/src/modules/home/domain/entities/dtos/asisstant_dto.dart';
import 'package:medicos/src/modules/home/domain/repositories/home_repository.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/domain/dtos/permissions_dto.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';

part 'home_model.dart';

class HomeController extends GetxController with StateMixin<_HomeModel> {
  final ThreadsService threadsService = Get.find();
  final HomeRepository apiConn = Get.find();
  final AppStateController appState = Get.find();

  Rx<bool> isDoctor = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getAssistantList();
  }

  /// Fetches the list of assistants associated with the current user.
  ///
  /// This method uses the [threadsService] to perform an asynchronous call to
  /// [´apiConn.fetchListado´]. 
  /// It also determines if the user has the 'Proveedor' 
  /// role and updates the [isDoctor] flag accordingly.
  ///
  /// Upon completion, it updates the controller's state with the fetched list:
  /// - [RxStatus.success] if the list is not empty.
  /// - [RxStatus.empty] if the list is empty.
  /// - [RxStatus.error] if an error occurs during the fetch.
  Future<void> getAssistantList() async {
    await threadsService.execute(
      func: () async {
        final Response<List<AsisstantDto>> res = await apiConn.fetchListado(
          appState.user.token.jwtLogin.uid,
          appState.user.token.jwt,
        );

        isDoctor.value = appState.user.token.jwtLogin.claims.roles.contains(
          'Proveedor',
        );

        final _HomeModel newState = _HomeModel.empty().copyWith(
          asisstantList: res.body,
        );

        change(
          newState,
          status: newState.asisstantList.isEmpty
              ? RxStatus.empty()
              : RxStatus.success(),
        );
      },
      onError: () {
        change(
          _HomeModel.empty(),
          status: RxStatus.error(),
        );
      },
    );
  }

  /// Selects a user and updates the application state.
  ///
  /// This method is called when a user is selected from the list. 
  /// It fetches the user's permissions and updates the user's data 
  /// in the [appState].
  /// If the permissions are fetched successfully, 
  /// it navigates to the [WelcomePage].
  Future<void> selectUser(AsisstantDto item) async {
    appState.isDoctor = false;
    bool isOk = false;
    await appService.threads.execute(
      func: () async {
        final Response<List<PermissionsDto>> res = await apiConn.getPermissions(
          appState.user.token.jwtLogin.uid,
          item.codigoFiliacion,
          appState.user.token.jwt,
        );
        await updateUserData(item, res.body ?? []);
        isOk = true;
      },
      errorMsg: 'Los permisos no fueron recuperados',
      onError: () {
        // Que hacer si no se recuperan los permisos ???
      },
    );

    if (isOk) {
      unawaited(Get.toNamed(WelcomePage.page.name));
    }
  }

  /// Updates the user data in the application state.
  ///
  /// This method is called after a user is selected. It takes the user's data
  /// and the user's permissions and updates the [appState] with the new data.
  Future<void> updateUserData(
    AsisstantDto item,
    List<PermissionsDto> permisos,
  ) async {
    appState.isDoctor = false;
    final UserModel tmpUser = appState.user.copyWith(
      codigoFiliacion: item.codigoFiliacion,
      nombreCompleto:
          '${item.nombre} ${item.apellidoPaterno} ${item.apellidoMaterno}',
      rfc: item.rfc,
      especialidad: item.especialidad,
      estado: item.estado,
      circulo: item.circulo,
      tabulador: item.tabulador,
      estatus: item.estatus,
      banVerConvenio: item.banVerConvenio,
      banDescargaConvenio: item.banDescargaConvenio,
      banVerAviso: item.banVerAviso,
      banConvenioActualizado: item.banConvenioActualizado,
      permisos: permisos.where((permiso) => permiso.activo).toList(),
    );
    appState.user = tmpUser;
  }
}
