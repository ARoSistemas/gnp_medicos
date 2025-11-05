import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/src/modules/directorio/children/filter_results/filter_results_page.dart';
import 'package:medicos/src/modules/directorio/domain/entities/filter_directory_mdl.dart';
import 'package:medicos/src/modules/directorio/domain/entities/items_directory_mdl.dart';

part 'filterpage_model.dart';

class FilterPageController extends GetxController
    with StateMixin<_FilterPageModel>, WidgetsBindingObserver {
  final AppStateController appState = Get.find<AppStateController>();

  ItemsDirectoryMdl itemSelected = ItemsDirectoryMdl(
    title: 'Médicos',
    subtitle: 'Directorio de Médicos',
    idPage: 'medicos',
  );

  /// Elementos de la búsqueda
  bool _isKeyboardVisible = false;
  RxBool showSearchDropdown = false.obs;
  RxList<Map<String, dynamic>> listFiltered = <Map<String, dynamic>>[].obs;
  List<Map<String, dynamic>> _itemsToSearch = [];
  final TextEditingController searchCtrler = TextEditingController();
  Map<String, dynamic> itemSearch = {};
  final FocusNode fnInputSearch = FocusNode();
  final RxString hintTextSearch = ''.obs;
  final RxString keyToSearch = 'especialidad'.obs;

  /// Elementos de los dropdowns de filtros
  List<Map<String, dynamic>> itemsEspecialidades = [];
  RxMap<String, dynamic> itemSelectedEspecialidades = <String, dynamic>{}.obs;

  List<Map<String, dynamic>> itemsPlanHospitalario = [];
  RxMap<String, dynamic> itemSelectedPlanHospitalario = <String, dynamic>{}.obs;

  List<Map<String, dynamic>> itemsClinicas = [];
  RxMap<String, dynamic> itemSelectedClinicas = <String, dynamic>{}.obs;

  List<Map<String, dynamic>> itemsOtrosServicios = [];
  RxMap<String, dynamic> itemSelectedOtrosServicios = <String, dynamic>{}.obs;

  List<Map<String, dynamic>> itemsCirculos = [];
  RxMap<String, dynamic> itemSelectedCirculos = <String, dynamic>{}.obs;

  List<Map<String, dynamic>> itemsEstados = [];
  RxMap<String, dynamic> itemSelectedEstados = <String, dynamic>{}.obs;

  List<Map<String, dynamic>> itemsMunicipios = [];
  RxMap<String, dynamic> itemSelectedMunicipios = <String, dynamic>{}.obs;

  final TextEditingController medicoCtrler = TextEditingController();
  final TextEditingController aseguradoCtrler = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();

    /// Registramos el observer para detectar cambios en el teclado.
    WidgetsBinding.instance.addObserver(this);

    /// Recibimos el tipo de búsqueda caso no venga nada, se asume médicos
    itemSelected =
        Get.arguments as ItemsDirectoryMdl? ??
        ItemsDirectoryMdl(
          title: 'Médicos',
          subtitle: 'Directorio de Médicos',
          idPage: 'medicos',
        );

    /// Estados y municipios son comunes a varios tipos de búsqueda
    fetchDataEstados();
    fetchDataMunicipios();

    /// Configuramos los valores iniciales según el tipo de búsqueda
    await setTypeSearch(itemSelected);

    /// Una vez configurados los valores iniciales
    /// agregamos los listeners necesarios y continuamos con la carga

    /// Listener para el input de búsqueda
    searchCtrler.addListener(() {
      _filterSearch(key: keyToSearch.value);
    });

    /// Listener para el foco del input de búsqueda
    fnInputSearch.addListener(() {
      showSearchDropdown.value = fnInputSearch.hasFocus;
      if (!fnInputSearch.hasFocus) {
        resetSearch();
      }
    });

    await Future.delayed(const Duration(milliseconds: 750));

    /// Finalmente indicamos que la carga fue exitosa
    change(
      _FilterPageModel(
        name: itemSelected.subtitle,
        itemSelected: itemSelected.idPage,
      ),
      status: RxStatus.success(),
    );
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    searchCtrler.dispose();
    fnInputSearch.dispose();
    medicoCtrler.dispose();
    aseguradoCtrler.dispose();
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

    // Si el teclado estaba visible y ahora no lo está,
    // y el foco lo tiene el input.
    if (_isKeyboardVisible &&
        !isKeyboardCurrentlyVisible &&
        fnInputSearch.hasFocus) {
      searchCtrler.text = 'Andres';
      fnInputSearch.unfocus();
    }

    // Actualizamos el estado del teclado para el próximo frame.
    _isKeyboardVisible = isKeyboardCurrentlyVisible;
  }

  void _filterSearch({required String key}) {
    // required List<Map<String, dynamic>> listToFilter,
    final String query = searchCtrler.text.toLowerCase();

    listFiltered.value = _itemsToSearch.where((item) {
      // final String toSeek = item[key] ?? '';
      final String toSeek = (item[key] as String?)?.toLowerCase() ?? '';
      return toSeek.contains(query.toLowerCase());
    }).toList();
  }

  void resetSearch() {
    listFiltered.value = _itemsToSearch;
    searchCtrler.clear();
    showSearchDropdown.value = false;
  }

  Future<void> setTypeSearch(ItemsDirectoryMdl itemSelected) async {
    /// Definimos los valores iniciales según el tipo de búsqueda
    switch (itemSelected.idPage) {
      case 'medicos':
        keyToSearch.value = 'especialidad';
        hintTextSearch.value = 'Buscar por especialidad';
        fetchDataEspecialidades();
        _itemsToSearch = itemsEspecialidades;
        itemSelectedEspecialidades.value = itemsEspecialidades.first;
        fetchDataCirculos();
        itemSelectedCirculos.value = itemsCirculos.first;
      case 'hospitales':
        keyToSearch.value = 'plan';
        hintTextSearch.value = 'Buscar por nombre del hospital';
        fetchDataPlanHospitalario();
        _itemsToSearch = itemsPlanHospitalario;
        itemSelectedPlanHospitalario.value = itemsPlanHospitalario.first;
      case 'clinicas':
        keyToSearch.value = 'tipoClinica';
        hintTextSearch.value = 'Buscar por nombre de la clínica';
        fetchDataClinicas();
        _itemsToSearch = itemsClinicas;
        itemSelectedClinicas.value = itemsClinicas.first;
      case 'otros_servicios':
        keyToSearch.value = 'tipoServicio';
        hintTextSearch.value = 'Buscar por nombre...';
        fetchDataOtrosServicios();
        _itemsToSearch = itemsOtrosServicios;
        itemSelectedOtrosServicios.value = itemsOtrosServicios.first;
      case 'modulos_gnp':
        keyToSearch.value = 'estado';
        hintTextSearch.value = 'Buscar por...';
      default:
        keyToSearch.value = 'especialidad';
        hintTextSearch.value = 'Buscar por especialidad';
        fetchDataEspecialidades();
        _itemsToSearch = itemsEspecialidades;
        itemSelectedEspecialidades.value = itemsEspecialidades.first;
        fetchDataCirculos();
        itemSelectedCirculos.value = itemsCirculos.first;
    }

    /// Se informa que estamos cargando los datos
    change(
      _FilterPageModel(
        name: itemSelected.subtitle,
        itemSelected: itemSelected.idPage,
      ),
      status: RxStatus.loading(),
    );
  }

  /// Se obtienen los datos de los filtros
  void fetchDataEspecialidades() {
    itemsEspecialidades = [
      {'claveEspecialidad': '0', 'especialidad': 'Todos'},
      {'claveEspecialidad': '1', 'especialidad': 'ANATOMOPATOLOGIA'},
      {
        'claveEspecialidad': '2',
        'especialidad': 'ANESTESIOLOGIA Y C. DEL DOLOR',
      },
      {
        'claveEspecialidad': '3',
        'especialidad': 'ANGIOLOGIA, FONIATRIA Y C.H.',
      },
      {'claveEspecialidad': '4', 'especialidad': 'CARDIOLOGIA'},
      {'claveEspecialidad': '5', 'especialidad': 'CARDIOPEDIATRIA'},
      {'claveEspecialidad': '6', 'especialidad': 'CIRUGIA GENERAL'},
      {'claveEspecialidad': '7', 'especialidad': 'CIRUGIA PEDIATRICA'},
      {'claveEspecialidad': '8', 'especialidad': 'CIRUGIA CARDIOVASCULAR'},
      {'claveEspecialidad': '9', 'especialidad': 'CIRUGIA ONCOLOGICA'},
      {'claveEspecialidad': '10', 'especialidad': 'CIRUGIA PLASTICA'},
      {'claveEspecialidad': '11', 'especialidad': 'CIRUGIA TORACICA'},
      {'claveEspecialidad': '12', 'especialidad': 'CIRUGIA VASCULAR'},
      {'claveEspecialidad': '13', 'especialidad': 'DERMATOLOGIA'},
      {'claveEspecialidad': '14', 'especialidad': 'ENDOCRINOLOGIA'},
      {'claveEspecialidad': '15', 'especialidad': 'GASTROENTEROLOGIA'},
      {'claveEspecialidad': '16', 'especialidad': 'GERIATRIA'},
      {'claveEspecialidad': '17', 'especialidad': 'HEMATOLOGIA'},
      {'claveEspecialidad': '18', 'especialidad': 'INFECTOLOGIA'},
      {'claveEspecialidad': '19', 'especialidad': 'MEDICINA INTERNA'},
      {'claveEspecialidad': '20', 'especialidad': 'NEFROLOGIA'},
      {'claveEspecialidad': '21', 'especialidad': 'NEUMOLOGIA'},
      {'claveEspecialidad': '22', 'especialidad': 'NUTRICION'},
      {'claveEspecialidad': '23', 'especialidad': 'ONCOLOGIA'},
      {'claveEspecialidad': '24', 'especialidad': 'OFTALMOLOGIA'},
      {'claveEspecialidad': '25', 'especialidad': 'OTORRINOLARINGOLOGIA'},
      {'claveEspecialidad': '26', 'especialidad': 'PEDIATRIA'},
      {'claveEspecialidad': '27', 'especialidad': 'PSIQUIATRIA'},
      {'claveEspecialidad': '28', 'especialidad': 'RADIOLOGIA E IMAGEN'},
      {'claveEspecialidad': '29', 'especialidad': 'REHABILITACION'},
      {'claveEspecialidad': '30', 'especialidad': 'REUMATOLOGIA'},
      {'claveEspecialidad': '31', 'especialidad': 'TRAUMATOLOGIA Y ORTOPEDIA'},
      {'claveEspecialidad': '32', 'especialidad': 'UROLOGIA'},
      {'claveEspecialidad': '33', 'especialidad': 'URGENCIAS'},
      {'claveEspecialidad': '34', 'especialidad': 'VIROLOGIA'},
      {'claveEspecialidad': '35', 'especialidad': 'OTRAS ESPECIALIDADES'},
    ];
  }

  /// Se obtienen los datos de los planes hospitalarios
  void fetchDataPlanHospitalario() {
    itemsPlanHospitalario = [
      {'clavePlan': '1', 'plan': 'Todos'},
      {'clavePlan': '2', 'plan': 'Versátil'},
      {'clavePlan': '3', 'plan': 'Premium'},
    ];
  }

  /// Se obtienen los datos de las clínicas
  void fetchDataClinicas() {
    itemsClinicas = [
      {'claveTipoClinica': '1', 'tipoClinica': 'CLINICA DE CORTA ESTANCIA'},
      {'claveTipoClinica': '2', 'tipoClinica': 'CLINICA OFTALMOLOGICA'},
      {'claveTipoClinica': '3', 'tipoClinica': 'CLINICA ONCOLOGICA'},
    ];
  }

  /// Se obtienen los datos de otros servicios
  void fetchDataOtrosServicios() {
    itemsOtrosServicios = [
      {'claveTipoProveedor': 1, 'tipoProveedor': 'Todos'},
      {'claveTipoProveedor': 2, 'tipoProveedor': 'Laboratorios'},
      {'claveTipoProveedor': 3, 'tipoProveedor': 'Gabinetes'},
    ];
  }

  /// Se obtienen los datos de los círculos médicos
  void fetchDataCirculos() {
    itemsCirculos = [
      {'claveCirculoMedico': '0', 'circuloMedico': 'Todos'},
      {'claveCirculoMedico': '1', 'circuloMedico': 'Novus'},
      {'claveCirculoMedico': '2', 'circuloMedico': 'Excelsis'},
    ];
  }

  /// Se obtienen los datos de los estados
  void fetchDataEstados() {
    itemsEstados = [
      {'claveEstado': '000', 'estado': 'Todos'},
      {'claveEstado': '001', 'estado': 'Aguascalientes'},
      {'claveEstado': '002', 'estado': 'Baja California'},
    ];

    itemSelectedEstados.value = itemsEstados.first;
  }

  /// Se obtienen los datos de los municipios
  void fetchDataMunicipios() {
    itemsMunicipios = [
      {'claveMunicipio': '0', 'municipio': 'Todos', 'cp': '0'},
      {
        'claveMunicipio': '001',
        'municipio': 'Municipio Aguascalientes',
        'cp': '20000',
      },
      {
        'claveMunicipio': '002',
        'municipio': 'Municipio Baja California',
        'cp': '20900',
      },
    ];

    itemSelectedMunicipios.value = itemsMunicipios.first;
  }

  Future<void> goToFilterResultsPage() async {
    await Get.toNamed(
      FilterResultsPage.page.name,
      arguments: ItemToSearchDirectoryMdl(
        itemSelected: itemSelected,
        idEspecialidad: itemSelectedEspecialidades['claveEspecialidad'] ?? '',
        idCirculoMedico: itemSelectedCirculos['claveCirculoMedico'] ?? '',
        idPlanHospitalario: itemSelectedPlanHospitalario['clavePlan'] ?? '',
        idClinica: itemSelectedClinicas['claveTipoClinica'] ?? '',
        idOtrosServicios: itemSelectedOtrosServicios['claveTipoProveedor'],
        idEstado: itemSelectedEstados['claveEstado'] ?? '',
        idMunicipio: itemSelectedMunicipios['claveMunicipio'] ?? '',
        doctor: medicoCtrler.text,
        asegurado: aseguradoCtrler.text,
        searchCtrler: itemSearch,
      ),
    );
  }
}
