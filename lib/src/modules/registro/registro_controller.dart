import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/services/threads/threads_service.dart';
import 'package:medicos/shared/services/alerts/notification_service.dart';
import 'package:medicos/shared/utils/validators.dart';
import 'package:medicos/shared/widgets/custom_notification.dart';
import 'package:medicos/src/modules/registro/domain/remote/registro_repository.dart';

part 'registro_model.dart';

class RegistroController extends GetxController
    with StateMixin<_RegistroModel>, GetSingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();

  final ThreadsService threadsService = Get.find();
  final RegistroRepository _authService = Get.find();
  final NotificationServiceImpl _notification = AppService.i.notifications;
  late TabController tabController;
  RxInt selectedIndex = 0.obs;

  final Rx<String?> selectedItem = Rx<String?>(null);

  final TextEditingController nameCtler = TextEditingController();
  final TextEditingController lastNameCtler = TextEditingController();
  final TextEditingController secondLastNameCtler = TextEditingController();
  final TextEditingController emailCtler = TextEditingController();
  final TextEditingController phoneNumberCtler = TextEditingController();
  final TextEditingController rfcCtler = TextEditingController();
  final TextEditingController cedulaCtler = TextEditingController();
  final TextEditingController passwordCtler = TextEditingController();
  final TextEditingController passwordConfirmCtler = TextEditingController();

  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  RxBool isLoading = false.obs;

  final List tabs = ['Contacto']; //'Seguridad'

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
    tabController = TabController(length: 1, vsync: this);
    tabController.addListener(() {
      selectedIndex.value = tabController.index;
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future<void> registerService() async {
    if (!formKey.currentState!.validate()) {
      _notification.show(
        title: 'Atención',
        message: 'Favor de validar la información ingresada.',
        type: AlertType.warning,
      );
      return;
    }

    isLoading.value = true;
    FocusScope.of(Get.context!).unfocus();
    bool res = false;

    await threadsService.execute(
      func: () async {
        res = await _authService.registerService({
          'nombre': nameCtler.text.trim(),
          'paterno': lastNameCtler.text.trim(),
          'materno': secondLastNameCtler.text.trim(),
          'telefono': phoneNumberCtler.text.trim(),
          'rfc': rfcCtler.text.trim(),
          'mail': emailCtler.text.trim(),
          'password': passwordCtler.text.trim(),
        });
      },
    );

    _notification.show(
      title: res ? 'Éxito' : 'Error',
      message: res ? 'Registro exitoso.' : 'Credenciales inválidas.',
      type: res ? AlertType.success : AlertType.error,
    );

    if (res) {
      Get.back();
    }
    isLoading.value = false;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void nextTab() {
    tabController.animateTo(1);
  }

  String? validaRfc(String? value) {
    final String? rfcError = Validators.rfc(value);

    if (rfcError != null) {
      return rfcError;
    }
    final String? rfcConNombreError = Validators.rfcName(
      name: nameCtler.text,
      lastName: lastNameCtler.text,
      secondLastName: secondLastNameCtler.text,
      rfc: value ?? '',
    );

    return rfcConNombreError;
  }
}
