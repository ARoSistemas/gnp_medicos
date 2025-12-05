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
import 'package:medicos/shared/models/entities/claims_mdl.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/services/alerts/notification_service.dart';
import 'package:medicos/shared/services/storage/user_storage.dart';
import 'package:medicos/shared/widgets/custom_notification.dart';
import 'package:medicos/src/modules/home/home_page.dart';
import 'package:medicos/src/modules/login/domain/repositories/auth_repository.dart';
import 'package:medicos/src/modules/registro/registro_page.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'login_model.dart';

class LoginController extends GetxController with StateMixin<LoginModel> {
  final AuthRepository _authService = Get.find();
  final ThreadsService threadsService = Get.find();
  final AppStateController appState = Get.find();
  late PackageInfo packageInfo;

  final NotificationServiceImpl _notification = AppService.i.notifications;
  final LocalAuthentication auth = LocalAuthentication();

  final formKey = GlobalKey<FormState>();

  RxBool canCheckBiometrics = false.obs;
  final RxList<BiometricType> availableBiometrics = <BiometricType>[].obs;

  RxBool isLoading = false.obs;
  RxBool isLoadingForgot = false.obs;
  Rxn<UserModel> userStored = Rxn<UserModel>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController emailForgotPassController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isPasswordVisible = false.obs;

  final UserStorage userStorage = AppService.i.userStorage;
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
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailForgotPassController.dispose();
    super.onClose();
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
      biometric ? (userStored.value?.email).value() : emailController.text,
      biometric ? (userStored.value?.pass).value() : passwordController.text,
    ).then((value) {
      if (value) {
        if (kIsWeb || GetPlatform.isDesktop) {
          /// Construir el menú web
          appState.buildMenuWeb('Inicio', []);
        }

        unawaited(Get.offAllNamed(HomePage.page.name));
      }
    });
  }

  /// Get Login
  Future<bool> login(String email, String password) async {
    isLoading.value = true;

    final bool ret = await appService.threads.execute(
      customExceptionMessages: {
        Exception(): ExceptionAlertProperties(
          message:
              'Usuario y/o contraseña incorrectos. '
              'Verifícala e inténtalo de nuevo.',
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
          banConvenioVigente: userLogged.estatus == StatusAgreement.vigente,
          uid: userLogged.token.jwtLogin.uid,
        );

        /// Si el rol es asistente, isDoctor = false;
        appState.isDoctor = !claims.roles.contains('Asistente Medico');

        /// Se guarda en el storage temporalmente
        final UserModel userStored = appState.user.copyWith(pass: password);
        appState.userLogued = appState.user;
        userStorage.saveUser(userStored);
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
      _notification.show(
        title: 'Envió exitoso',
        message:
            'Se envió un enlace de recuperación de contraseña a tu correo.',
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
      _notification.show(
        title: 'Error',
        message: 'La biometría no está disponible en este dispositivo.',
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
        _notification.show(
          title: 'Falló',
          message: 'Autenticación Biométrica Fallida.',
          type: AlertType.error,
        );
      }
    } on Exception catch (_) {
      _notification.show(
        title: 'Error',
        message: 'Ocurrió un error al intentar autenticar.',
        type: AlertType.error,
      );
    }
  }

  Future<void> navigateRegister() async {
    if (!isLoading.value) {
      await Get.toNamed(RegistroPage.page.name);
    }
  }

  Future<void> changeUser() async {
    await userStorage.cleanUser();
    userStored.value = userStorage.getUser();
  }

  /// EndClass
}
