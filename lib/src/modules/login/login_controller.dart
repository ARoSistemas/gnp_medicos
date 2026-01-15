import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:medicos/core/config/flavor_config.dart';
import 'package:medicos/core/extensions/null_extensions.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/services/threads/threads_service.dart';
import 'package:medicos/core/utils/exception_manager.dart';
import 'package:medicos/core/utils/logger.dart';
import 'package:medicos/shared/constans/constans.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/models/entities/claims_mdl.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/services/storage/user_storage.dart';
import 'package:medicos/shared/utils/tools.dart';
import 'package:medicos/shared/widgets/custom_alert.dart';
import 'package:medicos/src/modules/home/home_page.dart';
import 'package:medicos/src/modules/login/domain/repositories/auth_repository.dart';
import 'package:medicos/src/modules/login/widgets/modal_forgot_password.dart';
import 'package:medicos/src/modules/registro/registro_page.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'login_model.dart';

class LoginController extends GetxController with StateMixin<LoginModel> {
  final AuthRepository _authService = Get.find();
  final ThreadsService threadsService = Get.find();
  final AppStateController appState = Get.find();
  late PackageInfo packageInfo;

  final LocalAuthentication auth = LocalAuthentication();

  final formKey = GlobalKey<FormState>();

  RxBool canCheckBiometrics = false.obs;
  RxBool rememberUser = false.obs;
  final RxList<BiometricType> availableBiometrics = <BiometricType>[].obs;

  RxBool isLoading = false.obs;
  RxBool isLoadingForgot = false.obs;
  Rxn<UserModel> userStored = Rxn<UserModel>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController emailForgotPassController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isPasswordVisible = false.obs;

  final UserStorage userStorage = appService.userStorage;
  final formKeyForgotPassword = GlobalKey<FormState>();

  @override
  Future<void> onInit() async {
    super.onInit();
    change(LoginModel.empty(), status: RxStatus.success());
    await checkBiometricsSupport();
    packageInfo = await PackageInfo.fromPlatform();
    appState.version = packageInfo.version;
    if (FlavorConfig.flavor == Flavors.qa ||
        FlavorConfig.flavor == Flavors.uat) {
      appState.version = '${appState.version}(${packageInfo.buildNumber})';
    }
    checkEmail();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailForgotPassController.dispose();
    super.onClose();
  }

   void checkEmail() {
    final String? email = appService.userStorage.getEmail();
    if (email != null) {
      emailController.text = email;
      rememberUser.value = true;
    }
   }

  Future<void> doLogin({bool biometric = false}) async {
    Get.back();

    if (!biometric && userStored.value != null) {
      emailController.text = (userStored.value?.email).value();
    }

    if (!biometric && !formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(Get.context!).unfocus();

    await login(
      biometric ? (userStored.value?.email).value() 
      : emailController.text.trim(),
      biometric ? (userStored.value?.pass).value() 
      : passwordController.text.trim(),
    ).then((value) async {
      if (value) {
        appState.userLogued.rememberUser = rememberUser.value;
        await appService.userStorage.cleanSessionWeb();
        unawaited(
          Get.offAllNamed(HomePage.page.name)?.then((_) {
            if (kIsWeb || GetPlatform.isDesktop) {
              /// Construir el menú web
              appState.buildMenuWeb(msg.home.tr(), []);
            }
          }),
        );
      }
    });
  }

  /// Get Login
  Future<bool> login(String email, String password) async {
    isLoading.value = true;

    final bool ret = await appService.threads.execute(
      customExceptionMessages: {
        Exception(): ExceptionAlertProperties(
          message: msg.invalidUserOrPassword.tr(),
        ),
      },
      func: () async {
        final Response<LoginModel> hasUser = await _authService.login(
          email,
          password,
        );

        final LoginModel loginData = hasUser.body!;
        final UserModel userLogged = loginData.toEntity().user;

        /// Se guarda en el estado global el usuario logeado
        final Claims claims = userLogged.token.jwtLogin.claims;
        appState.user = userLogged.copyWith(
          biometric: userStorage.getUser()?.biometric ?? false,
          email: email,
          nombreCompleto:
              '${claims.givenName} '
              '${claims.apePaterno} '
              '${claims.apeMaterno}',
          nombre: claims.givenName,
          apePaterno: claims.apePaterno,
          apeMaterno: claims.apeMaterno,
          banConvenioVigenteEstatus:
              userLogged.estatus == StatusAgreement.vigente,
          banConvenioVigenteFecha: Tools.isAgreedByString(
            userLogged.vigenciaConvenio,
          ),
          uid: userLogged.token.jwtLogin.uid,
        );

        /// Si el rol es asistente, isDoctor = false;
        appState.isDoctor = !claims.roles.contains('Asistente Medico');

        /// Se guarda en el storage temporalmente
        final UserModel userStored = appState.user.copyWith(pass: password);
        appState.userLogued = appState.user;
        if (!kIsWeb) {
          userStorage.saveUser(userStored);
        }
      },
    );

    isLoading.value = false;
    return ret;
  }

  /// Get Password Recovery
  Future<void> forgotPassword() async {
    if (!formKeyForgotPassword.currentState!.validate()) {
      return;
    }
    FocusScope.of(Get.context!).unfocus();
    bool res = false;

    await threadsService.execute(
      func: () async {
        isLoadingForgot.value = true;
        res = await _authService.forgotPassword(
          emailForgotPassController.text,
        );
      },
    );

    if (res) {
      appService.alert.show(
        title: msg.success.tr(),
        message: msg.passwordRecoveryLinkSent.tr(),
        type: AlertType.success,
      );
    }
    isLoadingForgot.value = false;
    emailForgotPassController.text = '';
    Get.back();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> checkBiometricsSupport() async {
    if (!kIsWeb) {
      try {
        canCheckBiometrics.value = await auth.canCheckBiometrics;
        if (canCheckBiometrics.value) {
          availableBiometrics.assignAll(await auth.getAvailableBiometrics());
          userStored.value = userStorage.getUser();
        }
      } on PlatformException catch (e) {
        logger.i('Error biometrics ${e.message}');
      }
    }
  }

  Future<void> authenticateBiometric() async {
    if (!canCheckBiometrics.value) {
      appService.alert.show(
        title: msg.error.tr(),
        message: msg.biometricsNotAvailable.tr(),
        type: AlertType.error,
      );
      return;
    }

    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Por favor, autentíquese para acceder a la aplicación',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (didAuthenticate) {
        await doLogin(biometric: true);
      } else {
        appService.alert.show(
          title: msg.failed.tr(),
          message: msg.biometricAuthenticationFailed.tr(),
          type: AlertType.error,
        );
      }
    } on Exception catch (_) {
      appService.alert.show(
        title: msg.error.tr(),
        message: msg.errorAuthenticating.tr(),
        type: AlertType.error,
      );
    }
  }

  Future<void> navigateRegister() async {
    if (!isLoading.value) {
      await Get.toNamed(RegistroPage.page.name);
    }
  }

  Future<void> onRemember({bool? value}) async {
    rememberUser.value = value.value();
  }

  /// Change User
  Future<void> changeUser() async {
    await userStorage.cleanUser();
    userStored.value = userStorage.getUser();
  }

  Future<void> showDilaogPassword() async {
    await appService.alert.showAlert(
      child: ModalForgotPassword()
    );
  }

  /// EndClass
}
