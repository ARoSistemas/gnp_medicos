import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';

part 'profile_model.dart';

class ProfileController extends GetxController
    with StateMixin<ProfileModel>, GetSingleTickerProviderStateMixin {
  final RxInt selectedIndex = 0.obs;
  final Rx<String?> selectedItem = Rx<String?>(null);

  final AppStateController appState = Get.find();
  UserModel get user => appState.user;

  final RxBool enableAsisstant = true.obs;

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    enableAsisstant.value = user.banVerConvenio && appState.isDoctor;
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.onClose();
  }
}
