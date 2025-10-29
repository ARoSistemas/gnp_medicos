import 'package:get/get.dart';

import 'DirectorioInteractor.dart';
import 'DirectorioRouter.dart';
import 'Entity/Catalogos.dart';
import 'stubs/AnalyticsServices.dart';

class DirectorioController extends GetxController {
  final DirectorioRouter router = DirectorioRouter();
  final DirectorioInteractor interactor = DirectorioInteractor();

  // State
  final colorM = false.obs;
  final colorH = false.obs;
  final colorC = false.obs;
  final colorOt = false.obs;
  final colorMod = false.obs;

  final listEstados = <Estados>[].obs;
  final listMunicipios = <Municipios>[].obs;

  @override
  void onInit() {
    super.onInit();
    AnalyticsServices().sendTag('Directorio_Page');
    router.requestLocationPermission().then((granted) {
      // Handle permission result if needed
    });
    _fetchInitialData();
  }

  void _fetchInitialData() async {
    // Fetch data and store it in reactive lists.
    // The UI will automatically update.
    listEstados.value = await getEstados();
    if (listEstados.isNotEmpty && listEstados[0].claveEstado != null) {
      listMunicipios.value = await getMunicipios(listEstados[0].claveEstado!);
    }
    getCirculosM();
    getPlanes();
    getClinicas();
    getTipoServicio();
    getEspecialidades();
    getSubEspecialidades();
  }

  // --- User Actions ---
  void onMedicosTapped() {
    _setActiveColor(colorM);
    sendAnalytics('Médicos').then((value) => router.showMedicosSearch());
    AnalyticsServices().sendTag('dir_medicos');
  }

  void onHospitalesTapped() {
    _setActiveColor(colorH);
    sendAnalytics('Hospitales').then((value) => router.showHosptalesSearch());
    AnalyticsServices().sendTag('dir_hospitales');
  }

  void onClinicasTapped() {
    _setActiveColor(colorC);
    sendAnalytics('Clínicas').then((value) => router.showClinicasSearch());
    AnalyticsServices().sendTag('dir_clinicas');
  }

  void onOtrosServTapped() {
    _setActiveColor(colorOt);
    sendAnalytics('Otros servicios de salud')
        .then((value) => router.showOtrosServSearch());
    AnalyticsServices().sendTag('dir_otros');
  }

  void onModulosTapped() {
    _setActiveColor(colorMod);
    sendAnalytics('Módulos GNP').then((value) => router.showModulosSearch());
    AnalyticsServices().sendTag('dir_modulos');
  }

  void _setActiveColor(RxBool activeColor) {
    colorM.value = false;
    colorH.value = false;
    colorC.value = false;
    colorOt.value = false;
    colorMod.value = false;
    activeColor.value = true;
  }

  // --- Methods from Presenter ---
  void backToHome() {
    router.backToHome();
  }

  Future<List<CirculoMedico>> getCirculosM() async => interactor.getCirculosM();

  Future<List<Especialidad>> getEspecialidades() async =>
      interactor.getEspecialidades();

  Future<List<SubEspecialidad>> getSubEspecialidades() async =>
      interactor.getSubEspecialidades();

  Future<List<Planes>> getPlanes() async => interactor.getPlanes();

  Future<List<TipoClinica>> getClinicas() async => interactor.getClinicas();

  Future<List<TipoServicios>> getTipoServicio() async =>
      interactor.getTipoServicio();

  Future<List<Estados>> getEstados() async => interactor.getEstados();

  Future<List<Municipios>> getMunicipios(String cvEstado) async =>
      interactor.getMunicipios(cvEstado);

  Future sendAnalytics(String opcion) async => interactor.sendAnalytics(opcion);
}