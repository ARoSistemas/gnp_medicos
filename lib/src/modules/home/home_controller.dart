import 'dart:async';

import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/services/threads/threads_service.dart';
import 'package:medicos/core/utils/exception_manager.dart';
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

  @override
  Future<void> onInit() async {
    super.onInit();
    if (appState.isDoctor) {
      await getAssistantList();
    }
  }

  @override
  void onReady() {
    super.onReady();
    if (!appState.isDoctor) {
      loadUserPermissions(isDoctor: false);
      unawaited(Get.offAllNamed(WelcomePage.page.name));
    }
  }

  /// Fetches the list of assistants associated with the current user.
  ///
  /// This method uses the [threadsService] to perform an asynchronous call to
  /// [´apiConn.fetchListado´].
  /// It also determines if the user has the 'Proveedor'
  /// role and updates the [´isDoctor´] flag accordingly.
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

        final _HomeModel newState = _HomeModel.empty().copyWith(
          asisstantList: res.body,
        );

        if (newState.asisstantList.length == 1 && !appState.isDoctor) {
          /// Select assistant to use
          await selectUser(newState.asisstantList.first);
        } else {
          /// Load user permissions like doctor
          loadUserPermissions(isDoctor: true);
        }

        if (newState.asisstantList.isEmpty) {
          /// Go to page Welcolme
          unawaited(Get.offAllNamed(WelcomePage.page.name));
        } else {
          /// Update state and wait to select user
          change(newState, status: RxStatus.success());
        }
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
    /// Set user like assistant
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
      customExceptionMessages: {
        Exception(): ExceptionAlertProperties(
          message: 'Los permisos no fueron recuperados',
        ),
      },
    );

    if (isOk) {
      unawaited(Get.offAllNamed(WelcomePage.page.name));
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
    final UserModel tmpUser = appState.user.copyWith(
      codigoFiliacion: item.codigoFiliacion,
      nombreCompleto:
          '${item.nombre} ${item.apellidoPaterno} ${item.apellidoMaterno}',
      apeMaterno: item.apellidoMaterno,
      apePaterno: item.apellidoPaterno,
      nombre: item.nombre,
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

    /// Load user permissions like assistant
    loadUserPermissions(isDoctor: false);
  }

  /// Loads the user's permissions into the application state.
  ///
  /// This method populates the [´appState.userPermissions´]
  /// map based on whether the user is a doctor or an assistant.
  ///
  /// If [isDoctor] is `true`, a predefined set of permissions for doctors is
  /// loaded. These permissions grant access to all sections of the app.
  ///
  /// If [isDoctor] is `false`, the permissions are loaded from the
  /// [appState.user.permisos´´] list, which contains the specific permissions
  /// assigned to the assistant. Only active permissions are considered.
  ///
  /// The [´appState.userPermissions´] map uses the permission ID (route) as the
  /// key and a boolean value indicating if the permission is active.
  void loadUserPermissions({required bool isDoctor}) {
    Map<String, dynamic> permisosMap = {};
    if (isDoctor) {
      permisosMap = {
        '/convenio-medico': true,
        '/tabuladores': true,
        '/mis-pagos': true,
        '/solicitar-convenio': true,
        '/mis-tramites': true,
        '/beneficios': true,
        '/anexos': true,
        '/formatos': true,
        '/evaluaciones': true,
        '/directorio-medico': true,
        '/contacto': true,
        '/datos-personales': true,
        '/datos-academicos': true,
        '/datos-fiscales': true,
        '/asistentes': true,
      };
    } else {
      permisosMap = {
        for (final PermissionsDto p in appState.user.permisos) p.id: p.activo,
      };
    }

    /// Save user permissions in app state
    appState.userPermissions = permisosMap;
  }
}
