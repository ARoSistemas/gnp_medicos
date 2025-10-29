import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/threads/threads_service.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/add_user_page.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/domain/dtos/assistant_dto.dart';
import 'package:medicos/src/modules/profile/children/assistants/domain/remote/add_assistants_repository.dart';
import 'package:medicos/src/modules/profile/children/assistants/domain/remote/assistants_repository.dart';

part 'assistants_model.dart';

class AssistantsController extends GetxController
    with StateMixin<_AssistantsModel> {
  ///
  final ThreadsService threadsService = Get.find();
  final AssistantsRepository apiConn = Get.find();
  final AddAssistantsRepository apiConnAsis = Get.find();
  final AppStateController appState = Get.find();

  UserModel get user => appState.user;
  String get jwt => appState.user.token.jwt;

  final Rx<String?> selectedItemType = Rx<String?>(null);

  @override
  Future<void> onInit() async {
    super.onInit();
    await getAssistant(appState.user.codigoFiliacion);
  }

  /// Navigates to the [AddUserPage] to add a new assistant.
  /// After the [AddUserPage] is closed, it refreshes the assistant list
  /// by calling [getAssistant].
  Future<VoidCallback?> addAssistant() async {
    /// Add User
    await Get.toNamed(AddUserPage.page.name)!.then((_) async {
      /// when return update List
      await getAssistant(appState.user.codigoFiliacion);
    });
    return null;
  }

  /// Fetches the list of assistants for the given [affiliationCode].
  ///
  /// Updates the state to [RxStatus.loading] before fetching,
  /// then to [RxStatus.success] with the assistant list,
  /// [RxStatus.empty] if the list is empty,
  /// or [RxStatus.error] if an error occurs.
  Future<void> getAssistant(String affiliationCode) async {
    change(_AssistantsModel.empty(), status: RxStatus.loading());

    await threadsService.execute(
      func: () async {
        final List<AssistantDto> assistants = await apiConn.getAssistantList(
          affiliationCode,
          appState.user.token.jwt,
        );
        change(
          state!.copyWith(assistants: assistants),
          status: assistants.isNotEmpty ? RxStatus.success() : RxStatus.empty(),
        );
      },
      onError: () {
        change(
          _AssistantsModel.empty(),
          status: RxStatus.error(),
        );
      },
    );
  }

  /// Toggles the active status of the given [assistant].
  ///
  /// Updates the state to [RxStatus.loading] before making the API call.
  /// If the API call is successful,
  /// it refreshes the assistant list by calling [getAssistant].
  /// If the API call fails or an error occurs,
  /// it updates the state to [RxStatus.error].
  Future<void> onOffAssistant({required AssistantDto assistant}) async {
    change(_AssistantsModel.empty(), status: RxStatus.loading());
    await threadsService.execute(
      func: () async {
        final bool res = await apiConnAsis.onOffAssistant(
          idAssistant: assistant.idAsistente,
          affiliationCode: appState.user.codigoFiliacion,
          status: !assistant.activo,
          jwt: appState.user.token.jwt,
        );

        if (res) {
          await getAssistant(appState.user.codigoFiliacion);
        } else {
          change(_AssistantsModel.empty(), status: RxStatus.error());
        }
      },
      onError: () {
        change(_AssistantsModel.empty(), status: RxStatus.error());
      },
    );
  }
}
