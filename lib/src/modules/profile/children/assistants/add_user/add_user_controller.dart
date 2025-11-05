import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medicos/core/extensions/null_extensions.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/services/threads/threads_service.dart';
import 'package:medicos/core/utils/exception_manager.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/models/incoming/tipos_assistant_model.dart';
import 'package:medicos/shared/services/alerts/notification_service.dart';
import 'package:medicos/shared/widgets/custom_notification.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/domain/dtos/assistant_dto.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/domain/dtos/permissions_dto.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/domain/dtos/register_assistant_dto.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/domain/entities/assistant_update_model.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/domain/repository/add_user_repository.dart';

part 'add_user_model.dart';

class AddUserController extends GetxController
    with StateMixin<_AddUserModel>, GetSingleTickerProviderStateMixin {
  final ThreadsService threadsService = Get.find();
  final AddUserRepository apiConn = Get.find();
  final AppStateController appState = Get.find();
  final NotificationServiceImpl _notification = AppService.i.notifications;

  AssistantDto assistant = AssistantDto.empty();

  UserModel get user => appState.user;
  String get jwt => appState.user.token.jwt;
  String get getcodeFiliciacion => appState.user.codigoFiliacion;

  RxBool isNewUser = true.obs;
  RxBool registerActive = false.obs;
  RxInt selectedIndex = 0.obs;
  Rxn<DateTime> selectedDate = Rxn<DateTime>();

  List<PermissionsDto> permissions = [];

  final Rx<String?> selectedItem = Rx<String?>(null);
  final Rx<String?> selectedItemType = Rx<String?>(null);
  final RxList<String> permisosSeleccionadosIds = <String>[].obs;
  final Rx<String> idAsisstant = ''.obs;
  final RxInt currentTab = 0.obs;

  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController secondLastNameController =
      TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
  Future<void> onInit() async {
    super.onInit();

    change(
      _AddUserModel.empty(),
      status: RxStatus.loading(),
    );

    final Map<String, dynamic> getArguments =
        Get.arguments as Map<String, dynamic>? ?? {};

    if (getArguments['actualiza'] != null) {
      isNewUser.value = false;
      assistant = getArguments['assistant'] ?? AssistantDto.empty();
    }

    /// Get List Type assistant
    final List<TiposAsistentesModel> assistanTypeList =
        await getTypeAssistants();

    /// set assistant type
    await selectTypeAssistant(assistant.idTipoAsistente);

    if (!isNewUser.value) {
      registerActive.value = true;
      nameController.text = assistant.nombre.value().trim();
      lastNameController.text = assistant.apellidoPaterno.value().trim();
      secondLastNameController.text = assistant.apellidoMaterno.value().trim();
      emailController.text = assistant.email.value().trim();
      phoneNumberController.text = assistant.telefono.value().trim();
      birthdateController.text = dateFormat(
        date: assistant.fechaNacimiento,
        isInput: true,
      );

      final bool hasPermissions = await getPermissions(assistant.idAsistente);
      if (!hasPermissions) {
        change(null, status: RxStatus.error());
        return;
      }
    }

    /// Update view
    change(
      _AddUserModel.empty().copyWith(assistanTypeList: assistanTypeList),
      status: RxStatus.success(),
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    lastNameController.dispose();
    secondLastNameController.dispose();
    birthdateController.dispose();
    genderController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    super.onClose();
  }

  void changeTab(int index) {
    if (!isNewUser.value) {
      if (selectedIndex.value != index) {
        selectedIndex.value = index;
      }
    }
  }

  String dateFormat({required String date, required bool isInput}) {
    final DateFormat formatIn = DateFormat(
      isInput ? 'yyyy-MM-dd' : 'dd/MM/yyyy',
    );
    final DateFormat formatOut = DateFormat(
      isInput ? 'dd/MM/yyyy' : 'yyyy-MM-dd',
    );
    final DateTime fechaObjeto = formatIn.parse(date);
    return formatOut.format(fechaObjeto);
  }

  // String dateFormatEntrada(String date) {
  //   final DateFormat formatoEntrada = DateFormat('yyyy-MM-dd');
  //   final DateFormat formatoSalida = DateFormat('dd/MM/yyyy');
  //   final DateTime fechaObjeto = formatoEntrada.parse(date);
  //   return formatoSalida.format(fechaObjeto);
  // }

  // String dateFormatSalida(String date) {
  //   final DateFormat formatoEntrada = DateFormat('dd/MM/yyyy');
  //   final DateFormat formatoSalida = DateFormat('yyyy-MM-dd');
  //   final DateTime fechaObjeto = formatoEntrada.parse(date);
  //   return formatoSalida.format(fechaObjeto);
  // }

  Future<void> selectDateCalendar(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime maxDate = DateTime(now.year - 18, now.month, now.day);
    final DateTime minDate = DateTime(now.year - 60, now.month, now.day);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? maxDate,
      firstDate: minDate,
      lastDate: maxDate,
      confirmText: 'Aceptar'
    );

    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
      final String formattedDate = DateFormat(
        'dd/MM/yyyy',
      ).format(selectedDate.value!);
      birthdateController.text = formattedDate;
    }
  }

  Future<void> selectTypeAssistant(String? newValue) async =>
      selectedItemType.value = newValue;

  Future<List<TiposAsistentesModel>> getTypeAssistants() async {
    List<TiposAsistentesModel> ret = [];

    await threadsService.execute(
      func: () async {
        final Response<List<TiposAsistentesModel>> res = await apiConn
            .getTypeAssistants(appState.user.token.jwt);
        ret = res.body ?? [];
      },
    );
    return ret;
  }

  Future<void> validForm() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (!isNewUser.value) {
      selectedIndex.value = 1;
    } else {
      await registerService();
    }
  }

  Future<String> registerService() async {
    change(state, status: RxStatus.loading());
    String newAssistantId = '';
    await threadsService.execute(
      func: () async {
        final Response<String> res = await apiConn.registerAssistants(
          RegisterAssistantModel(
            idTipoAsistente: selectedItemType.value.value(),
            codigoFiliacionMedico: appState.user.codigoFiliacion,
            asistente: AssistantDto(
              nombre: nameController.text,
              apellidoPaterno: lastNameController.text,
              apellidoMaterno: secondLastNameController.text,
              fechaNacimiento: dateFormat(
                date: birthdateController.text,
                isInput: false,
              ),
              telefono: phoneNumberController.text,
              email: emailController.text,
              activo: true,
              cveLada: '',
              idAsistente: '',
              idTipoAsistente: selectedItemType.value.toString(),
              nombreTipoAsistente: '',
            ),
          ),
          appState.user.token.jwt,
        );
        newAssistantId = res.body ?? '';

        _notification.show(
          title: 'Registro de Asistentes',
          message: 'El asistente $newAssistantId fue registrado',
          type: newAssistantId.isEmpty ? AlertType.error : AlertType.success,
        );

        if (newAssistantId.isNotEmpty) {
          registerActive.value = true;
          idAsisstant.value = newAssistantId;
          await getPermissions(newAssistantId);
          selectedIndex.value = 1;
        }
      },
    );

    change(state, status: RxStatus.success());
    return newAssistantId;
  }

  Future<void> updateAssistant() async {
    await threadsService.execute(
      func: () async {
        final Response<AssistantDto> res = await apiConn.updateAssistant(
          idAssistant: assistant.idAsistente,
          updateAssistantModel: AssistantUpdateModel(
            nombre: nameController.text,
            apellidoPaterno: lastNameController.text,
            apellidoMaterno: secondLastNameController.text,
            fechaNacimiento: dateFormat(
              date: birthdateController.text,
              isInput: false,
            ),
            cveLada: phoneNumberController.text.substring(0, 3),
            telefono: phoneNumberController.text,
            activo: assistant.activo,
            idTipoAsistente: assistant.idTipoAsistente,
          ),
          jwt: appState.user.token.jwt,
        );

        if (res.statusCode! >= 200) {
          _notification.show(
            message: 'El asistente se actualizo',
            type: AlertType.success,
          );
        }
      },
      customExceptionMessages: {
        Exception(): ExceptionAlertProperties(
          message: 'El asistente no se actualizó',
        ),
      },
    );
  }

  Future<bool> getPermissions(String idAssistant) async {
    bool ret = false;
    await threadsService.execute(
      func: () async {
        final Response<List<PermissionsDto>> res = await apiConn.getPermissions(
          idAssistant,
          getcodeFiliciacion,
          appState.user.token.jwt,
        );
        permissions = res.body ?? [];

        if (permissions.isNotEmpty) {
          permisosSeleccionadosIds.clear();
          for (final PermissionsDto permiso in permissions) {
            if (permiso.activo) {
              permisosSeleccionadosIds.add(permiso.id);
            }
            for (final PermissionsDto submodulo in permiso.submodulos) {
              if (submodulo.activo) {
                permisosSeleccionadosIds.add(submodulo.id);
              }
            }
          }
        }
        ret = permissions.isNotEmpty;
      },
    );
    return ret;
  }

  void updatePermission(String idPermiso, {bool isSelected = false}) {
    if (isSelected) {
      if (!permisosSeleccionadosIds.contains(idPermiso)) {
        permisosSeleccionadosIds.add(idPermiso);
      }
    } else {
      permisosSeleccionadosIds.remove(idPermiso);
    }
  }

  Future<void> saveUserComplete() async {
    change(null, status: RxStatus.loading());
    await threadsService.execute(
      func: () async {
        if (isNewUser.value) {
          if (idAsisstant.value.isNotEmpty) {
            await apiConn.updateAssistantsPermissions(
              idAssistant: idAsisstant.value,
              affiliationCode: getcodeFiliciacion,
              permissions: permisosSeleccionadosIds,
              jwt: appState.user.token.jwt,
            );
          }
        } else {
          await updateAssistant();
          await apiConn.updateAssistantsPermissions(
            idAssistant: assistant.idAsistente,
            affiliationCode: getcodeFiliciacion,
            permissions: permisosSeleccionadosIds,
            jwt: appState.user.token.jwt,
          );
        }

        _notification.show(
          message: 'Los permisos se guardaron.',
          type: AlertType.success,
        );
      },
      customExceptionMessages: {
        Exception(): ExceptionAlertProperties(
          message: 'Error al actualizar los permisos del asistente',
        ),
      },
    );
    Get.back();
  }
}
