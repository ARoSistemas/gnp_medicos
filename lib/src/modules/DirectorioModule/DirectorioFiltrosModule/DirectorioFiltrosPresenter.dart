import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioFiltrosModule/DirectorioFiltrosContract.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioFiltrosModule/DirectorioFiltrosController.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioFiltrosModule/DirectorioFiltrosInteractor.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioFiltrosModule/DirectorioFiltrosRouter.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Catalogos.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Parametros.dart';


class DirectorioFiltrosPresenter implements DirectorioFiltrosPresentation, DirectorioFiltrosInteractorOutput{

  DirectorioFiltrosControllerState? view;
  DirectorioFiltrosInteractor? interactor;
  DirectorioFiltrosRouter? router;

  DirectorioFiltrosPresenter(DirectorioFiltrosControllerState view) {
    this.view = view;
    this.interactor = new DirectorioFiltrosInteractor(this, view);
    this.router = new DirectorioFiltrosRouter(view);
  }

  @override
  void backToHome() {
    router?.backToHome();
  }

  @override
  Future<List<NivelHospitalario>> getNivelHospitalario(String? clavePlan, String? productoTecnico, String? productoComercial) async{
    return interactor!.getNivelHospitalario(clavePlan!, productoTecnico, productoComercial);
  }

  @override
  Future<List<CirculoMedico>> getCirculosM() async{
    return interactor!.getCirculosM();
  }

  @override
  Future<List<Estados>> getEstados() async{
    return await interactor!.getEstados();
  }

  @override
  Future<List<Municipios>> getMunicipios(String cvEstado) async{
    return interactor!.getMunicipios(cvEstado);
  }

  @override
  void showSearch(String servicio,String servicioSelect, String catalogo, String catalogodos, String estado, String municipio, Parametros claves, String poliza, bool filtros) {
    router?.showSearch(servicio, servicioSelect, catalogo, catalogodos, estado, municipio, claves, poliza, filtros);
  }
}