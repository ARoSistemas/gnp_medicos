import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/utils/exception_manager.dart';
import 'package:medicos/core/utils/logger.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/services/storage/user_storage.dart';
import 'package:medicos/src/modules/profile/domain/remote/profile_repository.dart';

part 'profile_model.dart';

class ProfileController extends GetxController
    with StateMixin<ProfileModel>, GetSingleTickerProviderStateMixin {
  final ProfileRepository apiConn = Get.find();

  final RxInt selectedIndex = 0.obs;
  final Rx<String?> selectedItem = Rx<String?>(null);

  final AppStateController appState = Get.find();
  final UserStorage userStorage = AppService.i.userStorage;

  UserModel get user => appState.user;
  UserModel? get userStored => userStorage.getUser();

  final RxBool enableAsisstant = true.obs;
  RxBool canCheckBiometrics = false.obs;

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();

  @override
  Future<void> onInit() async {
    super.onInit();
    change(null, status: RxStatus.loading());

    enableAsisstant.value = user.banConvenioVigente && appState.isDoctor;
    await checkBiometricsSupport();

    /// Fetch profile data
    await fetchProfile();
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.onClose();
  }

  Future<void> checkBiometricsSupport() async {
    if (!kIsWeb) {
      try {
        canCheckBiometrics.value = await auth.canCheckBiometrics;
      } on PlatformException catch (e) {
        logger.i('Error biometrics ${e.message}');
      }
    }
  }

  Future<void> activeBiometric({required bool value}) async {
    if (userStored != null) {
      final UserModel tmpUserStored = userStored!.copyWith(biometric: value);
      userStorage.saveUser(tmpUserStored);
      canCheckBiometrics.value = false;
      await checkBiometricsSupport();
    }
  }

  Future<void> fetchProfile() => appService.threads.execute(
    customExceptionMessages: {
      Exception(): ExceptionAlertProperties(
        message: 'Error al obtener el perfil. Inténtalo de nuevo más tarde',
      ),
    },
    func: () async {
      final Response<void> response = await apiConn.fetchProfile(
        user.uid,
        user.token.jwt,
      );
      if (response.status.hasError) {
        change(null, status: RxStatus.error('Error ${response.statusCode}'));
      } else {
        change(null, status: RxStatus.success());
      }
    },
    onError: () {
      change(null, status: RxStatus.error('Error al obtener el perfil'));
    },
  );
}
