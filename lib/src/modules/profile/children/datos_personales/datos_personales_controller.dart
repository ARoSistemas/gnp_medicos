import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';

part 'datos_personales_model.dart';

class DatosPersonalesController extends GetxController
    with StateMixin<_DatosPersonalesModel> {
  final AppStateController appState = Get.find<AppStateController>();
  UserModel get user => appState.user;

  final TextEditingController nameController = TextEditingController(
    text: 'Juan Pérez López',
  );
  final TextEditingController birthdateController = TextEditingController(
    text: '31-09-1990',
  );
  final TextEditingController genderController = TextEditingController(
    text: 'Masculino',
  );
  final TextEditingController phoneNumberController = TextEditingController(
    text: '(+52) 5592717483',
  );
  final TextEditingController emailController = TextEditingController(
    text: 'juan@gmail.com',
  );
  final TextEditingController addresController = TextEditingController(
    text: 'Avenida Ceror de las Torres #25',
  );
  final TextEditingController nationalityController = TextEditingController(
    text: 'Mexicana',
  );
  @override
  void onInit() {
    super.onInit();
    const _DatosPersonalesModel datosPersonalesModel = _DatosPersonalesModel();
    change(datosPersonalesModel, status: RxStatus.success());
  }
  /* 
  @override
  void onReady() {
    super.onReady();
  } */

  /* @override
  void onClose() {
    super.onClose();
  } */
}
