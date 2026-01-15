import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/utils/exception_manager.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/widgets/custom_alert.dart';
import 'package:medicos/src/modules/change_password/domain/entities/check_item_model.dart';
import 'package:medicos/src/modules/change_password/domain/incoming/activate_account_response.dart';
import 'package:medicos/src/modules/change_password/widgets/change_password_success_dialog.dart';
import 'package:medicos/src/modules/home/home_page.dart';
import 'package:medicos/src/modules/login/domain/repositories/auth_repository.dart';
import 'package:medicos/src/modules/login/login_controller.dart';

part 'change_password_model.dart';

class ChangePasswordController extends GetxController
    with StateMixin<_ChangePasswordModel> {
  final TextEditingController temporalCtrl = TextEditingController();
  final TextEditingController contrasenaCtrl = TextEditingController();
  final TextEditingController confirmaContrasenaCtrl = TextEditingController();

  late final AuthRepository _authRepository;

  late final LoginController _loginController;

  RxBool isValid = false.obs;
  RxBool isValidPass = false.obs;
  RxBool isLoading = false.obs;

  // Visibilidad de contraseñas
  RxBool hideActual = true.obs;
  RxBool hideNueva = true.obs;
  RxBool hideConfirma = true.obs;

  // Visibilidad de reglas
  RxBool showRules = false.obs;

  // Tooltip
  RxBool showToolTip = false.obs;
  RxString messageToolTip = ''.obs;
  RxString titleToolTip = ''.obs;

  // Datos de usuario
  String? uid;
  RxString email = ''.obs;
  RxMap responseData = {}.obs;

  final String _imgCircle = 'assets/icons/password/circle.svg';
  final String _imgEquisCircle = 'assets/icons/password/equis-circle.svg';
  final String _imgOkCircle = 'assets/icons/password/ok-circle.svg';

  final int _caracteresCompletos = 0;
  final int _caracterMayuscula = 1;
  final int _caracterMinuscula = 2;
  final int _caracteresAlfabeticos = 3;
  final int _caracteresNumericos = 4;
  final int _caracterEspecial = 5;
  final int _caracterGNP = 6;
  final int _caracterConsecutivoIgual = 7;
  final int _caracterConsecutivo = 8;
  final int _espacioEnBlanco = 9;

  // Lista Reactiva de Validaciones
  late RxList<CheckItemModel> checkItems;

  @override
  void onInit() {
    super.onInit();

    _authRepository = Get.put(AuthRepository());
    _loginController = Get.put(LoginController());

    checkItems = <CheckItemModel>[
      CheckItemModel(
        name: msg.dAtLeast8Chars.tr(),
        image: _imgCircle,
      ),
      CheckItemModel(
        name: msg.dAtLeastOneUppercase.tr(),
        image: _imgCircle,
      ),
      CheckItemModel(
        name: msg.dAtLeastOneLowercase.tr(),
        image: _imgCircle,
      ),
      CheckItemModel(
        name: msg.dAtLeast4AlphaChars.tr(),
        image: _imgCircle,
      ),
      CheckItemModel(
        name: msg.dAtLeastOneNumeric.tr(),
        image: _imgCircle,
      ),
      CheckItemModel(
        name: msg.dAtLeastOneSpecialChar.tr(),
        image: _imgCircle,
      ),
      CheckItemModel(
        name: msg.dNoGnpWord.tr(),
        image: _imgCircle,
      ),
      CheckItemModel(
        name: msg.dNoConsecutiveEqualChars.tr(),
        image: _imgCircle,
      ),
      CheckItemModel(
        name: msg.dNoConsecutiveChars.tr(),
        image: _imgCircle,
      ),
      CheckItemModel(
        name: msg.dNoWhiteSpaces.tr(),
        image: _imgCircle,
      ),
    ].obs;

    uid = Get.parameters['token'];
    if (uid == null && Get.arguments != null && Get.arguments is Map) {
      uid = (Get.arguments as Map<String, dynamic>)['token'];
    }

    contrasenaCtrl.addListener(() {
      _onKey(contrasenaCtrl.text);
    });
  }

  Future<void> ingresar() async {
    if (temporalCtrl.text.isEmpty ||
        contrasenaCtrl.text.isEmpty ||
        confirmaContrasenaCtrl.text.isEmpty) {
      return;
    }

    if (contrasenaCtrl.text != confirmaContrasenaCtrl.text) {
      AppService.i.alert.show(
        type: AlertType.error,
        message: msg.dPasswordsDoNotMatch.tr(),
        title: msg.error.tr(),
      );
      return;
    }

    isLoading.value = true;

    await appService.threads.execute(
      customExceptionMessages: {
        Exception(): ExceptionAlertProperties(
          title: msg.error.tr(),
          message: msg.errorOccurred.tr(),
        ),
      },
      func: () async {
        final Response response = await _authRepository.postActivation(
          uid: uid!,
          contrasenaActual: temporalCtrl.text,
          contrasenaNueva: contrasenaCtrl.text,
        );
        isLoading.value = false;
        final ActivateAccountResponse res = ActivateAccountResponse.fromJson(
          response.body,
        );

        if (res.code == HttpStatus.conflict) {
          AppService.i.alert.show(
            type: AlertType.error,
            message: res.message,
            title: msg.error.tr(),
          );
        } else if (res.code == HttpStatus.ok) {
          email.value = res.payload;
          unawaited(
            _cambioExitoso(
              email: email.value,
              password: contrasenaCtrl.text,
            ),
          );
        }
      },
    );
    isLoading.value = false;
  }

  void _onKey(String valuePass) {
    if (valuePass.isEmpty) {
      for (final CheckItemModel item in checkItems) {
        item.image = _imgCircle;
      }
      checkItems.refresh();
    } else {
      _caracteresLetras(valuePass);
      _caracteresMayusLetra(valuePass);
      _caracterConFuncConfirma(valuePass);
      _caracteresAlfan(valuePass);
      _checkMayus(valuePass);
      _checkMinus(valuePass);

      bool localValid = true;
      for (final CheckItemModel e in checkItems) {
        if (e.image != _imgOkCircle) {
          localValid = false;
          break;
        }
      }
      habilitarContinuar(allRulesValid: localValid);
      checkItems.refresh();
    }
  }

  void _caracteresLetras(String value) {
    // Numeros
    checkItems[_caracteresNumericos].image = !RegExp('[0-9]').hasMatch(value)
        ? _imgEquisCircle
        : _imgOkCircle;

    // Caracter especial (TS: !/^[a-z0-9]+$/i.test)
    checkItems[_caracterEspecial].image =
        RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)
        ? _imgEquisCircle
        : _imgOkCircle;
  }

  void _caracteresMayusLetra(String value) {
    // Espacios
    checkItems[_espacioEnBlanco].image = RegExp(r'\s+').hasMatch(value)
        ? _imgEquisCircle
        : _imgOkCircle;

    // Longitud <= 7
    checkItems[_caracteresCompletos].image = value.length <= 7
        ? _imgEquisCircle
        : _imgOkCircle;

    // Palabra GNP
    checkItems[_caracterGNP].image = value.toLowerCase().contains('gnp')
        ? _imgEquisCircle
        : _imgOkCircle;
  }

  void _caracterConFuncConfirma(String value) {
    const abcStr = 'abcdefghijklmnopqrstuvwxyz';
    const numStr = '0123456789';

    bool foundConsecutive = false;

    for (int i = 0; i < value.length; i++) {
      if (i + 3 > value.length) {
        break;
      }

      final String sub = value.substring(i, i + 3).toLowerCase();
      if (sub.length == 3 && (abcStr.contains(sub) || numStr.contains(sub))) {
        checkItems[_caracterConsecutivo].image = _imgEquisCircle;
        foundConsecutive = true;
        break;
      }
    }

    if (!foundConsecutive) {
      checkItems[_caracterConsecutivo].image = _imgOkCircle;
    }

    // Caracteres consecutivos iguales (Regex: /([\w])\1{2,}/)
    checkItems[_caracterConsecutivoIgual].image =
        RegExp(r'([\w])\1{2,}').hasMatch(value)
        ? _imgEquisCircle
        : _imgOkCircle;
  }

  void _caracteresAlfan(String value) {
    int contador = 0;
    for (int i = 0; i < value.length; i++) {
      if (RegExp('[a-zA-ZñÑ]').hasMatch(value[i])) {
        contador++;
      }
    }

    if (contador < 4) {
      checkItems[_caracteresAlfabeticos].image = _imgEquisCircle;
    } else {
      checkItems[_caracteresAlfabeticos].image = _imgOkCircle;
    }
  }

  void _checkMayus(String value) {
    if (value.toLowerCase() != value) {
      checkItems[_caracterMayuscula].image = _imgOkCircle;
    } else {
      checkItems[_caracterMayuscula].image = _imgEquisCircle;
    }
  }

  void _checkMinus(String value) {
    if (value.toUpperCase() != value) {
      checkItems[_caracterMinuscula].image = _imgOkCircle;
    } else {
      checkItems[_caracterMinuscula].image = _imgEquisCircle;
    }
  }

  void habilitarContinuar({bool allRulesValid = false}) {
    if (temporalCtrl.text.isNotEmpty &&
        contrasenaCtrl.text.isNotEmpty &&
        confirmaContrasenaCtrl.text.isNotEmpty &&
        allRulesValid) {
      isValidPass.value = true;
    } else {
      isValidPass.value = false;
    }
  }

  void onFocusConfirmPassword({bool hasFocus = false}) {
    if (!hasFocus) {
      if (contrasenaCtrl.text != confirmaContrasenaCtrl.text) {
        openToolTip(msg.error.tr(), msg.dPasswordsDoNotMatch.tr());
      } else {
        closeToolTip();
      }
    }
  }

  void openToolTip(String title, String message) {
    titleToolTip.value = title;
    messageToolTip.value = message;
    showToolTip.value = true;
  }

  void closeToolTip() {
    showToolTip.value = false;
  }

  Future<void> _cambioExitoso({
    required String email,
    required String password,
  }) async {
    await AppService.i.alert.showAlert(
      child: ChangePasswordSuccessDialog(
        onContinue: () async {
          Get.back();
          isLoading.value = true;
          final bool res = await _loginController.login(email, password);
          if (res) {
            unawaited(
              Get.offAllNamed(HomePage.page.name)?.then((_) {
                if (kIsWeb || GetPlatform.isDesktop) {
                  Get.find<AppStateController>().buildMenuWeb(
                    msg.home.tr(),
                    [],
                  );
                }
              }),
            );
          }
          isLoading.value = false;
        },
      ),
    );
  }

  @override
  void onClose() {
    temporalCtrl.dispose();
    contrasenaCtrl.dispose();
    confirmaContrasenaCtrl.dispose();
    super.onClose();
  }
}
