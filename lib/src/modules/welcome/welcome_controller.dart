import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/domain/dtos/permissions_dto.dart';

part 'welcome_model.dart';

class WelcomeController extends GetxController with StateMixin<_WelcomeModel> {
  final AppStateController appState = Get.find();
  String get jwt => appState.user.token.jwt;
  UserModel get user => appState.user;

  Map<String, dynamic> permisosMap = {};

  @override
  void onInit() {
    super.onInit();

    if (appState.isDoctor) {
      permisosMap = {
        '/convenio-medico': true,
        '/tabuladores': true,
        '/mis-pagos': true,
        '/solicitar-convenio': true,
        '/mis-tramites': true,
        '/beneficios': true,
        '/anexos': true,
        '/formatos': true,
        '/evaluaciones': true,
        '/directorio-medico': true,
        '/contacto': true,
      };
    } else {
      permisosMap = {
        for (final PermissionsDto p in appState.user.permisos) p.id: p.activo,
      };
    }

    const _WelcomeModel welcomeModel = _WelcomeModel();
    change(welcomeModel, status: RxStatus.success());
  }

  /*   @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  } */
}
