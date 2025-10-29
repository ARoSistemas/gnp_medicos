import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioMapModule/DirectorioMapContract.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioMapModule/DirectorioMapController.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioMapModule/DirectorioMapInteractor.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioMapModule/DirectorioMapRouter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectorioMapPresenter implements DirectorioMapPresentation, DirectorioMapInteractorOutput {

  DirectorioMapControllerState? view;
  DirectorioMapInteractor? interactor;
  DirectorioMapRouter? router;

  DirectorioMapPresenter(DirectorioMapControllerState view) {
    this.view = view;
    this.interactor = new DirectorioMapInteractor(this, view);
    this.router = new DirectorioMapRouter(view);
  }

  @override
  void backToHome() {
    router!.backToHome();
  }

  @override
  void share(LatLng latLng){
    interactor!.share(latLng);
  }

  @override
  void showAlertC(String title, String message) {
    router?.showAlertC(title, message);
  }

  @override
  Future sendAnalytics(String seccion, String accion, String lugar, String opcion) async {
    return interactor!.sendAnalytics(seccion, accion, lugar, opcion);
  }

  @override
  Future initCall(String telefono) async{
    return router?.initCall(telefono);
  }
}