import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/utils/exception_manager.dart';
import 'package:medicos/core/utils/logger.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/services/storage/user_storage.dart';
import 'package:medicos/shared/widgets/custom_alert.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/login/domain/repositories/auth_repository.dart';
import 'package:medicos/src/modules/login/login_page.dart';
import 'package:medicos/src/modules/profile/children/academic_data/academic_data_controller.dart';
import 'package:medicos/src/modules/profile/children/academic_data/academic_data_page.dart';
import 'package:medicos/src/modules/profile/children/fiscal_data/fiscal_data_controller.dart';
import 'package:medicos/src/modules/profile/children/fiscal_data/fiscal_data_page.dart';
import 'package:medicos/src/modules/profile/children/personal_data/personal_data_controller.dart';
import 'package:medicos/src/modules/profile/children/personal_data/personal_data_page.dart';
import 'package:medicos/src/modules/profile/domain/entities/dtos/profile_dto.dart';
import 'package:medicos/src/modules/profile/domain/repository/profile_repository.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';
import 'package:medicos/src/modules/welcome/widgets/modal_informative.dart';

part 'profile_model.dart';

/// Clase para representar cada tab de datos
class DataTabItem {

  DataTabItem({
    required this.label,
    required this.widgetBuilder,
    required this.onInit,
  });
  final String label;
  final Widget Function() widgetBuilder;
  final VoidCallback onInit;
}

class ProfileController extends GetxController
    with StateMixin<ProfileModel>, GetTickerProviderStateMixin {
  final ProfileRepository _apiCon = Get.find();
  final AuthRepository _apiAuth = Get.find();
  final AppStateController appState = Get.find();
  final UserStorage userStorage = appService.userStorage;

  UserModel get user => appState.user;
  String get jwt => appState.user.token.jwt;

  UserModel? get userStored => userStorage.getUser();

  RxInt selectedIndex = 0.obs;
  final Rx<String?> selectedItem = Rx<String?>(null);

  final RxBool enableAsisstant = true.obs;
  RxBool canCheckBiometrics = false.obs;

  ProfileDto profileDto = ProfileDto.empty();

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();

  late TabController mainTabController = TabController(length: 2, vsync: this);
  late TabController dataTabController;

  /// Lista dinámica de tabs disponibles según permisos
  final RxList<DataTabItem> availableTabs = <DataTabItem>[].obs;

  List<BreadcrumbWeb> breadcrumbs = [
    BreadcrumbWeb(msg.home.tr(), route: WelcomePage.page.name),
    BreadcrumbWeb(msg.myProfile.tr()),
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    change(state, status: RxStatus.loading());

    /// Construir lista dinámica de tabs según permisos
    _buildAvailableTabs();

    dataTabController = TabController(
      length: availableTabs.length,
      vsync: this,
    );
    enableAsisstant.value = user.banConvenioVigenteEstatus && appState.isDoctor;

    await checkBiometricsSupport();
    await _fetchProfile();

    change(state, status: RxStatus.success());
  }

  /// Construye la lista de tabs disponibles según permisos del usuario
  void _buildAvailableTabs() {
    availableTabs.clear();

    // Tab de Datos Personales
    if (appState.userPermissions[DatosPersonalesPage.page.name] ?? false) {
      availableTabs.add(
        DataTabItem(
          label: msg.personalData.tr(),
          widgetBuilder: DatosPersonalesDesktopPage.new,
          onInit: () {
            Get.find<DatosPersonalesController>()
              ..data = profileDto
              ..onInit();
          },
        ),
      );
    }

    // Tab de Datos Académicos
    if ((appState.userPermissions[DatosAcademicosPage.page.name] ?? false) &&
        user.banConvenioVigenteEstatus) {
      availableTabs.add(
        DataTabItem(
          label: msg.academicData.tr(),
          widgetBuilder: DatosAcademicosDesktopPage.new,
          onInit: () {
            Get.find<DatosAcademicosController>()
              ..data = profileDto.datosAcademicos
              ..dataHospital = profileDto.mainHospital
              ..dataProfesion = profileDto.profession
              ..onInit();
          },
        ),
      );
    }

    // Tab de Datos Fiscales
    if ((appState.userPermissions[DatosFiscalesPage.page.name] ?? false) &&
        user.banConvenioVigenteEstatus) {
      availableTabs.add(
        DataTabItem(
          label: msg.taxData.tr(),
          widgetBuilder: DatosFiscalesDesktopPage.new,
          onInit: () {
            Get.find<DatosFiscalesController>()
              ..data = profileDto.datosFiscales
              ..dataBank = profileDto.bankingData
              ..onInit();
          },
        ),
      );
    }
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    mainTabController.dispose();
    dataTabController.dispose();
    super.onClose();
  }

  void onTapChange(int index) {
    if (index >= 0 && index < availableTabs.length) {
      selectedIndex.value = index;
      availableTabs[index].onInit();
    }
  }

  Future<bool> _fetchProfile() => appService.threads.execute(
    customExceptionMessages: {
      Exception(): ExceptionAlertProperties(
        message: msg.errorToGetProfile.tr(),
      ),
    },
    func: () async {
      final Response<ProfileDto> profileResponse = await _apiCon.fetchProfile(
        rfc: user.rfc,
        jwt: jwt,
        codigoFiliacion: user.codigoFiliacion,
      );
      profileDto = profileResponse.body!;
      onTapChange(0);
    },
    onError: () {
      appService.alert.show(
        type: AlertType.info,
        title: msg.errorLoadingProfileTitle.tr(),
        message: msg.errorLoadingProfile.tr(),
      );
      change(state, status: RxStatus.success());
    },
  );

  Future<void> checkBiometricsSupport() async {
    if (!kIsWeb) {
      try {
        canCheckBiometrics.value = await auth.canCheckBiometrics;
      } on PlatformException catch (e) {
        logger.i('Error biometrics ${e.message}');
      }
    }
  }

  Future<void> activeBiometric({required bool value}) async {
    if (userStored != null) {
      final UserModel tmpUserStored = userStored!.copyWith(biometric: value);
      userStorage.saveUser(tmpUserStored);
      canCheckBiometrics.value = false;
      await checkBiometricsSupport();
    }
  }

  Future<void> resetPassword() async {
    await appService.alert.showAlert(
      child: ModalInformative(
        title: msg.tResetPassword.tr(),
        message: msg.dResetPassword.tr(),
        onOk: () async {
          change(state, status: RxStatus.loading());
          await appService.threads.execute(
            func: () async {
              final bool res = await _apiAuth.forgotPassword(
                appState.userLogued.email,
              );
              if (res) {
                await goToLogin();
                appService.alert.show(
                  title: msg.success.tr(),
                  message: msg.passwordRecoveryLinkSent.tr(),
                  type: AlertType.success,
                );
              }
            },
          );
        },
        onCancel: () => Get.back,
      ),
    );
  }

  Future<void> signOut() async {
    await appService.alert.showAlert(
      child: ModalInformative(
        title: msg.tSignOut.tr(),
        message: msg.dSignOut.tr(),
        onOk: () async {
          await goToLogin();
        },
        onCancel: () => Get.back,
      ),
    );
  }

  Future<void> uploadProfilePhoto(PlatformFile file) async {
    try {
      await appService.threads.execute(
        func: () async {
          final String extension = file.name.split('.').last;
          final String fileName = 'profile.$extension';

          await _apiCon.uploadProfilePhoto(
            jwt: jwt,
            rfc: user.rfc,
            fileName: fileName,
            fileBytes: file.bytes,
          );
        },
      );
      appService.alert.show(
        title: 'Éxito',
        message: 'La foto de perfil se ha subido correctamente.',
        type: AlertType.success,
      );
      await _fetchProfile();
    } on Exception catch (_) {
      appService.alert.show(
        title: 'Error',
        message: 'No se pudo subir la foto. Inténtalo de nuevo.',
        type: AlertType.error,
      );
    }
  }

  Future<void> deleteAccount() async {
    await appService.alert.showAlert(
      child: ModalInformative(
        title: msg.tDeleteAccount.tr(),
        message: msg.dDeleteAccount.tr(),
        onOk: () async {
          change(state, status: RxStatus.loading());
          await appService.threads.execute(
            func: () async {
              final bool res = await _apiAuth.deleteAccount(
                appState.userLogued.token.jwtLogin.uid,
                appState.user.token.jwt,
              );
              if (res) {
                await goToLogin();
                await appService.alert.showAlert(
                  child: ModalInformative(
                    title: msg.tDeletedAccount.tr(),
                    message: msg.dDeletedAccount.tr(),
                  ),
                );
              }
            },
            onError: () => change(state, status: RxStatus.success()),
          );
        },
        onCancel: () => Get.back,
      ),
    );
  }

  Future<void> goToLogin() async {
    appState.reset();
    if (kIsWeb) {
      await appService.userStorage.cleanSessionWeb();
    }
    unawaited(Get.offAllNamed(LoginPage.page.name));
  }
}
