import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/src/modules/directorio/domain/entities/items_directory_mdl.dart';

part 'directorio_model.dart';

class DirectorioController extends GetxController
    with StateMixin<_DirectorioModel> {
  final AppStateController appState = Get.find<AppStateController>();
  UserModel get user => appState.user;
  String get jwt => appState.user.token.jwt;

  final List<ItemsDirectoryMdl> items = [
    ItemsDirectoryMdl(
      title: 'Médicos',
      subtitle: 'Médicos',
      idPage: 'medicos',
    ),
    ItemsDirectoryMdl(
      title: 'Hospitales',
      subtitle: 'Hospitales en convenio',
      idPage: 'hospitales',
    ),
    ItemsDirectoryMdl(
      title: 'Clínicas',
      subtitle: 'Clínicas en convenio',
      idPage: 'clinicas',
    ),
    ItemsDirectoryMdl(
      title: 'Otros servicios de salud',
      subtitle: 'Otros servicios de salud',
      idPage: 'otros_servicios',
    ),

    ItemsDirectoryMdl(
      title: 'Módulos GNP',
      subtitle: 'Módulos GNP',
      idPage: 'modulos_gnp',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    const _DirectorioModel directorioModel = _DirectorioModel();
    change(directorioModel, status: RxStatus.success());
  }
}
