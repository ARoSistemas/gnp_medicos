import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioResultsModule/DirectorioResultsContract.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioResultsModule/DirectorioResultsPresenter.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioResultsModule/SearchResult.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioSearchModule/DirectorioSearchController.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Clinicas.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Hospitales.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Parametros.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/AppColors.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/Utils.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';

class DirectorioResultsController extends StatefulWidget {
  DirectorioResultsController(
      {Key? key,
      this.servicio,
      this.servicioSelect,
      this.catalogo,
      this.catalogodos,
      this.estado,
      this.municipio,
      this.parametros,
      this.poliza,
      this.filtros})
      : super(key: key);
  final String? servicio;
  final String? servicioSelect;
  final String? catalogo;
  final String? catalogodos;
  final String? estado;
  final String? municipio;
  final Parametros? parametros;
  final String? poliza;
  final bool? filtros;

  @override
  DirectorioResultsControllerState createState() =>
      DirectorioResultsControllerState(servicio, catalogo, catalogodos, estado,
          municipio, parametros, poliza, filtros);
}

class DirectorioResultsControllerState
    extends State<DirectorioResultsController>
    implements DirectorioResultsView {
  DirectorioResultsPresenter? presenter;
  String? servicioSelect;
  String? servicio;
  String? catalogo;
  String? catalogodos;
  String? estado;
  String? municipio;
  Parametros? parametros;
  String? poliza;
  bool? filtros;
  Widget currentContent = Scaffold();
  List? serviciosPList;
  AutoCompleteTextField? searchTextField;
  TextEditingController controller = new TextEditingController();
  int selectList = 0;
  int selectListItem = 0;
  List? genericaList;
  List? totalList;
  double maxScroll = 1;
  double positionScroll = 0;
  bool mostrarLoading = false;
  int? paginaActual;
  int? paginasTotales;
  String? alertaCons;
  bool alertaShow = false;

  ResultadoClinicas? resultados;
  ResultadoHospitales? resultadosH;

  List<DropdownMenuItem<String>>? polizasList;
  String? currentPoliza;
  int? totales = 0;
  var current;
  Widget topIcon = Icon(Icons.face);
  ScrollController _scrollController = ScrollController();

  DirectorioResultsControllerState(
      String? servicio,
      String? catalogo,
      String? catalogodos,
      String? estado,
      String? municipio,
      Parametros? parametros,
      String? poliza,
      bool? filtros) {
    this.presenter = DirectorioResultsPresenter(this);
    this.servicio = servicio;
    this.catalogo = catalogo;
    this.catalogodos = catalogodos;
    this.estado = estado;
    this.municipio = municipio;
    this.parametros = parametros;
    this.poliza = poliza;
    this.filtros = filtros;
  }

  @override
  void initState() {
    _scrollController.addListener(_onScrollUpgrade);
    super.initState();
    switch (widget.servicio) {
      case "Médicos en convenio":
        this.polizasList = presenter?.getPolizas();
        this.currentPoliza = polizasList![1].value;
        current = TipoServicio.Medicos;
        currentContent = getMedicosResults();
        break;
      case "Hospitales en convenio":
        this.polizasList = presenter?.getPolizas();
        this.currentPoliza = polizasList![1].value;
        current = TipoServicio.Hospitales;
        currentContent = getHospitalesResults();
        break;
      case "Clínicas en convenio":
        current = TipoServicio.Clinicas;
        currentContent = getClinicasResults();
        break;
      case "Otros servicios de salud":
        current = TipoServicio.OtrosServ;
        currentContent = getOtroServiciosResults();
        break;

      case "Módulos GNP":
        current = TipoServicio.Modulos;
        currentContent = getModulosResults();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.servicio) {
      case "Médicos en convenio":
        this.polizasList = presenter?.getPolizas();
        this.currentPoliza = polizasList![1].value;
        current = TipoServicio.Medicos;
        return getMedicosResults();
        break;
      case "Hospitales en convenio":
        this.polizasList = presenter?.getPolizas();
        this.currentPoliza = polizasList![1].value;
        current = TipoServicio.Hospitales;
        return getHospitalesResults();
        break;
      case "Clínicas en convenio":
        current = TipoServicio.Clinicas;
        return getClinicasResults();
        break;
      case "Otros servicios de salud":
        current = TipoServicio.OtrosServ;
        return getOtroServiciosResults();
        break;

      case "Módulos GNP":
        current = TipoServicio.Modulos;
        return getModulosResults();
        break;
    }

    return SizedBox();
  }

  Scaffold getMedicosResults() {
    return Scaffold(
        body: genericList(presenter!.getMedicoBusqueda(
            0,
            parametros!.cvCirculoM,
            parametros!.bandera,
            parametros!.cvEstado,
            parametros!.cvMunicipio,
            int.tryParse(parametros!.cvEspecialidad??""),
            parametros!.nombre,
            parametros!.origen,
            parametros!.buscador,
            parametros!.pagina,
            parametros!.dateTime)));
  }

  Scaffold getHospitalesResults() {
    return Scaffold(
        body: genericList(presenter!.getHospitalBusqueda(
            parametros?.idHospital,
            parametros!.nombreComercial,
            parametros!.cvEstado,
            parametros!.cvMunicipio,
            parametros!.rfc,
            parametros!.razonSocial,
            parametros!.codigoFiliacion,
            parametros!.cvPlanH,
            parametros!.claveLineaComercial,
            parametros!.bandera,
            parametros!.claveNivelHospitalario,
            parametros!.productoTecnico,
            parametros!.productoComercial,
            parametros!.origen,
            parametros!.filtros,
            parametros!.pagina,
            parametros!.dateTime)!));
  }

  Scaffold getClinicasResults() {
    return Scaffold(
        body: genericList(presenter!.getClinicasBusqueda(
            parametros!.claveGestion,
            parametros!.nombreComercial,
            parametros!.cvTipo,
            parametros!.descEstado,
            parametros!.descMunicipio,
            parametros!.pagina,
            parametros!.dateTime,
            parametros!.tipoClinica)));
  }

  Scaffold getOtroServiciosResults() {
    return Scaffold(
        body: genericList(presenter!.getOtrosServiciosMedicosBusqueda(
            parametros!.claveGestion!,
            parametros!.nombre!,
            parametros!.cvTipo!,
            parametros!.cvEstado!,
            parametros!.cvMunicipio!,
            parametros!.pagina!,
            parametros!.dateTime!)));
  }

  Scaffold getModulosResults() {
    return Scaffold(
        body: genericList(
          presenter!.getModulosBusqueda(
            parametros!.cvEstado!,
            parametros!.dateTime!
          )
        )
    );
  }

  Scaffold getSinResults() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.orange),
        title: Text(
          this.servicio!,
          style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.dirTextColor),
        ),
      ),
      body: Container(
        alignment: Alignment.bottomCenter,
        color: Colors.white,
        padding: EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "No se encontraron resultados",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.colorVisibilty,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            Container(
              //crossAxisAlignment: CrossAxisAlignment.center,
              padding: EdgeInsets.only(top: 8, bottom: 20),
              child: Text(
                "Selecciona el botón de buscar y realiza una nueva búsqueda",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.gnpTextSystem,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 8, bottom: 20),
                child: Image.asset('assets/img/sin_resultados.png')),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.only(bottom: 16.0, right: 16, left: 16),
        child: ButtonTheme(
          minWidth: 400.0,
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(15.0),
              backgroundColor: AppColors.secondary900,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6)
              )
            ),
            child: Text("Nueva búsqueda",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,),
            ),

            onPressed: () {
              Navigator.pop(context);
            }),
      ),
    ));
  }

  void polizaSeleccionada(String selectedPoliza) {
    setState(() {
      currentPoliza = selectedPoliza;
    });
  }

  void _onScrollUpgrade() {
    maxScroll = _scrollController.position.maxScrollExtent;
    positionScroll = _scrollController.offset;
    if (maxScroll == positionScroll && paginaActual != paginasTotales) {
      setState(() {
        genericaList = null;
        mostrarLoading = true;
        parametros!.pagina = parametros!.pagina! + 1;
      });
    }
    //print(_scrollController.offset.toString() + " de: " + maxScroll.toString());
  }

  void _ShowAlert(String? tipo, SearchResult selectedItem, String catalogo) {
    print("TIPO: $tipo");
    if (selectedItem.latitud == "0.0" && selectedItem.longitud == "0.0" ||
        selectedItem.latitud == "" && selectedItem.longitud == "") {
      presenter!.mostrarAlertaCallBackCustom(
          "Este registro no tiene coordenadas",
          "No es posible mostrar este registro en el mapa",
          context,
          "  Aceptar  ", () {
        if ((this.servicio.toString().contains("Médicos"))) {
          this.servicio = "Médico";
        } else if ((this.servicio.toString().contains("Hospitales"))) {
          this.servicio = "Hospital";
        } else if ((this.servicio.toString().contains("Clínicas"))) {
          this.servicio = "Clínica";
        } else if ((this.servicio.toString().contains("Otros"))) {
          this.servicio = "Otro servicio de salud";
        } else if (this.servicio.toString().contains("Módulos")) {
          this.servicio = "Módulo GNP";
        }

        Navigator.pop(context);
        presenter!.openMap(this.servicio, selectedItem, catalogo);
      });
    } else if (tipo != "" && selectedItem.alertaMensaje != "") {
      switch (tipo.toString()) {
        case "CONTRATADO":
          selectedItem.alertaTitulo = "RECUERDA";
          topIcon = Icon(
            Icons.warning,
            color: Colors.yellow,
            size: 32,
          );
          break;
        case "BENEFICIO":
          topIcon = Icon(
            Icons.add_alert,
            color: Colors.green,
            size: 32,
          );
          break;
        case "PENALIZACION":
          selectedItem.alertaTitulo = "PENALIZACIÓN";
          topIcon = Icon(
            Icons.clear,
            color: Colors.red,
            size: 32,
          );
          break;
        case "NO_CONTRATADO":
          selectedItem.alertaTitulo = "RECUERDA";
          topIcon = Icon(
            Icons.warning,
            color: Colors.yellow,
            size: 32,
          );
          break;
      }
      presenter!.mostrarAlertaCallBackCustom(selectedItem.alertaTitulo!,
          selectedItem.alertaMensaje!, context, "Entendido", () {
        if ((this.servicio.toString().contains("Médicos"))) {
          this.servicio = "Médico";
        } else if ((this.servicio.toString().contains("Hospitales"))) {
          this.servicio = "Hospital";
        } else if ((this.servicio.toString().contains("Clínicas"))) {
          this.servicio = "Clínica";
        } else if ((this.servicio.toString().contains("Otros"))) {
          this.servicio = "Otro servicio de salud";
        } else if ((this.servicio.toString().contains("Módulos"))) {
          this.servicio = "Módulo GNP";
        }
        Navigator.pop(context);
        presenter!.openMap(this.servicio, selectedItem, catalogo);
      });
    } else {
      if ((this.servicio.toString().contains("Médicos"))) {
        this.servicio = "Médico";
      } else if ((this.servicio.toString().contains("Hospitales"))) {
        this.servicio = "Hospital";
      } else if ((this.servicio.toString().contains("Clínicas"))) {
        this.servicio = "Clínica";
      } else if ((this.servicio.toString().contains("Otros"))) {
        this.servicio = "Otro servicio de salud";
      } else if ((this.servicio.toString().contains("Módulos"))) {
        this.servicio = "Módulo GNP";
      }
      presenter!.openMap(this.servicio, selectedItem, catalogo);
    }
  }

  void _showAlertConsulta(String? mensaje) {
    //presenter.showAlert("warning.png", "", mensaje);
    presenter!.mostrarAlertaCallBackCustom("", mensaje!, context, "Aceptar", () {
      Navigator.pop(context);
    });
  }

  Widget genericList(Future<List<SearchResultList>> peticion) {
    try {
      if ((genericaList != null)) {
        return getGenericList(totalList);
      } else {
        return FutureBuilder(
          future: peticion,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return loading();
              default:
                if (snapshot.hasError) {
                  return Center(child: Container());
                } else {
                  if (snapshot.hasData &&
                      snapshot.data != [] &&
                      snapshot.data?.length != 0 &&
                      snapshot.data?[0].lista?.length != 0) {
                    genericaList = snapshot.data != null ? snapshot.data : 0 as List<dynamic>?;
                    if (totalList != null) {
                      totalList![0].lista =
                          totalList![0].lista + genericaList![0].lista;
                      paginaActual = genericaList![0].lista[0].pagActual;
                    } else {
                      totalList = genericaList;
                      if (totalList![0].lista[0].alertaConsulta != "") {
                        alertaCons = totalList![0].lista[0].alertaConsulta;
                      }
                      paginasTotales = genericaList![0].lista[0].pagActual;
                      paginaActual = genericaList![0].lista[0].pagActual;
                    }
                    if (genericaList!.length != 0 &&
                        genericaList![0].lista.isNotEmpty) {
                      totales = genericaList![0].lista[0].registrosTotales;
                      return getGenericList(totalList);
                    } else {
                      return getSinResults();
                    }
                  }
                  if (!snapshot.hasData ||
                      snapshot.data?.length == 0 ||
                      snapshot.data?[0].lista?.length == 0) {
                    genericaList = snapshot.data != null ? snapshot.data : 0 as List<dynamic>?;
                    return getSinResults();
                  }
                }
            }

            return getGenericList(genericaList);
          },
        );
      }
    } catch (e) {
      print(e);
    }
    return SizedBox();
  }

  Widget loading() {
    return Container(
        child: Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.transparent,
        valueColor: AlwaysStoppedAnimation(AppColors.azulGNP),
        strokeWidth: 4.0,
      ),
    ));
  }

  Scaffold getGenericList(totalList) {
    if ((alertaCons != null && alertaCons != "") && alertaShow != true) {
      alertaShow = true;
      Future.delayed(Duration.zero, () => _showAlertConsulta(alertaCons));
    }

    if (this.servicio!.contains("Hospital")) {
      this.servicio = "Hospitales en convenio";
    } else if (this.servicio!.contains("Médico")) {
      this.servicio = "Médicos en convenio";
    } else if (this.servicio!.contains("Otro servicio")) {
      this.servicio = "Otros servicios de salud";
    } else if (this.servicio!.contains("Clínica")) {
      this.servicio = "Clínicas en convenio";
    } else if (this.servicio!.contains("Módulo")) {
      this.servicio = "Módulos GNP";
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.orange),
        title: Text(
          this.servicio!,
          style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.dirTextColor),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            presenter!.backToHome();
          },
        ),
        actions: <Widget>[
          Visibility(
            visible: this.servicio.toString().contains("Médicos") &&
                        this.poliza != "Sin póliza" &&
                        this.parametros!.bandera == true ||
                    (this.servicio.toString().contains("Hospitales") ||
                            this.servicio.toString().contains("Hospital")) &&
                        this.poliza != "Sin póliza" &&
                        this.parametros!.bandera == true
                ? true
                : false,
            child: new IconButton(
                icon: Image.asset('assets/img/icon_filtro.png'),
                onPressed: () {
                  presenter!.openFilters(this.servicio, this.parametros,
                      this.catalogo, this.poliza, this.catalogodos);
                }),
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          if ((this.servicio.toString().contains("Médicos"))) {
            current = TipoServicio.Medicos;
          } else if ((this.servicio.toString().contains("Hospitales")) ||
              (this.servicio.toString().contains("Hospital"))) {
            current = TipoServicio.Hospitales;
          } else if ((this.servicio.toString().contains("Clínicas"))) {
            current = TipoServicio.Clinicas;
          } else if ((this.servicio.toString().contains("Otros"))) {
            current = TipoServicio.OtrosServ;
          } else if (this.servicio.toString().contains("Módulos")) {
            current = TipoServicio.Modulos;
          }
          Navigator.pop(context);

          return false;
        },
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 16, left: 16),
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Se encontraron " + totales.toString() + " resultados para:",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: AppColors.colorVisibilty,
                      fontSize: 12,
                      fontWeight: FontWeight.normal),
                ),
              ),
              //visibility mostrar flatbutton
              Visibility(
                visible: poliza == ""
                    ? true
                    : poliza!.contains("Sin póliza")
                        ? true
                        : parametros!.bandera == false ? true : false,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: (current == TipoServicio.Medicos) &&
                                (Utils.lbBuscador == false)
                            ? true
                            : false,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                                      if (states.contains(MaterialState.disabled))
                                        return AppColors.gnpBackLight2;
                                      return null;
                                  }),
                                  foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                                      if (states.contains(MaterialState.disabled))
                                        return AppColors.gnpTextSystem2;
                                      return null;
                                  }),
                                  shape: MaterialStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(color: AppColors.gnpBackLight2))
                                  ),
                                ),
                                onPressed: null,
                                child: Text(catalogo!, style: TextStyle(color: AppColors.gnpTextSystem, fontSize: 14, fontWeight: FontWeight.normal))),
                              SizedBox(
                                width: 10,
                                height: 20,
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                                      if (states.contains(MaterialState.disabled))
                                        return AppColors.gnpBackLight2;
                                      return null;
                                  }),
                                  foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                                      if (states.contains(MaterialState.disabled))
                                        return AppColors.gnpTextSystem2;
                                      return null;
                                  }),
                                  shape: MaterialStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(color: AppColors.gnpBackLight2))
                                  ),
                                ),
                                  onPressed: null,
                                  child: Text(
                                    catalogodos!,
                                    style: TextStyle(
                                        color: AppColors.gnpTextSystem,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                              )),

                              SizedBox(
                                width: 10,
                                height: 20,
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                                      if (states.contains(MaterialState.disabled))
                                        return AppColors.gnpBackLight2;
                                      return null;
                                  }),
                                  foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                                      if (states.contains(MaterialState.disabled))
                                        return AppColors.gnpTextSystem2;
                                      return null;
                                  }),
                                  shape: MaterialStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(color: AppColors.gnpBackLight2))
                                  ),
                                ),
                                  onPressed: null,
                                  child: Text(estado!, style: TextStyle(color: AppColors.gnpTextSystem, fontSize: 14, fontWeight: FontWeight.normal))),
                              SizedBox(
                                width: 10,
                                height: 20,
                              ),
                              TextButton(
                                  onPressed: null,
                                  child: Text(municipio!, style: TextStyle(color: AppColors.gnpTextSystem, fontSize: 14, fontWeight: FontWeight.normal),),
                                  style: TextButton.styleFrom(
                                    disabledBackgroundColor: AppColors.gnpBackLight2,
                                    disabledForegroundColor: AppColors.gnpTextSystem2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(color: AppColors.gnpBackLight2)))),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: (current == TipoServicio.Clinicas ||
                                    current == TipoServicio.OtrosServ ||
                                    current == TipoServicio.Hospitales) &&
                                (Utils.lbBuscador == false)
                            ? true
                            : false,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextButton(
                                  style: TextButton.styleFrom(
                                    disabledBackgroundColor: AppColors.gnpBackLight2,
                                    disabledForegroundColor: AppColors.gnpTextSystem2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(color: AppColors.gnpBackLight2))
                                  ),
                                  onPressed: null,
                                  child: Text(catalogo!, style: TextStyle(color: AppColors.gnpTextSystem, fontSize: 14, fontWeight: FontWeight.normal),),
                                  //disabledColor: AppColors.gnpBackLight2,
                                  //disabledTextColor: AppColors.gnpTextSystem2,
                                  /*shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(color: AppColors.gnpBackLight2))*/
                                      ),
                              SizedBox(
                                width: 10,
                                height: 20,
                              ),
                              TextButton(
                                  onPressed: null,
                                  child: Text(estado!, style: TextStyle(color: AppColors.gnpTextSystem, fontSize: 14, fontWeight: FontWeight.normal),),
                                  style: TextButton.styleFrom(
                                    disabledBackgroundColor: AppColors.gnpBackLight2,
                                    disabledForegroundColor: AppColors.gnpTextSystem2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(color: AppColors.gnpBackLight2)))),
                              SizedBox(
                                width: 10,
                                height: 20,
                              ),
                              TextButton(
                                  onPressed: null,
                                  child: Text(municipio!, style: TextStyle(color: AppColors.gnpTextSystem, fontSize: 14, fontWeight: FontWeight.normal),),
                                  style: TextButton.styleFrom(
                                    disabledBackgroundColor: AppColors.gnpBackLight2,
                                    disabledForegroundColor: AppColors.gnpTextSystem2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(color: AppColors.gnpBackLight2)))),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: (current == TipoServicio.Modulos) &&
                                (Utils.lbBuscador == false)
                            ? true
                            : false,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: TextButton(
                              onPressed: null,
                              child: Text(estado!, style: TextStyle(color: AppColors.gnpTextSystem, fontSize: 14, fontWeight: FontWeight.normal),),
                              style: TextButton.styleFrom(
                                disabledBackgroundColor: AppColors.gnpBackLight2,
                                disabledForegroundColor: AppColors.gnpTextSystem2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(color: AppColors.gnpBackLight2)))),
                        ),
                      ),
                      Visibility(
                        visible: Utils.lbBuscador,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: TextButton(
                              onPressed: null,
                              child: Text(catalogodos!, style: TextStyle(color: AppColors.gnpTextSystem, fontSize: 14, fontWeight: FontWeight.normal),),
                              style: TextButton.styleFrom(
                                disabledBackgroundColor: AppColors.gnpBackLight2,
                                disabledForegroundColor: AppColors.gnpTextSystem2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(color: AppColors.gnpBackLight2)))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //visibility mostrar poliza
              Visibility(
                visible: poliza == ""
                    ? false
                    : poliza!.contains("Sin póliza")
                        ? false
                        : parametros!.bandera == false ? false : true,
                child: Column(
                  children: <Widget>[
                    Container(
                        padding:
                            EdgeInsets.only(top: 8.0, bottom: 16.0, left: 16.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Text(
                                "Póliza " + this.poliza!,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.gnpTextSystem,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 1,
                  child: Container(color: AppColors.proccessColorDisabled),
                ),
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height - 210,
                  width: MediaQuery.of(context).size.width,
                  child: DraggableScrollbar(
                      controller: _scrollController,
                      backgroundColor: AppColors.scrollbar,
                      heightScrollThumb: 20,
                      child: ListView.builder(
                          controller: _scrollController,
                          itemCount: totalList.length,
                          itemBuilder: (context, indexUno) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(
                                        top: 7, bottom: 17, left: 16),
                                    child: Text(
                                      totalList[indexUno].etiquetaDeBusqueda,
                                      style: TextStyle(
                                          color: AppColors.gnpTextSystem2,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                    )),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 12, right: 12), //, bottom: 10
                                  child: ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 8.0, bottom: 8.0),
                                            child: SizedBox(
                                              width: double.infinity,
                                              height: 1,
                                              child: Container(
                                                  color: AppColors
                                                      .proccessColorDisabled),
                                            ),
                                          ),
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          totalList[indexUno].lista.length,
                                      itemBuilder: (context, indexDos) {
                                        final title = totalList[indexUno].lista[indexDos].titulo;
                                        final level = totalList[indexUno].lista[indexDos].nivel;
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectList = indexUno;
                                              selectListItem = indexDos;
                                              totalList[indexUno]
                                                  .lista[indexDos]
                                                  .selected = true;
                                              _ShowAlert(
                                                  totalList[indexUno]
                                                      .lista[indexDos]
                                                      .tipo,
                                                  totalList[indexUno]
                                                      .lista[indexDos],
                                                  "");
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                bottom: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                _getTitleAndLevelWidget(
                                                  title,
                                                  level,
                                                ),
                                                Text(
                                                    totalList[indexUno]
                                                        .lista[indexDos]
                                                        .texto,
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .colorVisibilty,
                                                        fontSize: 14,
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.normal)),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 7, bottom: 10, left: 10, right: 10),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 1,
                                    child: Container(
                                        color: AppColors.proccessColorDisabled),
                                  ),
                                ),
                              ],
                            );
                          }),
                      scrollThumbBuilder: (
                        Color backgroundColor,
                        Animation<double> thumbAnimation,
                        Animation<double> labelAnimation,
                        double height, {
                        Text? labelText,
                        BoxConstraints? labelConstraints,
                      }) {
                        return FadeTransition(
                          opacity: thumbAnimation,
                          child: Container(
                            height: height,
                            width: 10.0,
                            color: backgroundColor,
                          ),
                        );
                      }),
                ),
                //termina
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTitleAndLevelWidget(
    String title,
    String level,
  ) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getTitleWidget(title),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: _getLevelWidget(level),
          )
        ],
      );

  Widget _getTitleWidget(String title) => title.isNotEmpty
      ? Container(
          width: MediaQuery.of(context).size.width + 20,
          margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.gnpTextSystem,
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      : Container();

  Widget _getLevelWidget(String level) => level.isNotEmpty
      ? Text(
          level,
          style: TextStyle(
            color: AppColors.gnpTextSystem,
            fontSize: 12,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.normal,
          ),
        )
      : Container();
}
