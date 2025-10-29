import 'package:get/get.dart';

import 'package:medicos/src/modules/directorio/directorio_interactor.dart';
import 'package:medicos/src/modules/directorio/directorio_router.dart';
import 'package:medicos/src/modules/directorio/entity/catalogos.dart';
import 'package:medicos/src/modules/directorio/stubs/analytics_services.dart';

class DirectorioController extends GetxController {
  final DirectorioRouter router = DirectorioRouter();
  final DirectorioInteractor interactor = DirectorioInteractor();

  // State
  final RxBool colorM = false.obs;
  final RxBool colorH = false.obs;
  final RxBool colorC = false.obs;
  final RxBool colorOt = false.obs;
  final RxBool colorMod = false.obs;

  final RxList<Estados> listEstados = <Estados>[].obs;
  final RxList<Municipios> listMunicipios = <Municipios>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    AnalyticsServices().sendTag('Directorio_Page');
    await router.requestLocationPermission().then((granted) {
      // Handle permission result if needed
    });
    await _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    // Fetch data and store it in reactive lists.
    // The UI will automatically update.
    listEstados.value = await getEstados();
    if (listEstados.isNotEmpty) {
      listMunicipios.value = await getMunicipios(listEstados[0].claveEstado);
    }
    await getCirculosM();
    await getPlanes();
    await getClinicas();
    await getTipoServicio();
    await getEspecialidades();
    await getSubEspecialidades();
  }

  // --- User Actions ---
  Future<void> onMedicosTapped() async {
    _setActiveColor(colorM);
    await sendAnalytics('Médicos').then((value) => router.showMedicosSearch());
    AnalyticsServices().sendTag('dir_medicos');
  }

  Future<void> onHospitalesTapped() async {
    _setActiveColor(colorH);
    await sendAnalytics(
      'Hospitales',
    ).then((value) => router.showHosptalesSearch());
    AnalyticsServices().sendTag('dir_hospitales');
  }

  Future<void> onClinicasTapped() async {
    _setActiveColor(colorC);
    await sendAnalytics(
      'Clínicas',
    ).then((value) => router.showClinicasSearch());
    AnalyticsServices().sendTag('dir_clinicas');
  }

  Future<void> onOtrosServTapped() async {
    _setActiveColor(colorOt);
    await sendAnalytics(
      'Otros servicios de salud',
    ).then((value) => router.showOtrosServSearch());
    AnalyticsServices().sendTag('dir_otros');
  }

  Future<void> onModulosTapped() async {
    _setActiveColor(colorMod);
    await sendAnalytics(
      'Módulos GNP',
    ).then((value) => router.showModulosSearch());
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

  Future<List<CirculoMedico>> getCirculosM() => interactor.getCirculosM();

  Future<List<Especialidad>> getEspecialidades() =>
      interactor.getEspecialidades();

  Future<List<SubEspecialidad>> getSubEspecialidades() =>
      interactor.getSubEspecialidades();

  Future<List<Planes>> getPlanes() => interactor.getPlanes();

  Future<List<TipoClinica>> getClinicas() => interactor.getClinicas();

  Future<List<TipoServicios>> getTipoServicio() => interactor.getTipoServicio();

  Future<List<Estados>> getEstados() => interactor.getEstados();

  Future<List<Municipios>> getMunicipios(String cvEstado) =>
      interactor.getMunicipios(cvEstado);

  Future sendAnalytics(String opcion) => interactor.sendAnalytics(opcion);
}
