import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/utils/exception_manager.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/src/modules/directorio/children/filter_page/domain/entities/models/circulo_medico_mdl.dart';
import 'package:medicos/src/modules/directorio/children/filter_page/domain/entities/models/clinica_mdl.dart';
import 'package:medicos/src/modules/directorio/children/filter_page/domain/entities/models/especialidad_mdl.dart';
import 'package:medicos/src/modules/directorio/children/filter_page/domain/entities/models/municipio_mdl.dart';
import 'package:medicos/src/modules/directorio/children/filter_page/domain/entities/models/otro_servicio_mdl.dart';
import 'package:medicos/src/modules/directorio/children/filter_page/domain/entities/models/plan_hospitalario_mdl.dart';
import 'package:medicos/src/modules/directorio/children/filter_page/domain/repositories/filterpage_repository.dart';
import 'package:medicos/src/modules/directorio/children/filter_results/filter_results_page.dart';
import 'package:medicos/src/modules/directorio/domain/entities/filter_directory_mdl.dart';
import 'package:medicos/src/modules/directorio/domain/entities/items_directory_mdl.dart';

part 'filterpage_model.dart';

class FilterPageController extends GetxController
    with StateMixin<_FilterPageModel>, WidgetsBindingObserver {
  final AppStateController appState = Get.find();
  final FilterPageRepository _apiConn = Get.find();

  UserModel get user => appState.user;

  ItemDirectoryMdl itemSelected = ItemDirectoryMdl.empty();

  ///* Elements of the search *///

  /// Keyboard visible flag
  bool _isKeyboardVisible = false;

  /// Show search dropdown
  RxBool showSearchDropdown = false.obs;

  /// Filtered list for search
  RxList<Map<String, dynamic>> listFiltered = <Map<String, dynamic>>[].obs;

  /// Complete list for search
  List<Map<String, dynamic>> _itemsToSearch = [];

  /// Controllers and focus nodes
  final TextEditingController searchCtrler = TextEditingController();

  /// Focus node for the search input
  final FocusNode fnInputSearch = FocusNode();

  /// Hint text for the search input
  String hintTextSearch = '';

  /// Key for the search
  final RxString keyToSearch = ''.obs;

  ///* End elements of the search *///
  ///
  ///* Elements of the filter dropdowns *///

  /// Catalog for specialties
  List<Map<String, dynamic>> catEspecialidades = [];

  /// Selected specialty
  RxMap<String, dynamic> especialidadSelected = <String, dynamic>{}.obs;

  /// Catalog for hospital plans
  List<Map<String, dynamic>> catPlanHospitalario = [];

  /// Selected hospital plan
  RxMap<String, dynamic> planHospitalarioSelected = <String, dynamic>{}.obs;

  /// Catalog for clinics
  List<Map<String, dynamic>> catClinicas = [];

  /// Selected clinic
  RxMap<String, dynamic> clinicasSelected = <String, dynamic>{}.obs;

  /// Catalog for other services
  List<Map<String, dynamic>> catOtrosServicios = [];

  /// Selected other service
  RxMap<String, dynamic> otrosServiciosSelected = <String, dynamic>{}.obs;

  /// Catalog for medical circles
  List<Map<String, dynamic>> catCirculos = [];

  /// Selected medical circle
  RxMap<String, dynamic> circuloSelected = <String, dynamic>{}.obs;

  /// Catalog for states
  List<Map<String, dynamic>> catEstados = [];

  /// Selected state
  RxMap<String, dynamic> itemSelectedEstado = <String, dynamic>{}.obs;

  /// Catalog for municipalities
  List<Map<String, dynamic>> catMunicipios = [];

  /// Selected municipality
  RxMap<String, dynamic> municipiosSelected = <String, dynamic>{}.obs;

  /// Controller for the input search by general
  final TextEditingController searchByCtrler = TextEditingController();

  /// Hint text for the search input
  String titleSearchby = '';

  /// Label text for the search input
  String labelSearchby = '';

  @override
  Future<void> onInit() async {
    super.onInit();

    /// We receive the search type if nothing comes, it is assumed doctors
    final item = Get.arguments as Map<String, dynamic>;
    itemSelected = item['item'] as ItemDirectoryMdl;

    /// We receive the catalogs
    catEspecialidades = item['catEspecialidades'] as List<Map<String, dynamic>>;
    catCirculos = item['catCirculos'] as List<Map<String, dynamic>>;
    catPlanHospitalario =
        item['catPlanHospitalario'] as List<Map<String, dynamic>>;
    catClinicas = item['catClinicas'] as List<Map<String, dynamic>>;
    catOtrosServicios = item['catOtrosServicios'] as List<Map<String, dynamic>>;
    catEstados = item['catEstados'] as List<Map<String, dynamic>>;

    /// Register the observer to detect changes in the keyboard.
    WidgetsBinding.instance.addObserver(this);

    /// We set the initial values according to the search type
    await setTypeSearch(itemSelected);

    /// Once the initial values are configured
    /// we add the necessary listeners and continue loading

    /// Listener for the search input
    searchCtrler.addListener(() {
      _filterSearch(key: keyToSearch.value);
    });

    /// Listener for the focus of the search input
    fnInputSearch.addListener(() {
      showSearchDropdown.value = fnInputSearch.hasFocus;
      if (!fnInputSearch.hasFocus) {
        resetSearch();
      }
    });
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    searchCtrler.dispose();
    fnInputSearch.dispose();
    searchByCtrler.dispose();
    super.onClose();
  }

  @override
  void didChangeMetrics() {
    final double bottomInset = WidgetsBinding
        .instance
        .platformDispatcher
        .views
        .first
        .viewInsets
        .bottom;

    final bool isKeyboardCurrentlyVisible = bottomInset > 0;

    if (_isKeyboardVisible &&
        !isKeyboardCurrentlyVisible &&
        fnInputSearch.hasFocus) {
      searchCtrler.text = 'Andres';
      fnInputSearch.unfocus();
    }

    /// update the keyboard visibility flag
    _isKeyboardVisible = isKeyboardCurrentlyVisible;
  }

  /// Filters the search list
  void _filterSearch({required String key}) {
    final String query = searchCtrler.text.toLowerCase();
    listFiltered.value = _itemsToSearch.where((item) {
      final String toSeek = (item[key] as String?)?.toLowerCase() ?? '';
      return toSeek.contains(query.toLowerCase());
    }).toList();
  }

  /// Resets the search
  void resetSearch() {
    listFiltered.value = _itemsToSearch;
    searchCtrler.clear();
    showSearchDropdown.value = false;
  }

  /// We set the initial values according to the search type
  Future<void> setTypeSearch(ItemDirectoryMdl itemSelected) async {
    /// The error message are in every case on each fetch function
    await appService.threads.execute(
      func: () async {
        /// flag to validadte if loading was ok
        bool isLoadinOk = false;

        /// We load the data according to the search type
        switch (itemSelected.idPage) {
          case 'medicos':
            isLoadinOk = await fetchDataCirculos();
            isLoadinOk = await fetchDataEspecialidades();

          case 'hospitales':
            isLoadinOk = await fetchDataPlanHospitalario();

          case 'clinicas':
            isLoadinOk = await fetchDataClinicas();

          case 'otros_servicios':
            isLoadinOk = await fetchDataOtrosServicios();

          default:
        }

        if (isLoadinOk) {
          /// We set the initial values for the search
          itemSelectedEstado.value = catEstados.first;
        }

        if (isLoadinOk) {
          /// Finally, we indicate that the loading was successful
          change(
            _FilterPageModel(
              name: itemSelected.subtitle,
              itemSelected: itemSelected.idPage,
            ),
            status: RxStatus.success(),
          );
        } else {
          /// If not, we indicate that the loading was not successful
          change(state, status: RxStatus.error());
        }
      },
      onError: () {
        /// If not, we indicate that the loading was not successful
        change(state, status: RxStatus.error());
      },
    );
  }

  /// We obtain the data for the medical circles
  Future<bool> fetchDataCirculos() => appService.threads.execute(
    customExceptionMessages: {
      Exception(): ExceptionAlertProperties(
        message:
            'Error al obtener círculos médicos. Inténtalo de nuevo más tarde',
      ),
    },
    func: () async {
      if (catCirculos.isEmpty) {
        /// We obtain the data for the medical circles
        final Response<List<CirculoMedicoMdl>> hasData = await _apiConn
            .fetchCirculoMedico();

        /// We save the temporary list
        final List<CirculoMedicoMdl> tmpData = hasData.body!;

        /// We build the list of medical circles
        catCirculos = [
          {'claveCirculoMedico': '0', 'circuloMedico': 'Todos'},
          ...tmpData.map(
            (e) {
              /// If the medical circle has a length of 1, the prefix is added
              if (e.circuloMedico.length == 1) {
                return {
                  'claveCirculoMedico': e.claveCirculoMedico,
                  'circuloMedico':
                      'Nivel de tabulador médico ${e.circuloMedico}',
                };
              }

              /// If not, it is returned as is
              return {
                'claveCirculoMedico': e.claveCirculoMedico,
                'circuloMedico': e.circuloMedico,
              };
            },
          ),
        ];
      }

      /// We set the initial values for the search
      circuloSelected.value = catCirculos.first;
    },
  );

  /// We obtain the data for the specialties
  Future<bool> fetchDataEspecialidades() => appService.threads.execute(
    customExceptionMessages: {
      Exception(): ExceptionAlertProperties(
        message:
            '''${msg.errorGetting.value}${msg.specialty.pValue} ${msg.pleaseTryAgainLater.value}''',
      ),
    },
    func: () async {
      if (catEspecialidades.isEmpty) {
        /// Get the data for the specialties
        final Response<List<EspecialidadMdl>> hasData = await _apiConn
            .fetchEspecialidades();

        /// We save the temporary list
        final List<EspecialidadMdl> tmpData = hasData.body!;

        /// We build the list of specialties
        catEspecialidades = [
          {'claveEspecialidad': '0', 'especialidad': 'Todos'},
          ...tmpData.map(
            (e) => {
              'claveEspecialidad': e.claveEspecialidad,
              'especialidad': e.especialidad,
            },
          ),
        ];
      }

      /// We set the initial values for the search
      keyToSearch.value = 'especialidad';
      titleSearchby = 'MÉDICO';

      /// Hint text for the search input List
      hintTextSearch = 'Buscar por especialidad';

      /// Label text for the search input
      labelSearchby = 'Nombre (Opcional)';

      /// Complete list for the search
      _itemsToSearch = catEspecialidades;

      /// Value selected by default
      especialidadSelected.value = catEspecialidades.first;
    },
  );

  /// We obtain the data for the hospital plans
  Future<bool> fetchDataPlanHospitalario() => appService.threads.execute(
    customExceptionMessages: {
      Exception(): ExceptionAlertProperties(
        message:
            '''Error al obtener planes hospitalarios. Inténtalo de nuevo más tarde''',
      ),
    },
    func: () async {
      if (catPlanHospitalario.isEmpty) {
        /// Get the data for the hospital plans
        final Response<List<PlanHospitalarioMdl>> hasData = await _apiConn
            .fetchPlanHospitalario();

        /// We save the temporary list
        final List<PlanHospitalarioMdl> tmpData = hasData.body!;

        /// We build the list of hospital plans
        catPlanHospitalario = [
          {'clavePlan': '0', 'plan': 'Todos'},
          ...tmpData.map(
            (e) => {
              'clavePlan': e.clavePlan,
              'plan': e.plan,
            },
          ),
        ];
      }

      /// We set the initial values for the search
      keyToSearch.value = 'plan';

      /// Hint text for the search input List
      hintTextSearch = 'Buscar por nombre del hospital';

      /// Label text for the search input
      titleSearchby = 'HOSPITAL';

      /// Label text for the search input
      labelSearchby = 'Buscar por nombre del hospital';

      /// Complete list for the search
      _itemsToSearch = catPlanHospitalario;

      /// Value selected by default
      planHospitalarioSelected.value = catPlanHospitalario.first;
    },
  );

  /// We obtain the data for the clinics
  Future<bool> fetchDataClinicas() => appService.threads.execute(
    customExceptionMessages: {
      Exception(): ExceptionAlertProperties(
        message: 'Error al obtener clínicas. Inténtalo de nuevo más tarde',
      ),
    },
    func: () async {
      if (catClinicas.isEmpty) {
        /// We obtain the data for the clinics
        final Response<List<ClinicaMdl>> hasData = await _apiConn
            .fetchClinicas();

        /// We save the temporary list
        final List<ClinicaMdl> tmpData = hasData.body!;

        /// We build the list of clinics
        catClinicas = [
          {'claveTipoClinica': '0', 'tipoClinica': 'Todos'},
          ...tmpData.map(
            (e) => {
              'claveTipoClinica': e.claveTipoClinica,
              'tipoClinica': e.tipoClinica,
            },
          ),
        ];
      }

      /// We set the initial values for the search
      keyToSearch.value = 'tipoClinica';

      /// Hint text for the search input List
      hintTextSearch = 'Buscar por nombre de la clínica';

      /// Label text for the search input
      titleSearchby = 'CLÍNICA';

      /// Label text for the search input
      labelSearchby = 'Buscar por nombre de la clínica';

      /// Complete list for the search
      _itemsToSearch = catClinicas;

      /// Default selected value
      clinicasSelected.value = catClinicas.first;
    },
  );

  /// We obtain the data for other services
  Future<bool> fetchDataOtrosServicios() => appService.threads.execute(
    customExceptionMessages: {
      Exception(): ExceptionAlertProperties(
        message:
            'Error al obtener otros servicios. Inténtalo de nuevo más tarde',
      ),
    },
    func: () async {
      if (catOtrosServicios.isEmpty) {
        /// Get the data for other services
        final Response<List<OtroServicioMdl>> hasData = await _apiConn
            .fetchOtrosServicios();

        /// We save the temporary list
        final List<OtroServicioMdl> tmpData = hasData.body!;

        /// We build the list of other services
        catOtrosServicios = [
          {'claveTipoProveedor': '0', 'tipoProveedor': 'Todos'},
          ...tmpData.map(
            (e) => {
              'claveTipoProveedor': e.claveTipoProveedor,
              'tipoProveedor': e.tipoProveedor,
            },
          ),
        ];
      }

      /// We set the initial values for the search
      keyToSearch.value = 'tipoProveedor';

      /// Hint text for the search input
      hintTextSearch = 'Buscar por nombre...';

      titleSearchby = 'OTROS SERVICIOS';
      labelSearchby = 'Buscar por nombre del establecimiento';

      /// Complete list for the search
      _itemsToSearch = catOtrosServicios;

      /// Value selected by default
      otrosServiciosSelected.value = catOtrosServicios.first;
    },
  );

  /// We obtain the data for the municipalities
  Future<bool> fetchDataMunicipios() {
    /// We inform that we are loading the data
    change(state, status: RxStatus.loading());
    return appService.threads.execute(
      customExceptionMessages: {
        Exception(): ExceptionAlertProperties(
          message: 'Error al obtener municipios. Inténtalo de nuevo más tarde',
        ),
      },
      func: () async {
        /// We obtain the data for the municipalities
        final String cveMun = itemSelectedEstado['claveEstado'] ?? '0';

        /// We obtain the data for the municipalities
        final Response<List<MunicipioMdl>> hasData = await _apiConn
            .fetchMunicipios(cveMun);

        /// We save the temporary list
        final List<MunicipioMdl> tmpData = hasData.body!;

        /// We build the list of municipalities
        catMunicipios = [
          {'claveMunicipio': '0', 'municipio': 'Todos'},
          ...tmpData.map(
            (e) => {
              'claveMunicipio': e.claveMunicipio,
              'municipio': e.municipio,
            },
          ),
        ];

        /// Value selected by default
        municipiosSelected.value = catMunicipios.first;

        /// We indicate that the loading was successful
        change(state, status: RxStatus.success());
      },
      onError: () => change(state, status: RxStatus.error()),
    );
  }

  /// Navigates to the Filter Results Page with the selected filters.
  Future<void> goToFilterResultsPage() async {
    /// Send the user to the results page with the selected filters
    await Get.toNamed(
      FilterResultsPage.page.name,
      arguments: ItemToSearchDirectoryMdl(
        idPage: itemSelected.idPage,
        itemSelected: itemSelected,
        especialidad: especialidadSelected,
        circuloMedico: circuloSelected,
        planHospitalario: planHospitalarioSelected,
        clinica: clinicasSelected,
        otrosServicios: otrosServiciosSelected,
        estado: itemSelectedEstado,
        municipio: municipiosSelected,
        searchBy: searchByCtrler.text,
      ),
    )!.then((_) {
      /// When returning from the results page, reset the search fields

      resetSearch();
      searchByCtrler.clear();

      especialidadSelected.value = catEspecialidades.isNotEmpty
          ? catEspecialidades.first
          : <String, dynamic>{};
      circuloSelected.value = catCirculos.isNotEmpty
          ? catCirculos.first
          : <String, dynamic>{};
      planHospitalarioSelected.value = catPlanHospitalario.isNotEmpty
          ? catPlanHospitalario.first
          : <String, dynamic>{};
      clinicasSelected.value = catClinicas.isNotEmpty
          ? catClinicas.first
          : <String, dynamic>{};
      otrosServiciosSelected.value = catOtrosServicios.isNotEmpty
          ? catOtrosServicios.first
          : <String, dynamic>{};
      itemSelectedEstado.value = catEstados.isNotEmpty
          ? catEstados.first
          : <String, dynamic>{};
      municipiosSelected.value = catMunicipios.isNotEmpty
          ? catMunicipios.first
          : <String, dynamic>{};

      /// Hide the keyboard if it was open
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }
}
