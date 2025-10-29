
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioContract.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioController.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioInteractor.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioRouter.dart';
import 'Entity/Catalogos.dart';

class DirectorioPresenter implements DirectorioPresentation, DirectorioInteractorOutput {

  DirectorioControllerState? view;
  late DirectorioInteractor interactor;
  late DirectorioRouter router;

  DirectorioPresenter(DirectorioControllerState view) {
    this.view = view;
    this.interactor = new DirectorioInteractor(this, view);
    this.router = new DirectorioRouter(view);
  }

  @override
  void backToHome() {
    router.backToHome();
  }

  @override
  void showMedicosSearch() {
    router.showMedicosSearch();
  }

  @override
  void showHosptalesSearch() {
    router.showHosptalesSearch();
  }

  @override
  void showClinicasSearch() {
    router.showClinicasSearch();
  }

  @override
  void showOtrosServSearch() {
    router.showOtrosServSearch();
  }

  @override
  void showModulosSearch() {
    router.showModulosSearch();
  }

  @override
  Future<List<Planes>> getPlanes() async{
    return await interactor.getPlanes();
  }

  @override
  Future<List<CirculoMedico>> getCirculosM() async{
    return await interactor.getCirculosM();
  }

  @override
  Future<List<Especialidad>> getEspecialidades() async{
    return await interactor.getEspecialidades();
  }

  @override
  Future<List<SubEspecialidad>> getSubEspecialidades() async{
    return await interactor.getSubEspecialidades();
  }

  @override
  Future<List<TipoClinica>> getClinicas() async{
    return await interactor.getClinicas();
  }

  @override
  Future<List<TipoServicios>> getTipoServicio() async{
    return await interactor.getTipoServicio();
  }

  @override
  Future<List<Estados>> getEstados() async{
    return await interactor.getEstados();
  }

  @override
  Future<List<Municipios>> getMunicipios(String cvEstado) async{
    return await interactor.getMunicipios(cvEstado);
  }

  @override
  Future<bool> requestLocationPermission() async{
    return await router.requestLocationPermission();
  }

  Future sendAnalytics(String opcion) async{
    return await interactor.sendAnalytics(opcion);
  }


}