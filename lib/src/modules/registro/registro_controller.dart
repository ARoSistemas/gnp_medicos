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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController rfcController = TextEditingController();
  final TextEditingController cedulaController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

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
      return;
    }

    isLoading.value = true;
    FocusScope.of(Get.context!).unfocus();
    bool res = false;

    await threadsService.execute(
      func: () async {
        res = await _authService.registerService({
          'nombre': nameController.text.trim(),
          'paterno': firstNameController.text.trim(),
          'materno': lastNameController.text.trim(),
          'telefono': phoneNumberController.text.trim(),
          'rfc': rfcController.text.trim(),
          'mail': emailController.text.trim(),
          'password': passwordController.text.trim(),
        });
      },
    );

    _notification.show(
      title: '',
      message: res ? 'Registro exitoso' : 'Error en el registro',
      type: res ? AlertType.success : AlertType.error,
    );

    Get.back();
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

  String validaRfc(String? value) {
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
