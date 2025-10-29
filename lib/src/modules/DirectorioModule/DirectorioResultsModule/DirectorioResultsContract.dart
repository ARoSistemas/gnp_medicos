
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioResultsModule/SearchResult.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Parametros.dart';

abstract class DirectorioResultsView {

}

abstract class DirectorioResultsPresentation {
  void backToHome();
  void openMap(String title, SearchResult searchResult, String catalogo);
  void openFilters(String servicio, Parametros parametros, String catalogo, String poliza, String especialidad);
}

abstract class DirectorioResultsUseCase {

}

abstract class DirectorioResultsInteractorOutput {

}

abstract class DirectorioResultsWireFrame {
  void backToHome();
  void openMap(String title, SearchResult searchResult, String catalogo);
  void openFilters(String servicio, Parametros parametros, String catalogo, String poliza, String especialidad);
}