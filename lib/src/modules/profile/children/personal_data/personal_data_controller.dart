import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/src/modules/profile/domain/entities/dtos/profile_dto.dart';

part 'personal_data_model.dart';

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
  ProfileDto data = ProfileDto.empty();

  @override
  void onInit() {
    super.onInit();
    change(const _DatosPersonalesModel(), status: RxStatus.loading());

    if (Get.arguments != null) {
      data = Get.arguments as ProfileDto;
    }

    nameController.text = data.datosPersonales.nombre;
    birthdateController.text = getFecha(data.datosPersonales.fechaNacimiento);
    genderController.text = data.datosPersonales.genero.isNotEmpty ? 
    data.datosPersonales.genero == 'H' ? 'Masculino' : 'Femenino' : '';
    phoneNumberController.text = data.datosPersonales.telefono;
    emailController.text = data.datosPersonales.correo;
    addresController.text = _formatAddress(data.officeAddress);
    nationalityController.text = data.datosPersonales.nacionalidad;

    change(const _DatosPersonalesModel(), status: RxStatus.success());
  }

  @override
  void onClose() {
    nameController.dispose();
    birthdateController.dispose();
    genderController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    addresController.dispose();
    nationalityController.dispose();
    super.onClose();
  }

  String _formatAddress(OfficeAddressDto officeAddress) {
  final List<String> addressParts = [];

  if (officeAddress.roadName.isNotEmpty) {
    addressParts.add(officeAddress.roadName);
  }
  if (officeAddress.roadNumber.isNotEmpty) {
    addressParts.add(officeAddress.roadNumber);
  }
  if (officeAddress.municipalityName.isNotEmpty) {
    addressParts.add(officeAddress.municipalityName);
  }
  if (officeAddress.stateName.isNotEmpty) {
    addressParts.add(officeAddress.stateName);
  }
  if (officeAddress.countryCode.isNotEmpty) {
    addressParts.add(officeAddress.countryCode);
  }
  return addressParts.join(', ');
}

  String getFecha(String fecha) {
    try {
      final List<String> parts = fecha.split('/');

      if (parts.length != 3) {
        return fecha;
      }

      final String year = parts[2];
      final String month = parts[1];
      final String day = parts[0];
      return '$day-$month-$year';
    } on Exception catch (_) {
      return fecha;
    }
  }

  ///
}
