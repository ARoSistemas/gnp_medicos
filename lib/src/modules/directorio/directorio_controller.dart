import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/utils/exception_manager.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/src/modules/directorio/children/filter_page/domain/entities/models/estado_mdl.dart';
import 'package:medicos/src/modules/directorio/domain/entities/items_directory_mdl.dart';
import 'package:medicos/src/modules/directorio/domain/repository/directory_repository.dart';

part 'directorio_model.dart';

class DirectorioController extends GetxController
    with StateMixin<_DirectorioModel> {
  final AppStateController appState = Get.find();
  final DirectoryRepository _apiCon = Get.find();

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

  /// Items in the directory
  final List<ItemDirectoryMdl> items = [
    ItemDirectoryMdl(
      title: msg.medico.pValue!,
      subtitle: '${msg.medico.pValue!} ${msg.enconvenio.value}',
      idPage: 'medicos',
      img: 'icono_modulo_directorio_doctores.png',
    ),

    ItemDirectoryMdl(
      title: msg.hospital.pValue!,
      subtitle: '${msg.hospital.pValue!} ${msg.enconvenio.value}',
      idPage: 'hospitales',
      img: 'icono_modulo_directorio_hospitales.png',
    ),

    ItemDirectoryMdl(
      title: msg.clinica.pValue!,
      subtitle: '${msg.clinica.pValue!} ${msg.enconvenio.value}',
      idPage: 'clinicas',
      img: 'icono_modulo_directorio_clinicas.png',
    ),

    ItemDirectoryMdl(
      title: msg.otrosServicios.value,
      subtitle: msg.otrosServicios.value,
      idPage: 'otros_servicios',
      img: 'icono_modulo_directorio_otros.png',
    ),
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    change(state, status: RxStatus.loading());
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
      final Response<List<EstadoMdl>> hasData = await _apiCon.fetchEstados();

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
