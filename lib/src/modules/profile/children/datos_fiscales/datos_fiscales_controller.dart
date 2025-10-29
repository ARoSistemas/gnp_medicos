import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';

part 'datos_fiscales_model.dart';

class DatosFiscalesController extends GetxController
    with StateMixin<_DatosFiscalesModel> {
  /// El estado de la app
  final AppStateController appState = Get.find<AppStateController>();
  UserModel get user => appState.user;
  String get jwt => appState.user.token.jwt;

  final TextEditingController birthdateController = TextEditingController(
    text: '31-09-1990',
  );
  final TextEditingController phoneNumberController = TextEditingController(
    text: '(+52) 5592717483',
  );
  final TextEditingController emailController = TextEditingController(
    text: 'juan@gmail.com',
  );

  @override
  void onInit() {
    super.onInit();
    const _DatosFiscalesModel datosFiscalesModel = _DatosFiscalesModel();
    change(datosFiscalesModel, status: RxStatus.success());
  }

  /* @override
  void onReady() {
    super.onReady();
  } */

  /*  @override
  void onClose() {
    super.onClose();
  } */
}
