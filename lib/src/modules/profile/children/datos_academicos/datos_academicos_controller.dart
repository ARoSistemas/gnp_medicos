import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';

part 'datos_academicos_model.dart';

class DatosAcademicosController extends GetxController
    with StateMixin<_DatosAcademicosModel> {
  final TextEditingController titleController = TextEditingController(
    text: 'tituloXXXXXXX',
  );
  final TextEditingController idController = TextEditingController(
    text: 'cedulaXXXXXX',
  );
  final TextEditingController specialtyController = TextEditingController(
    text: 'Medico Cirujano',
  );
  final TextEditingController subSpecialtyController = TextEditingController(
    text: 'Oftalmología',
  );
  final TextEditingController mainHospitalController = TextEditingController(
    text: 'Hospital las torres',
  );

  final AppStateController appState = Get.find<AppStateController>();
  UserModel get user => appState.user;

  @override
  void onInit() {
    super.onInit();
    const _DatosAcademicosModel datosAcademicosModel = _DatosAcademicosModel();
    change(datosAcademicosModel, status: RxStatus.success());
  }

  /* @override
  void onReady() {
    super.onReady();
  } */

  /* @override
  void onClose() {
    super.onClose();
  } */
}
