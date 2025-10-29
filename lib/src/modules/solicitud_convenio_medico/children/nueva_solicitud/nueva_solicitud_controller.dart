import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/utils/validators.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/children/nueva_solicitud/domain/entities/especialidad_mdl.dart';

part 'nueva_solicitud_model.dart';

class NuevaSolicitudController extends GetxController
    with StateMixin<_NuevaSolicitudModel> {
  final AppStateController appState = Get.find<AppStateController>();
  UserModel get user => appState.user;

  TextEditingController nameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController rfcController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController officeAddressController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    const _NuevaSolicitudModel nuevaSolicitudModel = _NuevaSolicitudModel();
    loadDataSolicitud();
    change(nuevaSolicitudModel, status: RxStatus.success());
  }

  /* @override
  void onReady() {
    super.onReady();
  } */

  @override
  void onClose() {
    nameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    rfcController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    officeAddressController.dispose();
    super.onClose();
  }

  void loadDataSolicitud() {
    nameController.text = user.nombreCompleto;
    firstNameController.text = user.nombreCompleto;
    lastNameController.text = user.nombreCompleto;
    rfcController.text = user.rfc;
    emailController.text = user.email;
  }

  String? validaRfc(String? value) {
    final String? rfcError = Validators.validateRfc(value);
    if (rfcError != null) {
      return rfcError;
    }
    final String rfcConNombreError = Validators.validateRfcName(
      name: nameController.text,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      rfc: value!,
    );
    return rfcConNombreError;
  }
}
