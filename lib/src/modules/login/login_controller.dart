import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/services/threads/threads_service.dart';
import 'package:medicos/core/utils/logger.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/claims_mdl.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/services/alerts/notification_service.dart';
import 'package:medicos/shared/services/storage/user_storage.dart';
import 'package:medicos/shared/widgets/custom_notification.dart';
import 'package:medicos/src/modules/home/home_page.dart';
import 'package:medicos/src/modules/login/domain/repositories/auth_repository.dart';
import 'package:medicos/src/modules/registro/registro_page.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';

part 'login_model.dart';

class LoginController extends GetxController with StateMixin<LoginModel> {
  final AuthRepository _authService = Get.find();
  final ThreadsService threadsService = Get.find();
  final AppStateController appState = Get.find();

  final NotificationServiceImpl _notification = AppService.i.notifications;

  final LocalAuthentication auth = LocalAuthentication();

  final formKey = GlobalKey<FormState>();

  RxBool isAuthenticated = false.obs;
  RxBool canCheckBiometrics = false.obs;
  final RxList<BiometricType> availableBiometrics = <BiometricType>[].obs;

  RxBool isLoading = false.obs;
  RxBool isEmailEntered = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController emailForgotPassController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isPasswordVisible = false.obs;
  RxBool isAsistenteMedico = false.obs;

  final UserStorage userStorage = AppService.i.userStorage;
  final formKeyForgotPassword = GlobalKey<FormState>();

  @override
  Future<void> onInit() async {
    super.onInit();
    change(LoginModel.empty(), status: RxStatus.success());
    await checkBiometricsSupport();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailForgotPassController.dispose();
    super.onClose();
  }

  Future<void> doLogin() async {
    Get.back();

    if (!formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(Get.context!).unfocus();
    if (!isEmailEntered.value) {
      toggleInputFields();
    } else {
      await login(
        emailController.text,
        passwordController.text,
      ).then((value) {
        if (value) {
          if (isAsistenteMedico.value) {
            unawaited(Get.offAllNamed(HomePage.page.name));
          } else {
            unawaited(Get.offAllNamed(WelcomePage.page.name));
          }
        }
      });
    }
  }

  /// Get Login
  Future<bool> login(String email, String password) async {
    isLoading.value = true;
    
    bool ret = false;
    
    await appService.threads.execute(
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
          email: email,
          pass: password,
          nombreCompleto:
              '${claims.givenName} '
              '${claims.apePaterno} '
              '${claims.apeMaterno}',
        );

        /// Flag para determinar si es Médico o Asistente
        isAsistenteMedico.value = claims.roles.contains(
          'Asistente Medico',
        );

        /// Se guarda en el storage temporalmente
        userStorage.saveUser(userLogged);
        ret = true;
      },
      errorMsg: 'Contraseña incorrecta. Verifícala e inténtalo de nuevo',
      onError: () {
        ret = false;
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
        res = await _authService.forgotPassword(
          emailForgotPassController.text,
        );
      },
    );

    if (res) {
      _notification.show(
        title: 'Éxito',
        message: 'El correo de recuperación se envió correctamente.',
        type: AlertType.success,
      );
    }
    isLoading.value = false;
    emailForgotPassController.text = '';
    Get.back();
  }

  void toggleInputFields() {
    isEmailEntered.value = !isEmailEntered.value;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> checkBiometricsSupport() async {
    try {
      canCheckBiometrics.value = await auth.canCheckBiometrics;
      if (canCheckBiometrics.value) {
        availableBiometrics.assignAll(await auth.getAvailableBiometrics());
      }
    } on PlatformException catch (e) {
      logger.i('Error biometrics ${e.message}');
    }
  }

  Future<void> authenticate() async {
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
        ),
      );

      isAuthenticated.value = didAuthenticate;

      if (didAuthenticate) {
        _notification.show(
          title: 'Éxito',
          message: 'Autenticación Biométrica Exitosa.',
          type: AlertType.success,
        );
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

  void logout() {
    isAuthenticated.value = false;
    appState.reset();
    emailController.text = '';
    passwordController.text = '';

    _notification.show(
      title: 'Sesión cerrada',
      message: 'Ha cerrado la sesión.',
      type: AlertType.success,
    );
  }

  /// EndClass
}
