import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/null_extensions.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/services/threads/threads_service.dart';
import 'package:medicos/shared/constans/constans.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/services/alerts/notification_service.dart';
import 'package:medicos/shared/utils/validators.dart';
import 'package:medicos/shared/widgets/custom_notification.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/children/nueva_solicitud/domain/dtos/agreement_registration_dto.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/children/nueva_solicitud/domain/entities/catalog_convenio_mdl.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/children/nueva_solicitud/domain/repositories/solicitud_convenio_medico_repository.dart';

part 'nueva_solicitud_model.dart';

class NuevaSolicitudController extends GetxController
    with StateMixin<_NuevaSolicitudModel> {
  final ThreadsService threadsService = Get.find();
  final SolicitudConvenioMedicoRepository apiConn = Get.find();
  final AppStateController appState = Get.find();
  final NotificationServiceImpl _notification = AppService.i.notifications;

  UserModel get user => appState.user;
  RxBool isLoading = false.obs;
  List<CatalogConvenioModel> specialtyCatalog = [];
  List<CatalogConvenioModel> subSpecialtyCatalog = [];
  List<CatalogConvenioModel> stateCatalog = [];
  List<CatalogConvenioModel> hospitalAttentionCatalog = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController secondLastNameController = TextEditingController();
  TextEditingController rfcController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController officeAddressController = TextEditingController();

  final Rx<String?> selectedSpecialty = Rx<String?>(null);
  final Rx<String?> selectedSubSpecialty = Rx<String?>(null);
  final Rx<String?> selectedState = Rx<String?>(null);
  final RxList<String> selectedHospitals = <String>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    loadDataSolicitud();
    await loadAllCatalogs();
  }

  /* @override
  void onReady() {
    super.onReady();
  } */

  @override
  void onClose() {
    nameController.dispose();
    lastNameController.dispose();
    secondLastNameController.dispose();
    rfcController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    officeAddressController.dispose();
    super.onClose();
  }

  void loadDataSolicitud() {
    nameController.text = user.nombre;
    lastNameController.text = user.apePaterno;
    secondLastNameController.text = user.apeMaterno;
    rfcController.text = user.rfc;
    emailController.text = user.email;
  }

  String? validaRfc(String? value) {
    final String? rfcError = Validators.rfc(value);
    if (rfcError != null) {
      return rfcError;
    }
    final String? rfcConNombreError = Validators.rfcName(
      name: nameController.text,
      lastName: lastNameController.text,
      secondLastName: secondLastNameController.text,
      rfc: value.value(),
    );
    return rfcConNombreError;
  }

  Future<void> onSpecialtyChanged(String? value) async {
    selectedSpecialty.value = value;
  }

  Future<void> onSubSpecialtyChanged(String? value) async {
    selectedSubSpecialty.value = value;
  }

  Future<void> onStateChanged(String? value) async {
    selectedState.value = value;
  }

  void onHospitalSelectionChanged(String hospitalId, {bool selected = false}) {
    if (selected) {
      if (!selectedHospitals.contains(hospitalId)) {
        selectedHospitals.add(hospitalId);
      }
    } else {
      selectedHospitals.remove(hospitalId);
    }
  }

  String get selectedHospitalNames {
    if (selectedHospitals.isEmpty || state == null) {
      return '';
    }
    return selectedHospitals
        .map((id) {
          final CatalogConvenioModel hospital = state!.hospitalAttention
              .firstWhere(
                (h) => h.clave == id,
              );
          return hospital.descripcion;
        })
        .join(', ');
  }

  Future<void> loadAllCatalogs() async {
    change(null, status: RxStatus.loading());

    await Future.wait([
      getSpecialty(),
      getSubSpecialty(),
      getState(),
      getHospitalAttention(),
    ]);

    change(
      _NuevaSolicitudModel.empty().copyWith(
        specialties: specialtyCatalog,
        subSpecialties: subSpecialtyCatalog,
        states: stateCatalog,
        hospitalAttention: hospitalAttentionCatalog,
      ),
      status: RxStatus.success(),
    );
  }

  Future<void> getSpecialty() async {
    await threadsService.execute(
      func: () async {
        specialtyCatalog = await apiConn.getSpecialty(
          appState.user.token.jwt,
        );
      },
      onError: () {
        throw Exception('Error al cargar especialidades');
      },
    );
  }

  Future<void> getSubSpecialty() async {
    await threadsService.execute(
      func: () async {
        subSpecialtyCatalog = await apiConn.getSubspecialty(
          appState.user.token.jwt,
        );
      },
      onError: () {
        throw Exception('Error al cargar sub-especialidades');
      },
    );
  }

  Future<void> getState() async {
    await threadsService.execute(
      func: () async {
        stateCatalog = await apiConn.getState(
          appState.user.token.jwt,
        );
      },
      onError: () {
        throw Exception('Error al cargar estados');
      },
    );
  }

  Future<void> getHospitalAttention() async {
    await threadsService.execute(
      func: () async {
        hospitalAttentionCatalog = await apiConn.getHopitalAttention(
          appState.user.token.jwt,
        );
      },
      onError: () {
        throw Exception('Error al cargar hospitales');
      },
    );
  }

  Future<String> newRequestAgreegament() async {
    change(state, status: RxStatus.loading());
    await threadsService.execute(
      func: () async {
        final Response<String> res = await apiConn.newRequestAgreegament(
          AgreementRegistration(
            nombreMedico: nameController.text,
            apellidoPaterno: lastNameController.text,
            apellidoMaterno: secondLastNameController.text,
            cveEspecialidad: selectedSpecialty.value.value(),
            cveSubespecialidad: selectedSubSpecialty.value.value(),
            numeroTelefonoDirecto: phoneNumberController.text,
            direccionConsultorioMedico: officeAddressController.text,
            cvesHospitalesAtencion: selectedHospitals.map(int.parse).toList(),
            cveEstatus: statusRequestConvenio,
            correo: emailController.text,
            rfc: rfcController.text,
            cveEstado: selectedState.value.value(),
            codigoAfiliacion: appState.user.codigoFiliacion,
            uid: appState.user.token.jwtLogin.uid,
          ),
          appState.user.token.jwt,
        );

        _notification.show(
          title: 'Registro de Asistentes',
          message: res.bodyString!.isEmpty
              ? 'La solciitud no fue registrada.'
              : 'La solicitud fue registrada.',
          type: res.bodyString!.isEmpty ? AlertType.error : AlertType.success,
        );
      },
    );
    
    change(state, status: RxStatus.success());
    Get.back();
    return '';
  }
}
