import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/src/modules/profile/domain/entities/dtos/profile_dto.dart';

part 'academic_data_model.dart';

class DatosAcademicosController extends GetxController
    with StateMixin<_DatosAcademicosModel> {
  final TextEditingController titleCtrler = TextEditingController(
    text: '',
  );
  final TextEditingController cedulaCtrler = TextEditingController(
    text: '',
  );
  final TextEditingController specialtyCtrler = TextEditingController(
    text: '',
  );
  final TextEditingController subSpecialtyCtrler = TextEditingController(
    text: '',
  );
  final TextEditingController mainHospitalCtrler = TextEditingController(
    text: '',
  );

  DatosAcademicosDto data = DatosAcademicosDto.empty();
  ProfessionDto dataProfesion = ProfessionDto.empty();
  MainHospitalDto dataHospital = MainHospitalDto.empty();


  final AppStateController appState = Get.find<AppStateController>();
  UserModel get user => appState.user;

  @override
  void onInit() {
    super.onInit();
    change(const _DatosAcademicosModel(), status: RxStatus.loading());
    if (Get.arguments != null) {
      final args = Get.arguments as ProfileDto;
      data = args.datosAcademicos;
      dataProfesion = args.profession;
      dataHospital = args.mainHospital;
    }
    cedulaCtrler.text = data.cedula;
    titleCtrler.text = dataProfesion.name;
    specialtyCtrler.text = data.especialidad;
    subSpecialtyCtrler.text = data.subspecialty;
    mainHospitalCtrler.text = dataHospital.name;
    change(const _DatosAcademicosModel(), status: RxStatus.success());
  }

  @override
  void onClose() {
    titleCtrler.dispose();
    cedulaCtrler.dispose();
    specialtyCtrler.dispose();
    subSpecialtyCtrler.dispose();
    mainHospitalCtrler.dispose();
    super.onClose();
  }
}
