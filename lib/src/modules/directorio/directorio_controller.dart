import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/utils/exception_manager.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/src/modules/directorio/children/filter_page/domain/entities/models/estado_mdl.dart';
import 'package:medicos/src/modules/directorio/domain/entities/items_directory_mdl.dart';
import 'package:medicos/src/modules/directorio/domain/repository/directory_repository.dart';

part 'directorio_model.dart';

class DirectorioController extends GetxController
    with StateMixin<_DirectorioModel> {
  final AppStateController appState = Get.find<AppStateController>();

  final DirectoryRepository _directoryRepo = Get.find();

  UserModel get user => appState.user;
  String get jwt => appState.user.token.jwt;

  /// Catalogs
  /// Catalog for specialties
  List<Map<String, dynamic>> catEspecialidades = [];

  /// Catalog for medical circles
  List<Map<String, dynamic>> catCirculos = [];

  /// Catalog for states
  List<Map<String, dynamic>> catEstados = [];

  /// Catalog for hospital plans
  List<Map<String, dynamic>> catPlanHospitalario = [];

  /// Catalog for clinics
  List<Map<String, dynamic>> catClinicas = [];

  /// Catalog for other services
  List<Map<String, dynamic>> catOtrosServicios = [];

  final List<ItemDirectoryMdl> items = [
    ItemDirectoryMdl(
      title: 'Médicos',
      subtitle: 'Médicos en convenio',
      idPage: 'medicos',
      img: 'assets/dir_doctores.png',
    ),
    ItemDirectoryMdl(
      title: 'Hospitales',
      subtitle: 'Hospitales en convenio',
      idPage: 'hospitales',
      img: 'assets/dir_hospitales.png',
    ),
    ItemDirectoryMdl(
      title: 'Clínicas',
      subtitle: 'Clínicas en convenio',
      idPage: 'clinicas',
      img: 'assets/dir_clinicas.png',
    ),
    ItemDirectoryMdl(
      title: 'Otros servicios de salud',
      subtitle: 'Otros servicios de salud en convenio',
      idPage: 'otros_servicios',
      img: 'assets/dir_otrosServiciosSalud.png',
    ),
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    change(null, status: RxStatus.loading());

    await _loadEstados().then((value) {
      if (value) {
        change(const _DirectorioModel(), status: RxStatus.success());
      } else {
        change(
          null,
          status: RxStatus.error(
            'Error al cargar los estados. Inténtalo de nuevo más tarde',
          ),
        );
      }
    });
  }

  /// We obtain the data for the states
  Future<bool> _loadEstados() => appService.threads.execute(
    customExceptionMessages: {
      Exception(): ExceptionAlertProperties(
        message: 'Error al obtener estados. Inténtalo de nuevo más tarde',
      ),
    },
    func: () async {
      /// We obtain the data for the states
      final Response<List<EstadoMdl>> hasData = await _directoryRepo
          .fetchEstados();

      /// We save the temporary list
      final List<EstadoMdl> tmpData = hasData.body!;

      /// We build the list of states
      catEstados = [
        {'claveEstado': '0', 'estado': 'Todos'},
        ...tmpData.map(
          (e) => {
            'claveEstado': e.claveEstado,
            'estado': e.estado,
          },
        ),
      ];
    },
  );
}
