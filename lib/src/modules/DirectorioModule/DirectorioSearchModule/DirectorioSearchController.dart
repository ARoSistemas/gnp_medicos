
import 'package:agentesgnp/CommonsV2/Widgets/CustomAlerts.dart';
import 'package:agentesgnp/Functions/Analytics.dart';
import 'package:agentesgnp/Functions/gestionRoles.dart';
import 'package:agentesgnp/UserInterfaces/Cotizadores/CotizadorUnico/utils/Utils.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioController.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioSearchModule/CatalogoDdObject.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioSearchModule/DirectorioSearchContract.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioSearchModule/DirectorioSearchPresenter.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioSearchModule/GeneraCatalogoDd.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Catalogos.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Clinicas.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Hospitales.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/OtrosServiciosMedicos.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Parametros.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/AppColors.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:agentesgnp/Modelos/LoginModels.dart';

enum TipoServicio { Medicos, Hospitales, Clinicas, OtrosServ, Modulos }

class DirectorioSearchController extends StatefulWidget {
  DirectorioSearchController({Key? key, this.servicio}) : super(key: key);
  final TipoServicio? servicio;

  @override
  DirectorioSearchControllerState createState() =>
      DirectorioSearchControllerState(servicio);
}

class DirectorioSearchControllerState extends State<DirectorioSearchController>
    implements DirectorioSearchView {
  DirectorioSearchPresenter? presenter;
  TipoServicio? servicio;
  Widget currentContent = Scaffold();

  late GestionRoles gestionroles;

  bool existeElement = false;
  final formKey = GlobalKey<FormState>();
  bool mostrarDropdownPolizas = false;
  bool mostrarDropdownUsuario = false;
  String? concatName = "";

  CatalogoDdObject? catalogoUno;
  CatalogoDdObject? catalogoDos;
  CatalogoDdObject? catalogoTres;
  CatalogoDdObject? catalogoCuatro;
  CatalogoDdObject? catalogoCinco;
  CatalogoDdObject? catalogoEstado;
  CatalogoDdObject? catalogoMunicipio;

  List<ElementoDd> listaPla = List<ElementoDd>.empty(growable: true);
  List<ElementoDd> listaPol = List<ElementoDd>.empty(growable: true);
  List<ElementoDd> listaTClin = List<ElementoDd>.empty(growable: true);
  List<ElementoDd> listaCM = List<ElementoDd>.empty(growable: true);
  List<ElementoDd> listaEsp = List<ElementoDd>.empty(growable: true);
  List<ElementoDd> listaEst = List<ElementoDd>.empty(growable: true);
  List<ElementoDd> listaMun = List<ElementoDd>.empty(growable: true);
  List<ElementoDd> listaOServ = List<ElementoDd>.empty(growable: true);

  List<CirculoMedico>? circulosList;
  CirculoMedico? currentCirculo;

  List<Especialidad>? especialidadList;
  Especialidad? currentEspecialidad;

  List<TipoClinica>? clinicasEncontradas;
  TipoClinica? tclinicaSelected;

  List<TipoServicios>? tipoServiciosList;
  TipoServicios? currentTipoServicio;

  List<Planes>? planesList;
  Planes? currentPlan;

  List<String>? serviciosList;
  String? currentServicio;

  List<Estados>? estadosList;
  Estados? currentEstado;

  List<Municipios>? municipiosList;
  Municipios? currentMunicipio;

  List<PolizasUsuario>? listaPolizasUsuarios;
  late PolizasUsuario currentPoliza;
  late PolizasUsuario PolizaSeleccionaDropdown;
  PolizasUsuario sinPoliza = PolizasUsuario(
      nombres: "NA",
      apePaterno: "NA",
      apeMaterno: "NA",
      numPoliza: "Sin póliza",
      circuloMedico: "NA",
      planComercial: "NA",
      cvePlanComercial: "NA",
      cveCirculoMedico: "NA",
      cveProdComercial: "NA",
      cveProdTecnico: "NA");

  String tituloAppbar = "";
  Parametros? datos;
  final inputNombreController = TextEditingController();
  String _especialidades = "";
  String _hospitales = "";
  String _clinicas = "";
  String _otrosServicios = "";
  String textoPredictivo = "";
  String nombrPolizatxt = "";
  bool circuloContratado = false;
  bool planContratado = false;
  String? cvNivelHosp = "";

  dynamic hospitalesSearchEntity = new Hospitales();
  dynamic otrosServiciosSearchEntity = new OtServiciosM();
  dynamic clinicasSearchEntity = new Clinicas();
  dynamic especialidadSearchEntity = new Especialidad();

  final TextEditingController _especialidadSearch = TextEditingController();
  final TextEditingController _hospitalesSearch = TextEditingController();
  final TextEditingController _clinicasSearch = TextEditingController();
  final TextEditingController _otrosServiciosSearch = TextEditingController();
  String? _nombreAseguradoPoliza = '';

  final TextEditingController _busquedaPoliza = TextEditingController();

  ConfiguracionDd config = ConfiguracionDd(
      selectedTextItemColor: AppColors
          .secondary900, // Color del texto del elemento seleccionado de la lista de opciones
      textItemColor: AppColors
          .gnpTextSystem, //Color por defecto de todos los elementos de la lista de opciones cuando no se han seleccionado
      defaultSelectedIndex: 0, //El que se muestra por defecto
      labelColorActive:
          AppColors.secondary900, //color del label cuando esta abierto
      listSize: 150, //la altura de la lista desplegable (que tiene scroll)
      innnerMargin:
          10, // margen interno entre la label, y el borde. Margen el icono y el borde
      dropdownSize: 70, // La altura del boton que despliega la lista, DOUBLE
      labelColor:
          AppColors.colorVisibilty, // Color del label cuando no está activo
      borderColor: AppColors.primary200, //Color del borde cuando no está activo
      activeBorderColor: AppColors
          .secondary900, // Color del borde del boton que despliega la lista cuando está abierta
      borderSize: 1, //linea inferior
      dropdownBackgroundColor:
          Colors.white, // El background del boton que despliega la lista
      selectedColor: AppColors.secondary50, //Color del elemento seleccionado
      icon: Icon(Icons.arrow_drop_down, color: AppColors.gnpTextSystem2));

  DirectorioSearchControllerState(TipoServicio? servicio) {
    this.presenter = DirectorioSearchPresenter(this);
    this.servicio = servicio;
  }

  onchange() {
    setState(() {
      //actualizar catalogo municipio
      print(estadosList![catalogoEstado!.selectedItem!].claveEstado);
      if (Utils.cvEstado != catalogoEstado!.selectedItem &&
          catalogoEstado!.label == "Estado") {
        Utils.cvEstado = catalogoEstado!.selectedItem!;
        Utils.listMunicipios.clear();
        catalogoMunicipio!.valores!.clear();
        catalogoMunicipio!.selectedItem = 0;
        presenter!
            .getMunicipios(estadosList![Utils.cvEstado].claveEstado!)
            .then((value) => (municipiosList = Utils.listMunicipios))
            .then((value) => municipiosList!.forEach((j) {
                  setState(() {});
                  for (var item in listaMun == null ? 0 as Iterable : listaMun) {
                    if (j.municipio == item.valor) {
                      existeElement = true;
                      break;
                    }
                  }
                  if (!existeElement) {
                    listaMun.add(ElementoDd(valor: j.municipio));
                  }
                  existeElement = false;
                }))
            .then((value) => (print("nueva lista")));
      }
    });
  }

  onchangePolizas() {
    if (listaPolizasUsuarios!.length > 0) {
      setState(() {
        //actualizar catalogo polizas
        listaPol.clear();
        listaPolizasUsuarios!.forEach((element) {
          for (var item in listaPol == null ? 0 as Iterable : listaPol) {
            if (element.numPoliza == item.valor) {
              existeElement = true;
              break;
            }
          }
          if (!existeElement) {
            listaPol.add(ElementoDd(valor: element.numPoliza));
          }
          existeElement = false;
        });
        if (tituloAppbar == "Médicos") {
          if (mostrarDropdownPolizas) {
            PolizaSeleccionaDropdown = listaPolizasUsuarios![
                catalogoDos!.selectedItem == null
                    ? 0
                    : catalogoDos!.selectedItem!];
            if (Utils.circuloPoliza != PolizaSeleccionaDropdown.circuloMedico) {
              Utils.circuloPoliza = PolizaSeleccionaDropdown.circuloMedico!;
              listaCM.clear();
              catalogoTres!.selectedItem = 0;
              if (PolizaSeleccionaDropdown.circuloMedico != "NA") {
                listaCM.add(ElementoDd(
                    valor: PolizaSeleccionaDropdown.circuloMedico! +
                        " - contratado"));
              }
              circulosList!.forEach((element) {
                for (var item in listaCM == null ? 0 as Iterable : listaCM) {
                  if (element.circuloMedico == item.valor ||
                      element.circuloMedico! + " - contratado" == item.valor) {
                    existeElement = true;
                    break;
                  }
                }
                if (!existeElement) {
                  listaCM.add(ElementoDd(valor: element.circuloMedico));
                }
                existeElement = false;
              });
            }
            catalogoTres = CatalogoDdObject(
                label: "Círculo médico",
                valores: listaCM,
                config: config,
                selectedItem: catalogoTres == null
                    ? 0
                    : catalogoTres!.selectedItem == null
                        ? 0
                        : catalogoTres!.selectedItem);
            catalogoDos = CatalogoDdObject(
                label: "Número de póliza",
                valores: listaPol,
                config: config,
                onChange: onchangePolizas,
                selectedItem: catalogoDos == null
                    ? 0
                    : catalogoDos!.selectedItem == null
                        ? 0
                        : catalogoDos!.selectedItem);
          } else {
            catalogoDos = CatalogoDdObject(
                label: "Número de póliza",
                valores: listaPol,
                config: config,
                onChange: onchangePolizas);
          }
        } else if (tituloAppbar == "Hospitales") {
          if (mostrarDropdownPolizas) {
            PolizaSeleccionaDropdown = listaPolizasUsuarios![
                catalogoUno!.selectedItem == null
                    ? 0
                    : catalogoUno!.selectedItem!];
            if (Utils.planPoliza != PolizaSeleccionaDropdown.planComercial ||
                PolizaSeleccionaDropdown.planComercial!.contains("   ")) {
              Utils.planPoliza = PolizaSeleccionaDropdown.planComercial!;
              listaPla.clear();
              catalogoDos!.selectedItem = 0;
              if (PolizaSeleccionaDropdown.planComercial != "NA") {
                var texto;
                if (PolizaSeleccionaDropdown.planComercial!.contains("  ")) {
                  texto = PolizaSeleccionaDropdown.planComercial;
                } else {
                  texto =
                      PolizaSeleccionaDropdown.planComercial! + " - contratado";
                  texto = texto.length > 29
                      ? texto.replaceAll(" - contratado", " - c...")
                      : texto;
                }

                listaPla.add(ElementoDd(valor: texto));
              }
              planesList!.forEach((element) {
                for (var item in listaPla == null ? 0 as Iterable : listaPla) {
                  if (element.plan == item.valor ||
                      element.plan! + " - contratado" == item.valor) {
                    existeElement = true;
                    break;
                  }
                }
                if (!existeElement) {
                  listaPla.add(ElementoDd(valor: element.plan));
                }
                existeElement = false;
              });
            }
            catalogoDos = CatalogoDdObject(
                label: "Plan hospitalario",
                valores: listaPla,
                config: config,
                selectedItem: catalogoDos == null
                    ? 0
                    : catalogoDos!.selectedItem == null
                        ? 0
                        : catalogoDos!.selectedItem);
            catalogoUno = CatalogoDdObject(
                label: "Número de póliza",
                valores: listaPol,
                config: config,
                onChange: onchangePolizas,
                selectedItem: catalogoUno == null
                    ? 0
                    : catalogoUno!.selectedItem == null
                        ? 0
                        : catalogoUno!.selectedItem);
          } else {
            catalogoUno = CatalogoDdObject(
                label: "Número de póliza",
                valores: listaPol,
                config: config,
                onChange: onchangePolizas);
          }
        }

        print("nueva lista");
      });
    }
  }

  onChangedropDrop(PolizasUsuario poliza) {
    //00000026248898
    setState(() {
      if (tituloAppbar == "Médicos") {
        //actualizar catalogo circulos
        print(poliza.circuloMedico);
        if (Utils.circuloPoliza != poliza.circuloMedico) {
          Utils.circuloPoliza = poliza.circuloMedico!;
          listaCM.clear();
          catalogoTres!.selectedItem = 0;
          if (poliza.circuloMedico != "NA") {
            listaCM
                .add(ElementoDd(valor: poliza.circuloMedico! + " - contratado"));
          }
          circulosList!.forEach((element) {
            for (var item in listaCM == null ? 0 as Iterable : listaCM) {
              if (element.circuloMedico == item.valor ||
                  element.circuloMedico! + " - contratado" == item.valor) {
                existeElement = true;
                break;
              }
            }
            if (!existeElement) {
              listaCM.add(ElementoDd(valor: element.circuloMedico));
            }
            existeElement = false;
          });
          print("nueva lista");
        }
      }

      if (tituloAppbar == "Hospitales") {
        //actualizar catalogo planes
        print(poliza.planComercial);
        if (Utils.planPoliza != poliza.planComercial) {
          Utils.planPoliza = poliza.planComercial!;
          listaPla.clear();
          catalogoDos!.selectedItem = 0;
          if (poliza.planComercial != "NA") {
            //nuevo proceso para reemplazar
            var texto;
            if (poliza.planComercial!.contains("   ")) {
              texto = poliza.planComercial;
            } else {
              texto = poliza.planComercial! + " - contratado";
              texto = texto.length > 29
                  ? texto.replaceAll(" - contratado", " - c...")
                  : texto;
            }

            listaPla.add(ElementoDd(valor: texto));
            // anterior listaPla.add(ElementoDd(valor: poliza.planComercial + " - contratado"));
          }
          planesList!.forEach((element) {
            for (var item in listaPla == null ? 0 as Iterable : listaPla) {
              if (element.plan == item.valor ||
                  element.plan! + " - contratado" == item.valor) {
                existeElement = true;
                break;
              }
            }
            if (!existeElement) {
              listaPla.add(ElementoDd(valor: element.plan));
            }
            existeElement = false;
          });
          print("nueva lista");
        }
      }
    });
  }

  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    didChangeDependencies();

    gestionroles = GestionRoles.generarIntancia();

    Utils.cvEstado = -1;
    Utils.circuloPoliza = "";
    Utils.planPoliza = "";
    Utils.vistaDirectorio = "search";
    Utils.listPersonasPoliza.clear();

    if (Utils.listTClinicas.isEmpty) {
      Future.delayed(Duration.zero, () {
        presenter?.getClinicas();
      });
    } else {
      setState(() {
        clinicasEncontradas = Utils.listTClinicas;
      });
    }
    if (Utils.listEstados.isEmpty) {
      Future.delayed(Duration.zero, () {
        presenter?.getEstados();
        if (estadosList!.isNotEmpty) {
          if (Utils.listMunicipios.isEmpty) {
            presenter?.getMunicipios(estadosList![0].claveEstado!);
          } else {
            setState(() {
              municipiosList = Utils.listMunicipios;
            });
          }
        }
      });
    } else {
      setState(() {
        estadosList = Utils.listEstados;
        if (estadosList!.isNotEmpty) {
          if (Utils.listMunicipios.isEmpty) {
            presenter?.getMunicipios(estadosList![0].claveEstado!);
          } else {
            setState(() {
              municipiosList = Utils.listMunicipios;
            });
          }
        }
      });
    }

    if (Utils.listPlanes == null || Utils.listPlanes.isEmpty) {
      presenter?.getPlanes();
    } else {
      setState(() {
        planesList = Utils.listPlanes;
      });
    }
    if (Utils.listCirculos.isEmpty) {
      Future.delayed(Duration.zero, () {
        presenter?.getCirculosM();
      });
    } else {
      setState(() {
        circulosList = Utils.listCirculos;
      });
    }
    if (Utils.listEspecialidades.isEmpty) {
      Future.delayed(Duration.zero, () {
        presenter?.getEspecialidades();
      });
    } else {
      setState(() {
        especialidadList = Utils.listEspecialidades;
      });
    }

    if (Utils.listTServicios.isEmpty) {
      Future.delayed(Duration.zero, () {
        presenter?.getTipoServicio();
      });
    } else {
      setState(() {
        tipoServiciosList = Utils.listTServicios;
      });
    }

    switch (this.servicio) {
      case TipoServicio.Medicos:
        tituloAppbar = "Médicos";
        currentContent = getMedicosSearchMenu();
        break;
      case TipoServicio.Hospitales:
        tituloAppbar = "Hospitales";
        currentContent = getHospitalesSearchMenu();
        break;
      case TipoServicio.Clinicas:
        tituloAppbar = "Clínicas";
        currentContent = getClinicasSearchMenu();
        break;
      case TipoServicio.OtrosServ:
        tituloAppbar = "Otros servicios de salud";
        currentContent = getOtrosServSearchMenu();
        break;

      case TipoServicio.Modulos:
        currentContent = getModulosSearchMenu();
        break;
      default: 
    }
  }

  @override
  Widget build(BuildContext context) {
    print(this.servicio);
    switch (this.servicio) {
      case TipoServicio.Medicos:
        tituloAppbar = "Médicos";
        return getMedicosSearchMenu();
        break;
      case TipoServicio.Hospitales:
        tituloAppbar = "Hospitales";
        return getHospitalesSearchMenu();
        break;
      case TipoServicio.Clinicas:
        tituloAppbar = "Clínicas";
        return getClinicasSearchMenu();
        break;
      case TipoServicio.OtrosServ:
        tituloAppbar = "Otros servicios de salud";
        return getOtrosServSearchMenu();
        break;

      case TipoServicio.Modulos:
        return getModulosSearchMenu();
        break;
    }
    return Container();
  }

  Scaffold getMedicosSearchMenu() {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.orange),
          title: Text(
            "Médicos",
            style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.dirTextColor),
          ),
          elevation: 0.0,
          surfaceTintColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              presenter!.backToHome();
            },
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DirectorioController(),
                ));
            return false;
          },
          child: Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            color: Colors.white,
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: [
                Container(
                    color: Colors.white,
                    child : new TypeAheadField(
                      builder: (context, controller, focusNode) {
                        return TextField(
                          controller: _especialidadSearch,
                          focusNode: focusNode,
                          textCapitalization: TextCapitalization.characters,
                          autofocus: false,
                          style: TextStyle(
                            color: AppColors.textDropdown,
                            fontSize: 16,
                            fontFamily: "Roboto-Medium",
                            fontWeight: FontWeight.normal
                          ),
                          decoration: InputDecoration(
                          hintText: "Buscar por especialidad",
                          hintStyle: TextStyle(
                              color: AppColors.gnpTextSystem2,
                              fontSize: 16,
                              fontFamily: 'Roboto-Medium',
                              fontWeight: FontWeight.normal),
                          counter: SizedBox(
                            width: 0,
                            height: 0,
                          ),
                          border: OutlineInputBorder(
                              borderSide: new BorderSide(
                                  color: AppColors.primary200, width: 0.0)),
                          prefixIcon: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: AppColors.gnpTextSystem2,
                              ),
                              onPressed: null),
                          fillColor: AppColors.primary200,
                          enabledBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(4.0),
                            borderSide: new BorderSide(
                                color: AppColors.primary200, width: 0.0),
                          ),
                          focusedBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(4.0),
                            borderSide: new BorderSide(
                                color: AppColors.primary200, width: 0.0),
                          ),
                        ),
                        onEditingComplete: () {
                           var data = this._especialidadSearch.value.text;
                          _especialidades = data;
                          if (_especialidades != "") {
                            var datos = Parametros(
                              origen: "cliente",
                              cvEspecialidad: "0",
                              buscador: _especialidades != null
                                  ? _especialidades
                                  : "",
                              cvMunicipio: "0",
                              pagina: 0,
                            );
                            Utils.lbBuscador = true;
                            //ENVIA A LA VISTA DE RESULTADOS
                            presenter!.showSearch("Médicos en convenio", "", "",
                                _especialidades, "", "", datos, "");
                          }
                        },
                        );
                      },
                      offset: Offset(5.0, 0),
                      itemBuilder: (context, dynamic suggestion) {
                        if (suggestion.especialidad
                            .toString()
                            .contains(textoPredictivo)) {
                          return new Row(children: [
                            Expanded(
                                child: ListTile(
                                    title: Text(suggestion.especialidad)))
                          ]);
                        } else {
                          return new Row();
                        }
                      },
                      onSelected: (dynamic suggestion) {
                        var data = suggestion.especialidad.toString();
                        this._especialidadSearch.text = data;
                        especialidadSearchEntity = suggestion;
                        _especialidades = data;
                        if (_especialidades != "") {
                          var datos = Parametros(
                            origen: "intermediarios",
                            cvEspecialidad: especialidadSearchEntity
                                .claveEspecialidad, //"0",
                            buscador:
                                _especialidades != null ? _especialidades : "",
                            cvMunicipio: "0",
                            pagina: 0,
                            dateTime: DateTime.now(),
                          );
                          Utils.lbBuscador = true;
                          //ENVIA A LA VISTA DE RESULTADOS
                          presenter!.showSearch("Médicos en convenio", "", "",
                              _especialidades, "", "", datos, "");
                        }
                      },
                      suggestionsCallback: (pattern) async {
                        textoPredictivo = pattern.toUpperCase();
                        return presenter!.getEspecialidades();
                      },
                      emptyBuilder: (context) => _sinResultados(context),
                    )),
                seleccionaMedicos()!,
              ],
            ),
          ),
        ));
  }

  Scaffold getHospitalesSearchMenu() {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.orange),
          title: Text(
            "Hospitales en convenio",
            style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.dirTextColor),
          ),
          elevation: 0.0,
          surfaceTintColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              presenter!.backToHome();
            },
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DirectorioController(),
                ));
            return false;
          },
          child: Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            color: Colors.white,
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: [
                Container(
                    color: Colors.white,
                    child: new TypeAheadField(
                      builder: (context, controller, focusNode) {
                        return TextField(
                          controller: _hospitalesSearch,
                          focusNode: focusNode,
                          autofocus: false,
                          style: TextStyle(
                            color: AppColors.textDropdown,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                        decoration: InputDecoration(
                          hintText: "Buscar por nombre del hospital",
                          hintStyle: TextStyle(
                              color: AppColors.colorVisibilty,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                          counter: SizedBox(
                            width: 0,
                            height: 0,
                          ),
                          border: OutlineInputBorder(
                            borderSide: new BorderSide(
                              color: AppColors.primary200, 
                              width: 0.0
                            )
                          ),
                          prefixIcon: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: AppColors.gnpTextSystem2,
                              ),
                              onPressed: null),
                          fillColor: AppColors.primary200,
                          enabledBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(4.0),
                            borderSide: new BorderSide(
                                color: AppColors.primary200, width: 0.0),
                          ),
                          focusedBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(4.0),
                            borderSide: new BorderSide(
                                color: AppColors.primary200, width: 0.0),
                          ),
                        ),
                        onEditingComplete: () {
                          var data = this._hospitalesSearch.value.text;
                          _hospitales = data;
                          if (_hospitales != "") {
                            var datos2 = Parametros(
                              nombreComercial:
                                  _hospitales != null ? _hospitales : "",
                              pagina: 0,
                            );
                            Utils.lbBuscador = true;
                            presenter!.showSearch("Hospitales en convenio", "",
                                "", _hospitales, "", "", datos2, "");
                          }
                        },
                        );
                      },
                      offset: Offset(5.0, 0),
                      itemBuilder: (context, dynamic suggestion) {
                        if (suggestion.nombreComercial
                            .toString()
                            .contains(textoPredictivo)) {
                          return new Row(children: [
                            Expanded(
                                child: ListTile(
                                    title: Text(suggestion.nombreComercial)))
                          ]);
                        } else {
                          return new Row();
                        }
                      },
                      onSelected: (dynamic suggestion) {
                        var data = suggestion.nombreComercial.toString();
                        this._hospitalesSearch.text = data;

                        hospitalesSearchEntity = suggestion;
                        _hospitales = data;
                        if (_hospitales != "") {
                          var datos2 = Parametros(
                            nombreComercial: hospitalesSearchEntity
                                .nombreComercial
                                .toString(),
                            pagina: 0,
                            dateTime: DateTime.now(),
                          );
                          Utils.lbBuscador = true;
                          presenter!.showSearch("Hospitales en convenio", "", "",
                              _hospitales, "", "", datos2, "");
                        }
                      }, 
                      suggestionsCallback: (pattern) async {
                        textoPredictivo = pattern.toUpperCase();
                        return presenter!.getHospitalesList();
                      },
                      )),
                seleccionaDdHospitales()!,
              ],
            ),
          ),
        ));
  }

  Scaffold getClinicasSearchMenu() {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.orange),
          title: Text(
            "Clínicas en convenio",
            style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.dirTextColor),
          ),
          elevation: 0.0,
          surfaceTintColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              presenter!.backToHome();
            },
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            Navigator.of(context).push(PageRouteBuilder(
                opaque: false,
                pageBuilder: (BuildContext context, _, __) {
                  return DirectorioController();
                }));

            return false;
          },
          child: Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            color: Colors.white,
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: [
                Container(
                    color: Colors.white,
                    child: TypeAheadField(
                      builder: (context, controller, focusNode) {
                        return TextField(
                          controller: _clinicasSearch,
                          focusNode: focusNode,
                          autofocus: false,
                          style: TextStyle(
                            color: AppColors.textDropdown,
                            fontSize: 16,
                            fontFamily: "Roboto-Medium",
                            fontWeight: FontWeight.normal
                          ),
                          decoration: InputDecoration(
                          hintText: "Buscar por nombre de la clínica",
                          hintStyle: TextStyle(
                              color: AppColors.gnpTextSystem2,
                              fontSize: 16,
                              fontFamily: 'Roboto-Medium',
                              fontWeight: FontWeight.normal),
                          counter: SizedBox(
                            width: 0,
                            height: 0,
                          ),
                          border: OutlineInputBorder(
                              borderSide: new BorderSide(
                                  color: AppColors.primary200, width: 0.0)),
                          prefixIcon: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: AppColors.gnpTextSystem2,
                              ),
                              onPressed: null),
                          fillColor: AppColors.primary200,
                          enabledBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(4.0),
                            borderSide: new BorderSide(
                                color: AppColors.primary200, width: 0.0),
                          ),
                          focusedBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(4.0),
                            borderSide: new BorderSide(
                                color: AppColors.primary200, width: 0.0),
                          ),
                        ),
                        onEditingComplete: () {
                          var data = this._clinicasSearch.value.text;
                          _clinicas = data;
                          if (_clinicas != "") {
                            var datos2 = Parametros(
                              nombreComercial: _clinicas,
                              buscador: _clinicas != null ? _clinicas : "",
                              pagina: 0,
                            );
                            Utils.lbBuscador = true;
                            presenter!.showSearch("Clínicas en convenio", "", "",
                                _clinicas, "", "", datos2, "");
                            }
                          },
                        );
                      },
                      offset: Offset(5.0, 0),
                      itemBuilder: (context, dynamic suggestion) {
                        if (suggestion.nombreComercial
                            .toString()
                            .contains(textoPredictivo)) {
                          return new Row(children: [
                            Expanded(
                                child: ListTile(
                                    title: Text(suggestion.nombreComercial)))
                          ]);
                        } else {
                          return new Row();
                        }
                      }, 
                      onSelected: (dynamic suggestion) {
                        var data = suggestion.nombreComercial.toString();
                        this._clinicasSearch.text = data;
                        clinicasSearchEntity = suggestion;
                        _clinicas = data;
                        if (_clinicas != "") {
                          var datos2 = Parametros(
                            nombreComercial:
                                clinicasSearchEntity.nombreComercial.toString(),
                            buscador: _clinicas != null ? _clinicas : "",
                            pagina: 0,
                            dateTime: DateTime.now(),
                          );
                          Utils.lbBuscador = true;
                          presenter!.showSearch("Clínicas en convenio", "", "",
                              _clinicas, "", "", datos2, "");
                        }
                      }, 
                       suggestionsCallback: (pattern) async {
                        textoPredictivo = pattern.toUpperCase();
                        try {
                          return presenter!.getClinicasList();
                        } catch(e) {
                          return [];
                        }
                      },
                    )),
                seleccionaClinicas()!,
              ],
            ),
          ),
        ));
  }

  Scaffold getOtrosServSearchMenu() {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.orange),
          title: Text(
            "Otros servicios de salud",
            style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.dirTextColor),
          ),
          elevation: 0.0,
          surfaceTintColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              presenter!.backToHome();
            },
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DirectorioController(),
                ));
            return false;
          },
          child: Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            color: Colors.white,
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: [
                Container(
                    color: Colors.white,
                    child: TypeAheadField(
                      builder: (context, controller, focusNode) {
                        return TextField(
                          controller: _otrosServiciosSearch,
                          focusNode: focusNode,
                          autofocus: false,
                          style: TextStyle(
                            color: AppColors.textDropdown,
                            fontSize: 16,
                            fontFamily: "Roboto-Medium",
                            fontWeight: FontWeight.normal
                          ),
                          decoration: InputDecoration(
                          hintText: "Buscar por nombre...",
                          hintStyle: TextStyle(
                            color: AppColors.gnpTextSystem2,
                            fontSize: 16,
                            fontFamily: 'Roboto-Medium',
                            fontWeight: FontWeight.normal
                          ),
                          counter: SizedBox(
                            width: 0,
                            height: 0,
                          ),
                          border: OutlineInputBorder(
                              borderSide: new BorderSide(
                                  color: AppColors.primary200, width: 0.0)),
                          prefixIcon: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: AppColors.gnpTextSystem2,
                              ),
                              onPressed: null),
                          fillColor: AppColors.textDropdown,
                          enabledBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(4.0),
                            borderSide: new BorderSide(
                                color: AppColors.primary200, width: 0.0),
                          ),
                          focusedBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(4.0),
                            borderSide: new BorderSide(
                                color: AppColors.primary200, width: 0.0),
                          ),
                        ),
                          onEditingComplete: () {
                            var data = this._otrosServiciosSearch.value.text;
                            _otrosServicios = data;
                            if (_otrosServicios != "") {
                              var datos2 = Parametros(
                                nombre: _otrosServicios,
                                cvTipo: "",
                                buscador: _otrosServicios != null
                                  ? _otrosServicios
                                  : "",
                                cvEstado: "",
                                cvMunicipio: "",
                                origen: "GNPMovil",
                                pagina: 0,
                              );
                              Utils.lbBuscador = true;
                              presenter!.showSearch("Otros servicios de salud", "",
                                  "", _otrosServicios, "", "", datos2, "");
                            }
                          },
                        );
                      },
                      offset: Offset(5.0, 0),
                      itemBuilder: (context, dynamic suggestion) {
                        if (suggestion.nombreComercial
                            .toString()
                            .contains(textoPredictivo)) {
                          return new Row(children: [
                            Expanded(
                                child: ListTile(
                                    title: Text(suggestion.nombreComercial)))
                          ]);
                        } else {
                          return new Row();
                        }
                      }, 
                      onSelected: (dynamic suggestion) {
                        var data = suggestion.nombreComercial.toString();
                        this._otrosServiciosSearch.text = data;
                        otrosServiciosSearchEntity = suggestion;
                        _otrosServicios = data;
                        if (_otrosServicios != "") {
                          var datos2 = Parametros(
                            claveGestion:
                                otrosServiciosSearchEntity.claveGestion,
                            nombre: "",
                            cvTipo: "",
                            buscador:
                                _otrosServicios != null ? _otrosServicios : "",
                            cvEstado: "",
                            cvMunicipio: "",
                            origen: "APPAgentes",
                            pagina: 0,
                            dateTime: DateTime.now(),
                          );
                          Utils.lbBuscador = true;
                          presenter!.showSearch("Otros servicios de salud", "",
                              "", _otrosServicios, "", "", datos2, "");
                        }
                      }, 
                      suggestionsCallback: (pattern) async {
                        textoPredictivo = pattern.toUpperCase();
                        return presenter!.getOtrosServiciosMedicosList();
                      },
                    )),
                seleccionaTServicio()!,
              ],
            ),
          ),
        ));
  }

  Scaffold getModulosSearchMenu() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.orange),
        title: Text(
          "Módulos GNP",
          style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.dirTextColor),
        ),
        elevation: 0.0,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            presenter!.backToHome();
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DirectorioController(),
              ));
          return false;
        },
        child: Container(
          padding: EdgeInsets.only(top: 0, left: 20, right: 20),
          color: Colors.white,
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: [
              seleccionaModulos()!,
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 370.0, left: 0, right: 0),
                      child: Divider(
                        thickness: 1,
                        color: AppColors.scrollbar,
                        height: 60,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 16.0, right: 16, left: 16),
        child: ButtonTheme(
          minWidth: 400.0,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.secondary900,
              foregroundColor: Colors.white,
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6)
              )
            ),
              child: Text(
                "Buscar",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    fontFamily: 'Roboto-Bold'),
              ),
              onPressed: () {
                catalogoEstado!.selectedItem =
                    catalogoEstado!.selectedItem == null
                        ? 0
                        : catalogoEstado!.selectedItem;
                if (estadosList![catalogoEstado!.selectedItem!].estado ==
                    "Todos") {
                  currentEstado = Estados(claveEstado: "", estado: "");
                } else {
                  currentEstado = estadosList!.length != 0
                      ? estadosList![catalogoEstado!.selectedItem!]
                      : null;
                }

                var datos2 = Parametros(
                  cvEstado:
                      estadosList![catalogoEstado!.selectedItem!].claveEstado,
                  dateTime: DateTime.now(),
                );

                if (currentEstado != null) {
                  AnalyticsServices().sendTag("dir_modulos_gnp");
                  Map<String, dynamic> eventos = {
                    "estado": estadosList![catalogoEstado!.selectedItem!].estado,
                  };
                  AnalyticsServices()
                      .sendTag("dir_modulos_localizacion", parameters: eventos);

                  presenter!
                      .sendAnalytics(
                          "Módulos GNP",
                          "",
                          "",
                          estadosList![catalogoEstado!.selectedItem!].estado!,
                          "",
                          "")
                      .then((value) => presenter!.showSearch(
                          "Módulos GNP",
                          "",
                          "",
                          "",
                          estadosList![catalogoEstado!.selectedItem!].estado!,
                          "",
                          datos2,
                          ""));
                } else {
                  customAlert(AlertDialogType.errorConexion, context, "", "");
                }
              }),
        ),
      ),
    );
  }

  Widget loadingPicker(valor) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 150.0, bottom: 150.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 60.0,
              height: 60.0,
              child: CircularProgressIndicator(
                //backgroundColor: Colors.orange,
                valueColor: AlwaysStoppedAnimation(AppColors.azulGNP),
                // strokeWidth: 5.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget? seleccionaModulos() {
    try {
      if (estadosList != null) {
        return dropdownModulos(estadosList!);
      } else {
        var estado = presenter!.getEstados();

        return FutureBuilder(
          future: Future.wait([estado]),
          builder: (context, snapshot) {
            for (int i = 0; i < 1; i++) {
              var current = i == 0 ? estado : null;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return loadingPicker(current);
                default:
                  if (snapshot.hasError) {
                    return loadingPicker(current);
                  } else {
                    switch (i) {
                      case 0:
                        estadosList = snapshot.data![i];
                        break;
                    }
                  }
              }
            }

            return dropdownModulos(estadosList!);
          },
        );
      }
    } catch (e) {
      print(e);
    }
    return SizedBox();
  }

  Widget dropdownModulos(List<Estados> estados) {
    estados.forEach((i) {
      for (var item in listaEst == null ? 0 as Iterable : listaEst) {
        if (i.estado == item.valor) {
          existeElement = true;
          break;
        }
      }
      if (!existeElement) {
        listaEst.add(ElementoDd(valor: i.estado));
      }
      existeElement = false;
    });

    catalogoEstado =
        CatalogoDdObject(label: "Estado", valores: listaEst, config: config);

    return Stack(
      children: <Widget>[
        //COMBO 2
        Padding(
          // El custom Dropdown
          padding: const EdgeInsets.only(top: 0.0),
          child: Container(
              margin: EdgeInsets.only(
                  top: catalogoEstado!.config!.dropdownSize! * 1 - 43),
              child: GeneraCatalogo(
                dataObject: catalogoEstado,
                refresh: refresh,
                idDropdown: 5,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Container(
            margin:
                EdgeInsets.only(top: catalogoEstado!.config!.dropdownSize! - 47),
            child: Text("LOCALIZACIÓN",
                style: TextStyle(
                    color: AppColors.colorVisibilty,
                    fontSize: 10,
                    fontWeight: FontWeight.w500)),
          ),
        ),

        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Container(
                    margin: EdgeInsets.only(
                        top: catalogoEstado!.config!.dropdownSize! * 1 - 70),
                    child: Divider(
                      thickness: 1,
                      color: AppColors.divider,
                      height: 20,
                    )),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget? seleccionaMedicos() {
    try {
      if ((circulosList != null) &&
          (especialidadList != null) &&
          (estadosList != null) &&
          (municipiosList != null)) {
        return dropdownMedicos(
            circulosList!, especialidadList!, estadosList!, municipiosList!);
      } else {
        var circulo = presenter!.getCirculosM();
        var especialidad = presenter!.getEspecialidades();
        var estado = presenter!.getEstados();
        var municipio = presenter!.getMunicipios(estadosList![0].claveEstado!);

        return FutureBuilder(
          future: Future.wait([circulo, especialidad, estado, municipio]),
          builder: (context, snapshot) {
            for (int i = 0; i < 4; i++) {
              var current = i == 0
                  ? circulo
                  : i == 1 ? especialidad : i == 2 ? estado : municipio;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return loadingPicker(current);
                default:
                  if (snapshot.hasError) {
                    return loadingPicker(current);
                  } else {
                    switch (i) {
                      case 0:
                        circulosList =
                            snapshot.data![i] != null ? snapshot.data![i] as List<CirculoMedico>? : 0 as List<CirculoMedico>?;
                        break;
                      case 1:
                        especialidadList =
                            snapshot.data![i] != null ? snapshot.data![i] as List<Especialidad>? : 0 as List<Especialidad>?;
                        break;
                      case 2:
                        estadosList =
                            snapshot.data![i] != null ? snapshot.data![i] as List<Estados>? : 0 as List<Estados>?;
                        break;
                      case 3:
                        municipiosList =
                            snapshot.data![i] != null ? snapshot.data![i] as List<Municipios>? : 0 as List<Municipios>?;
                    }
                  }
              }
            }

            return dropdownMedicos(
                circulosList!, especialidadList!, estadosList!, municipiosList!);
          },
        );
      }
    } catch (e) {
      print(e);
    }
    return SizedBox();
  }

  Widget dropdownMedicos(
    List<CirculoMedico> circulos,
    List<Especialidad> especialidades,
    List<Estados> estados,
    List<Municipios> municipios,
  ) {
    if (listaPolizasUsuarios == null) {
      Utils.listPolizaUsuarios.clear();
      listaPolizasUsuarios = Utils.listPolizaUsuarios;
    }
    listaPolizasUsuarios!.forEach((element) {
      for (var item in listaPol == null ? 0 as Iterable : listaPol) {
        if (element.numPoliza == item.valor) {
          existeElement = true;
          break;
        }
      }
      if (!existeElement) {
        listaPol.add(ElementoDd(valor: element.numPoliza));
      }
      existeElement = false;
    });
    catalogoDos = CatalogoDdObject(
        label: "Número de póliza",
        valores: listaPol,
        config: config,
        onChange: onchangePolizas(),
        selectedItem: catalogoDos == null
            ? 0
            : catalogoDos!.selectedItem == null ? 0 : catalogoDos!.selectedItem);

    circulos.forEach((circle) {
      final existsE = listaCM.any((e) {
        final v = e.valor;
        final c = circle.circuloMedico!;
        return c == v || c + " - contratado" == v;
      });
      if (!existsE) {
        listaCM.add(ElementoDd(valor: circle.circuloMedico));
      }
    });
    catalogoTres = CatalogoDdObject(
        label: "Círculo o tabulador médico",
        valores: listaCM,
        config: config,
        selectedItem: catalogoTres == null
            ? 0
            : catalogoTres!.selectedItem == null
                ? 0
                : catalogoTres!.selectedItem);

    especialidades.forEach((value) {
      for (var item in listaEsp == null ? 0 as Iterable : listaEsp) {
        if (value.especialidad == item.valor) {
          existeElement = true;
          break;
        }
      }
      if (!existeElement) {
        listaEsp.add(ElementoDd(valor: value.especialidad));
      }
      existeElement = false;
    });

    catalogoCuatro = CatalogoDdObject(
        label: "Especialidad",
        valores: listaEsp,
        config: config,
        selectedItem: catalogoCuatro == null
            ? 0
            : catalogoCuatro!.selectedItem == null
                ? 0
                : catalogoCuatro!.selectedItem);

    estados.forEach((i) {
      for (var item in listaEst == null ? 0 as Iterable : listaEst) {
        if (i.estado == item.valor) {
          existeElement = true;
          break;
        }
      }
      if (!existeElement) {
        listaEst.add(ElementoDd(valor: i.estado));
      }
      existeElement = false;
    });
    catalogoEstado = CatalogoDdObject(
        label: "Estado",
        valores: listaEst,
        config: config,
        selectedItem: Utils.cvEstado != -1
            ? Utils.cvEstado
            : catalogoEstado == null
                ? 0
                : catalogoEstado!.selectedItem == null
                    ? 0
                    : catalogoEstado!.selectedItem);

    municipios.forEach((j) {
      for (var item in listaMun == null ? 0 as Iterable : listaMun) {
        if (j.municipio == item.valor) {
          existeElement = true;
          break;
        }
      }
      if (!existeElement) {
        listaMun.add(ElementoDd(valor: j.municipio));
      }
      existeElement = false;
    });

    catalogoMunicipio =
        CatalogoDdObject(label: "Municipio", valores: listaMun, config: config);

    return Form(
      key: formKey,
      child: Stack(
        //SIEMPRE USAR STACK: Para evitar que la lista desplegable mueva los elementos que están abajo de ella
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                top: catalogoMunicipio!.config!.dropdownSize! * 11 + 115),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: ButtonTheme(
                minWidth: 400.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.all(15.0),
                      backgroundColor: AppColors.secondary900,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)
                      )
                    ),
                    child: Text(
                      "Buscar",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          fontFamily: 'Roboto-Bold'),
                    ),
                    onPressed: () {
                      if (municipiosList!.isNotEmpty) {
                        catalogoTres!.selectedItem =
                            catalogoTres!.selectedItem == null
                                ? 0
                                : catalogoTres!.selectedItem;
                        var circuloMedico =
                            listaCM[catalogoTres!.selectedItem!].valor;
                        catalogoCuatro!.selectedItem =
                            catalogoCuatro!.selectedItem == null
                                ? 0
                                : catalogoCuatro!.selectedItem;
                        catalogoEstado!.selectedItem =
                            catalogoEstado!.selectedItem == null
                                ? 0
                                : catalogoEstado!.selectedItem;
                        catalogoMunicipio!.selectedItem =
                            catalogoMunicipio!.selectedItem == null
                                ? 0
                                : catalogoMunicipio!.selectedItem;
                        currentPoliza = listaPolizasUsuarios!.length != 0
                            ? listaPolizasUsuarios![
                                catalogoDos!.selectedItem == null
                                    ? 0
                                    : catalogoDos!.selectedItem!]
                            : sinPoliza;
                        if (listaPolizasUsuarios!.length > 0) {
                          if (listaPolizasUsuarios![
                                          catalogoDos!.selectedItem == null
                                              ? 0
                                              : catalogoTres!.selectedItem!]
                                      .circuloMedico ==
                                  circuloMedico ||
                              circuloMedico!.contains("- contratado")) {
                            //revisar
                            var encontrado = false;
                            circulosList!.forEach((element) {
                              if (element.circuloMedico ==
                                  listaPolizasUsuarios![catalogoDos!.selectedItem!]
                                      .circuloMedico) {
                                encontrado = true;
                                circuloContratado = true;
                                currentCirculo = CirculoMedico(
                                    claveCirculoMedico: listaPolizasUsuarios![
                                            catalogoDos!.selectedItem!]
                                        .cveCirculoMedico,
                                    circuloMedico: element.circuloMedico! +
                                        " - contratado");
                              }
                            });
                            if (!encontrado) {
                              circuloContratado = true;
                              currentCirculo = CirculoMedico(
                                  claveCirculoMedico: listaPolizasUsuarios![
                                          catalogoDos!.selectedItem!]
                                      .cveCirculoMedico,
                                  circuloMedico: circuloMedico);
                            }
                          } else {
                            circulosList!.forEach((element) {
                              if (element.circuloMedico ==
                                  listaCM[catalogoTres!.selectedItem!].valor) {
                                circuloContratado = false;
                                currentCirculo = CirculoMedico(
                                    claveCirculoMedico:
                                        element.claveCirculoMedico,
                                    circuloMedico: element.circuloMedico);
                              }
                            });
                          }
                        } else {
                          circulosList!.forEach((element) {
                            if (element.circuloMedico ==
                                listaCM[catalogoTres!.selectedItem!].valor) {
                              circuloContratado = false;
                              currentCirculo = CirculoMedico(
                                  claveCirculoMedico:
                                      element.claveCirculoMedico,
                                  circuloMedico: element.circuloMedico);
                            }
                          });
                        }
                        if (currentCirculo!.circuloMedico == "Todos") {
                          currentCirculo = CirculoMedico(
                              claveCirculoMedico: "", circuloMedico: "");
                          circuloContratado = false;
                        }
                        if (especialidadList![catalogoCuatro!.selectedItem!]
                                .especialidad ==
                            "Todos") {
                          currentEspecialidad = Especialidad(
                              claveEspecialidad: "0", especialidad: "");
                        } else {
                          currentEspecialidad = especialidadList!.length != 0
                              ? especialidadList![catalogoCuatro!.selectedItem!]
                              : null;
                        }
                        if (estadosList![catalogoEstado!.selectedItem!].estado ==
                            "Todos") {
                          currentEstado =
                              Estados(claveEstado: "000", estado: "");
                        } else {
                          currentEstado = estadosList!.length != 0
                              ? estadosList![catalogoEstado!.selectedItem!]
                              : null;
                        }
                        if (municipiosList![catalogoMunicipio!.selectedItem!]
                                .municipio ==
                            "Todos") {
                          currentMunicipio =
                              Municipios(claveMunicipio: "0", municipio: "");
                        } else {
                          currentMunicipio = municipiosList!.length != 0
                              ? municipiosList![catalogoMunicipio!.selectedItem!]
                              : null;
                        }
                        Utils.listCirculosFiltros.clear();
                        if (circuloContratado) {
                          Utils.listCirculosFiltros.add(currentCirculo!);
                          Utils.listCirculos.forEach((element) {
                            for (var item in Utils.listCirculosFiltros == null
                                ? 0 as Iterable
                                : Utils.listCirculosFiltros) {
                              if (element.circuloMedico == item.circuloMedico ||
                                  element.circuloMedico! + " - contratado" ==
                                      item.circuloMedico) {
                                existeElement = true;
                                break;
                              }
                            }
                            if (!existeElement) {
                              Utils.listCirculosFiltros.add(element);
                            }
                            existeElement = false;
                          });
                        } else {
                          Utils.listCirculosFiltros.addAll(Utils.listCirculos);
                        }
                        var datos2 = Parametros(
                          origen: "APPAgentes",
                          cvCirculoM: currentCirculo!.claveCirculoMedico,
                          cvEspecialidad: currentEspecialidad!.claveEspecialidad,
                          bandera: circuloContratado,
                          nombre: inputNombreController.text,
                          buscador: _especialidades != null ? _especialidades : "",
                          cvEstado: currentEstado!.claveEstado,
                          cvMunicipio: currentMunicipio!.claveMunicipio,
                          pagina: 0,
                          dateTime: DateTime.now(),
                        );
                        Utils.lbBuscador = false;
                        _especialidades = "";
                        if (currentCirculo != null &&
                            currentEspecialidad != null &&
                            currentEstado != null &&
                            currentMunicipio != null) {
                          //ENVIA EVENTOS A FIREBASE
                          var circuloMedico =
                              listaCM[catalogoTres!.selectedItem!].valor!;
                          Map<String, dynamic> circulo = {
                            "circulo": circuloMedico
                          };

                          AnalyticsServices().sendTag("dir_medicos_círculo",
                              parameters: circulo);

                          Map<String, dynamic> especialidad = {
                            "especialidad":
                                especialidadList![catalogoCuatro!.selectedItem!]
                                    .especialidad
                          };

                          AnalyticsServices().sendTag(
                              "dir_medicos_especialidad",
                              parameters: especialidad);
                          Map<String, dynamic> eventos = {
                            "estado":
                                estadosList![catalogoEstado!.selectedItem!].estado,
                            "municipio":
                                municipiosList![catalogoMunicipio!.selectedItem!]
                                    .municipio
                          };

                          AnalyticsServices().sendTag(
                              "dir_medicos_localizacion",
                              parameters: eventos);
                          // //ENVIA TAGS ANALYTICS
                          presenter!
                              .sendAnalytics(
                                  "Médicos",
                                  circuloMedico,
                                  especialidadList![catalogoCuatro!.selectedItem!]
                                      .especialidad!,
                                  estadosList![catalogoEstado!.selectedItem!]
                                      .estado!,
                                  municipiosList![catalogoMunicipio!.selectedItem!]
                                      .municipio!,
                                  currentPoliza.numPoliza!)
                              .then((value) =>

                                  //ENVIA A LA VISTA DE RESULTADOS
                                  presenter!.showSearch(
                                      "Médicos en convenio",
                                      "",
                                      circuloMedico,
                                      especialidadList![
                                              catalogoCuatro!.selectedItem!]
                                          .especialidad!,
                                      estadosList![catalogoEstado!.selectedItem!]
                                          .estado!,
                                      municipiosList![
                                              catalogoMunicipio!.selectedItem!]
                                          .municipio!,
                                      datos2,
                                      currentPoliza.numPoliza!));
                        } else {
                          customAlert(
                              AlertDialogType.errorConexion, context, "", "");
                        }
                      }
                    }),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0, left: 0, right: 0),
                  child: Container(
                      margin: EdgeInsets.only(
                          top:
                              catalogoMunicipio!.config!.dropdownSize! * 10 + 145),
                      child: Divider(
                        thickness: 1,
                        color: AppColors.scrollbar,
                        height: 60,
                      )),
                ),
              ),
            ],
          ),
          Visibility(
            visible: mostrarDropdownPolizas, //
            child: Container(
                margin: EdgeInsets.only(
                    top: catalogoMunicipio!.config!.dropdownSize! * 9 + 100),
                child: GeneraCatalogo(
                  dataObject: catalogoDos,
                  onChange: onchangePolizas,
                  refresh: refresh,
                  idDropdown: 5,
                )), //GeneraCatalogo(dataObject: catalogoDos,onChange: onchangePolizas(),)
          ),
          Visibility(
            visible: mostrarDropdownUsuario, //
            child: Container(
                margin: EdgeInsets.only(
                    top: catalogoMunicipio!.config!.dropdownSize! * 9 + 155),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "Nombre del asegurado",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: AppColors.colorVisibilty,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        children: <Widget>[
                          Text(
                            _nombreAseguradoPoliza!,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: AppColors.textDropdown,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )), //GeneraCatalogo(dataObject: catalogoDos,onChange: onchangePolizas(),)
          ),
          if (gestionroles.visualizandoPorSeccion(
              "directoriosearch", "datos_asegurado"))
            Container(
              child: Padding(
                padding: EdgeInsets.only(
                    top: catalogoMunicipio!.config!.dropdownSize! * 8 + 140),
                child: TypeAheadField(
                  builder: (context, controller, focusNode) {
                    return TextField(
                      controller: _busquedaPoliza,
                      textCapitalization: TextCapitalization.characters,
                      autofocus: false,
                      style: TextStyle(
                        color: AppColors.textDropdown,
                        fontSize: 18,
                        fontFamily: "Roboto-Medium",
                        fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 8.0),
                        labelText: "Nombre o Póliza del asegurado",
                        hintStyle: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.normal,
                          color: AppColors.gnpTextSystem,
                        ),
                        focusColor: AppColors.secondary900,
                        fillColor: AppColors.primary200,
                        enabledBorder: new UnderlineInputBorder(
                          borderSide: new BorderSide(color: AppColors.primary200),
                        ),
                        border: new UnderlineInputBorder(
                          borderSide: new BorderSide(color: AppColors.primary200),
                        ),
                      ),
                    );
                  },
                  offset: Offset(5.0, 0),
                  itemBuilder: (context, dynamic suggestion) {
                    if (_busquedaPorPoliza(_busquedaPoliza.text) == true) {
                      return new Row(children: [
                        Expanded(
                            child: ListTile(
                                title: Text(suggestion.numPoliza.toString())))
                      ]);
                    } else {
                      return new Row(children: [
                        Expanded(
                            child:
                                ListTile(title: Text(suggestion.nombreCliente)))
                      ]);
                    }
                  }, 
                  onSelected: (dynamic suggestion) {
                    var data;
                    var responsePoliza;
                    var responseNombre;
                    if (_busquedaPorPoliza(_busquedaPoliza.text) == true) {
                      data = suggestion.numPoliza.toString();
                      responseNombre = true;
                      responsePoliza = false;
                      concatName = suggestion.nombres +
                          ' ' +
                          suggestion.apePaterno +
                          ' ' +
                          suggestion.apeMaterno;
                      setState(() {
                        listaPolizasUsuarios = Utils.listPolizaUsuarios;
                        if (Utils.listPolizaUsuarios.length > 0) {
                          mostrarDropdownPolizas = responsePoliza;
                          mostrarDropdownUsuario = responseNombre;
                          onChangedropDrop(Utils.listPolizaUsuarios[0]);
                          _nombreAseguradoPoliza = concatName;
                        }
                        formKey.currentState!.save();
                        formKey.currentState!.didChangeDependencies();
                      });
                    } else {
                      if (_busquedaPoliza.text.length > 2) {
                        data = suggestion.nombreCliente.toString();
                        responseNombre = false;
                        responsePoliza = true;
                        presenter!
                            .getPolizasClienteSearch(
                                suggestion.idParticipanteConsolidado.toString())
                            .then((value) => setState(() {
                                  listaPolizasUsuarios =
                                      Utils.listPolizaUsuarios;
                                  if (Utils.listPolizaUsuarios.length > 0) {
                                    mostrarDropdownPolizas = responsePoliza;
                                    mostrarDropdownUsuario = responseNombre;
                                    onChangedropDrop(
                                        Utils.listPolizaUsuarios[0]);
                                    _nombreAseguradoPoliza = concatName;
                                  }
                                  formKey.currentState!.save();
                                  formKey.currentState!.didChangeDependencies();
                                }));
                      }
                    }
                    this._busquedaPoliza.text = data;
                  }, 
                  suggestionsCallback: (pattern) async {
                    if (_busquedaPoliza.text.length < 14 &&
                        (Utils.listPolizaUsuarios.length > 0 ||
                            Utils.listPersonasPoliza.length > 0)) {
                      setState(() {
                        mostrarDropdownUsuario = false;
                        mostrarDropdownPolizas = false;
                        _nombreAseguradoPoliza = '';
                        Utils.listPolizaUsuarios.clear();
                        Utils.listPersonasPoliza.clear();
                        Utils.listPolizaUsuarios.add(sinPoliza);
                        listaPolizasUsuarios = Utils.listPolizaUsuarios;
                        onChangedropDrop(Utils.listPolizaUsuarios[0]);
                        Utils.listPolizaUsuarios.clear();
                        // return [];
                      });
                    }
                    if (_busquedaPorPoliza(_busquedaPoliza.text) == true) {
                      if (_busquedaPoliza.text.length > 6) {
                        var poliza = _busquedaPoliza.text;
                        return presenter!.getPolizaSearch(poliza);
                      }
                    } else {
                      if (_busquedaPoliza.text.length > 2) {
                        print("se habilita la busqueda por nombre");
                        return presenter!
                            .getPersonasPoliza(_busquedaPoliza.text);
                      }
                    }
                    return presenter!
                            .getPersonasPoliza("");
                  },
                  emptyBuilder: (context) => _sinResultados(context),
                  )
                // child: TypeAheadField(
                //   textFieldConfiguration: TextFieldConfiguration(
                //     controller: _busquedaPoliza,
                //     textCapitalization: TextCapitalization.characters,
                //     autofocus: false,
                //     style: TextStyle(
                //         color: AppColors.textDropdown,
                //         fontSize: 18,
                //         fontFamily: "Roboto-Medium",
                //         fontWeight: FontWeight.normal),
                //     decoration: InputDecoration(
                //       contentPadding: EdgeInsets.only(left: 8.0),
                //       labelText: "Nombre o Póliza del asegurado",
                //       hintStyle: TextStyle(
                //         fontSize: 32,
                //         fontWeight: FontWeight.normal,
                //         color: AppColors.gnpTextSystem,
                //       ),
                //       focusColor: AppColors.secondary900,
                //       fillColor: AppColors.primary200,
                //       enabledBorder: new UnderlineInputBorder(
                //         borderSide: new BorderSide(color: AppColors.primary200),
                //       ),
                //       border: new UnderlineInputBorder(
                //         borderSide: new BorderSide(color: AppColors.primary200),
                //       ),
                //     ),
                //   ),
                //   // ignore: missing_return
                //   suggestionsCallback: (pattern) async {
                //     if (_busquedaPoliza.text.length < 14 &&
                //         (Utils.listPolizaUsuarios.length > 0 ||
                //             Utils.listPersonasPoliza.length > 0)) {
                //       setState(() {
                //         mostrarDropdownUsuario = false;
                //         mostrarDropdownPolizas = false;
                //         _nombreAseguradoPoliza = '';
                //         Utils.listPolizaUsuarios.clear();
                //         Utils.listPersonasPoliza.clear();
                //         Utils.listPolizaUsuarios.add(sinPoliza);
                //         listaPolizasUsuarios = Utils.listPolizaUsuarios;
                //         onChangedropDrop(Utils.listPolizaUsuarios[0]);
                //         Utils.listPolizaUsuarios.clear();
                //         // return [];
                //       });
                //     }
                //     if (_busquedaPorPoliza(_busquedaPoliza.text) == true) {
                //       if (_busquedaPoliza.text.length > 6) {
                //         var poliza = _busquedaPoliza.text;
                //         return presenter!.getPolizaSearch(poliza);
                //       }
                //     } else {
                //       if (_busquedaPoliza.text.length > 2) {
                //         print("se habilita la busqueda por nombre");
                //         return presenter!
                //             .getPersonasPoliza(_busquedaPoliza.text);
                //       }
                //     }
                //     return presenter!
                //             .getPersonasPoliza("");
                //   },
                //   itemBuilder: (context, dynamic suggestion) {
                //     if (_busquedaPorPoliza(_busquedaPoliza.text) == true) {
                //       return new Row(children: [
                //         Expanded(
                //             child: ListTile(
                //                 title: Text(suggestion.numPoliza.toString())))
                //       ]);
                //     } else {
                //       return new Row(children: [
                //         Expanded(
                //             child:
                //                 ListTile(title: Text(suggestion.nombreCliente)))
                //       ]);
                //     }
                //   },
                //   suggestionsBoxDecoration: SuggestionsBoxDecoration(
                //       hasScrollbar: true, elevation: 0.0),
                //   suggestionsBoxVerticalOffset: 5.0,
                //   onSuggestionSelected: (dynamic suggestion) {
                //     var data;
                //     var responsePoliza;
                //     var responseNombre;
                //     if (_busquedaPorPoliza(_busquedaPoliza.text) == true) {
                //       data = suggestion.numPoliza.toString();
                //       responseNombre = true;
                //       responsePoliza = false;
                //       concatName = suggestion.nombres +
                //           ' ' +
                //           suggestion.apePaterno +
                //           ' ' +
                //           suggestion.apeMaterno;
                //       setState(() {
                //         listaPolizasUsuarios = Utils.listPolizaUsuarios;
                //         if (Utils.listPolizaUsuarios.length > 0) {
                //           mostrarDropdownPolizas = responsePoliza;
                //           mostrarDropdownUsuario = responseNombre;
                //           onChangedropDrop(Utils.listPolizaUsuarios[0]);
                //           _nombreAseguradoPoliza = concatName;
                //         }
                //         formKey.currentState!.save();
                //         formKey.currentState!.didChangeDependencies();
                //       });
                //     } else {
                //       if (_busquedaPoliza.text.length > 2) {
                //         data = suggestion.nombreCliente.toString();
                //         responseNombre = false;
                //         responsePoliza = true;
                //         presenter!
                //             .getPolizasClienteSearch(
                //                 suggestion.idParticipanteConsolidado.toString())
                //             .then((value) => setState(() {
                //                   listaPolizasUsuarios =
                //                       Utils.listPolizaUsuarios;
                //                   if (Utils.listPolizaUsuarios.length > 0) {
                //                     mostrarDropdownPolizas = responsePoliza;
                //                     mostrarDropdownUsuario = responseNombre;
                //                     onChangedropDrop(
                //                         Utils.listPolizaUsuarios[0]);
                //                     _nombreAseguradoPoliza = concatName;
                //                   }
                //                   formKey.currentState!.save();
                //                   formKey.currentState!.didChangeDependencies();
                //                 }));
                //       }
                //     }
                //     this._busquedaPoliza.text = data;
                //   },
                //   noItemsFoundBuilder: (context) => _sinResultados(context),
                // ),
              ),
            ),

          if (gestionroles.visualizandoPorSeccion(
              "directoriosearch", "datos_asegurado_opcional"))
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: catalogoMunicipio!.config!.dropdownSize! * 8 + 90),
                  child: Text("DATOS DEL ASEGURADO (OPCIONAL)",
                      style: TextStyle(
                          color: AppColors.gnpTextSystem2,
                          fontSize: 10,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                    padding: EdgeInsets.only(
                        top: catalogoMunicipio!.config!.dropdownSize! * 6 + 190),
                    child: Divider(
                      thickness: 1,
                      color: AppColors.divider,
                      height: 60,
                    )),
              ),
            ],
          ),
          //Combo 6
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
                // El contenido que va bajo el dropdown
                margin: EdgeInsets.only(
                    top: catalogoMunicipio!.config!.dropdownSize! * 6 +
                        50), // El espacio que ocupa el dropdown
                child: GeneraCatalogo(
                  dataObject: catalogoMunicipio,
                  refresh: refresh,
                  idDropdown: 4,
                )),
          ),
          //Combo 5
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
                // El contenido que va bajo el dropdown
                margin: EdgeInsets.only(
                    top: catalogoEstado!.config!.dropdownSize! * 5 +
                        20), // El espacio que ocupa el dropdown
                child: GeneraCatalogo(
                  dataObject: catalogoEstado,
                  onChange: onchange,
                  refresh: refresh,
                  idDropdown: 3,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              margin: EdgeInsets.only(
                  top: catalogoEstado!.config!.dropdownSize! * 4 + 95),
              child: Text("LOCALIZACIÓN",
                  style: TextStyle(
                      color: AppColors.gnpTextSystem2,
                      fontSize: 10,
                      fontWeight: FontWeight.w500)),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                      margin: EdgeInsets.only(
                          top: catalogoCuatro!.config!.dropdownSize! * 4 + 55),
                      child: Divider(
                        thickness: 1,
                        color: AppColors.divider,
                        height: 60,
                      )),
                ),
              ),
            ],
          ),
          //Combo 4
          Padding(
            padding: const EdgeInsets.only(top: 14.0),
            child: Container(
                // El contenido que va bajo el dropdown
                margin: EdgeInsets.only(
                    top: catalogoCuatro!.config!.dropdownSize! * 2 +
                        60), // El espacio que ocupa el dropdown
                child: GeneraCatalogo(
                  dataObject: catalogoCuatro,
                  refresh: refresh,
                  idDropdown: 2,
                )),
          ),
          //Combo 3
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
                // El contenido que va bajo el dropdown
                margin: EdgeInsets.only(
                    top: catalogoTres!.config!.dropdownSize! * 2 -
                        38), // El espacio que ocupa el dropdown
                child: GeneraCatalogo(
                  dataObject: catalogoTres,
                  refresh: refresh,
                  idDropdown: 1,
                )),
          ),
//COMBO 2 //AGREGAR NOMBRE MEDICO
          Padding(
            // El cutom Dropdown
            padding: const EdgeInsets.only(top: 12.0),
            child: Container(
              margin: EdgeInsets.only(
                  top: catalogoTres!.config!.dropdownSize! * 1 - 5),
              child: //CustomDropdown(dataObject: combo2DataObject)
                  TextField(
                controller: inputNombreController,
                maxLengthEnforcement: MaxLengthEnforcement.none,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp("[A-Za-zÁÉÍÓÚáéíóúñÑ ]")),
                ],
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 12.0),
                  labelText: "Nombre (Opcional)",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: AppColors.gnpTextSystem,
                  ),
                  focusColor: AppColors.secondary900,
                  fillColor: AppColors.primary200,
                  enabledBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: AppColors.primary200),
                  ),
                  border: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: AppColors.primary200),
                  ),
                ),
                keyboardType: TextInputType.text,
                style: new TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: AppColors.gnpTextSystem,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Container(
              margin:
                  EdgeInsets.only(top: catalogoTres!.config!.dropdownSize! - 45),
              child: Text("MÉDICO",
                  style: TextStyle(
                      color: AppColors.gnpTextSystem2,
                      fontSize: 10,
                      fontWeight: FontWeight.w500)),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Container(
                      margin: EdgeInsets.only(
                          top: catalogoTres!.config!.dropdownSize! - 70),
                      child: Divider(
                        thickness: 1,
                        color: AppColors.divider,
                        height: 20,
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget? seleccionaDdHospitales() {
    try {
      //listaPolizasUsuarios != null &&
      if (planesList != null && estadosList != null && municipiosList != null) {
        //listaPolizasUsuarios,
        return dropdownHospitales(planesList!, estadosList!, municipiosList!);
      } else {
        // var poliza = presenter.getPolizasUsuario();
        var plan = presenter!.getPlanes();
        var estado = presenter!.getEstados();
        var municipio = presenter!.getMunicipios(estadosList![0].claveEstado!);

        return FutureBuilder(
          //poliza,
          future: Future.wait([plan, estado, municipio]),
          builder: (context, snapshot) {
            for (int i = 0; i < 3; i++) {
              //poliza : i == 1 ?
              var current = i == 0 ? plan : i == 1 ? estado : municipio;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return loadingPicker(current);
                default:
                  if (snapshot.hasError) {
                    return loadingPicker(current);
                  } else {
                    switch (i) {
                      case 0:
                        planesList = snapshot.data![i] as List<Planes>?;
                        break;
                      case 1:
                        estadosList = snapshot.data![i] as List<Estados>?;
                        break;
                      case 2:
                        municipiosList = snapshot.data![i] as List<Municipios>?;
                        break;
                    }
                  }
              }
            }

            return dropdownHospitales(planesList!, estadosList!, municipiosList!);
          },
        );
      }
    } catch (e) {
      print(e);
    }
    return SizedBox();
  }

  Widget dropdownHospitales(
      List<Planes> planes, List<Estados> estados, List<Municipios> municipios) {
    if (listaPolizasUsuarios == null) {
      Utils.listPolizaUsuarios.clear();
      listaPolizasUsuarios = Utils.listPolizaUsuarios;
    }
    listaPolizasUsuarios!.forEach((element) {
      for (var item in listaPol == null ? 0 as Iterable : listaPol) {
        if (element.numPoliza == item.valor) {
          existeElement = true;
          break;
        }
      }
      if (!existeElement) {
        listaPol.add(ElementoDd(valor: element.numPoliza));
      }
      existeElement = false;
    });
    catalogoUno = CatalogoDdObject(
        label: "Número de póliza",
        valores: listaPol,
        config: config,
        onChange: onchangePolizas(),
        selectedItem: catalogoUno == null
            ? 0
            : catalogoUno!.selectedItem == null ? 0 : catalogoUno!.selectedItem);

    planes.forEach((element) {
      for (var item in listaPla == null ? 0 as Iterable : listaPla) {
        if (element.plan == item.valor ||
            element.plan! + " - contratado" == item.valor) {
          existeElement = true;
          break;
        }
      }
      if (!existeElement) {
        listaPla.add(ElementoDd(valor: element.plan));
      }
      existeElement = false;
    });

    catalogoDos = CatalogoDdObject(
        label: "Plan hospitalario",
        valores: listaPla,
        config: config,
        selectedItem: catalogoDos == null
            ? 0
            : catalogoDos!.selectedItem == null ? 0 : catalogoDos!.selectedItem);

    estados.forEach((i) {
      for (var item in listaEst == null ? 0 as Iterable : listaEst) {
        if (i.estado == item.valor) {
          existeElement = true;
          break;
        }
      }
      if (!existeElement) {
        listaEst.add(ElementoDd(valor: i.estado));
      }
      existeElement = false;
    });

    catalogoEstado = CatalogoDdObject(
        label: "Estado",
        valores: listaEst,
        config: config,
        selectedItem: Utils.cvEstado != -1
            ? Utils.cvEstado
            : catalogoEstado == null
                ? 0
                : catalogoEstado!.selectedItem == null
                    ? 0
                    : catalogoEstado!.selectedItem);

    municipios.forEach((j) {
      for (var item in listaMun == null ? 0 as Iterable : listaMun) {
        if (j.municipio == item.valor) {
          existeElement = true;
          break;
        }
      }
      if (!existeElement) {
        listaMun.add(ElementoDd(valor: j.municipio));
      }
      existeElement = false;
    });

    catalogoMunicipio =
        CatalogoDdObject(label: "Municipio", valores: listaMun, config: config);

    return Form(
      key: formKey,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                top: catalogoMunicipio!.config!.dropdownSize! * 9 + 85),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: ButtonTheme(
                  minWidth: 400.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.all(15.0),
                        backgroundColor: AppColors.secondary900,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)
                        )
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        "Buscar",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            fontFamily: 'Roboto-Bold'),
                      ),
                      onPressed: () {
                        if (municipiosList!.isNotEmpty) {
                          catalogoUno!.selectedItem =
                              catalogoUno!.selectedItem == null
                                  ? 0
                                  : catalogoUno!.selectedItem;
                          var planSelected = listaPla[catalogoDos!.selectedItem!]
                                  .valor!
                                  .contains("- c...")
                              ? listaPla[catalogoDos!.selectedItem!]
                                  .valor!
                                  .replaceAll("- c...", "- contratado")
                              : listaPla[catalogoDos!.selectedItem!].valor;
                          catalogoEstado!.selectedItem =
                              catalogoEstado!.selectedItem == null
                                  ? 0
                                  : catalogoEstado!.selectedItem;
                          catalogoMunicipio!.selectedItem =
                              catalogoMunicipio!.selectedItem == null
                                  ? 0
                                  : catalogoMunicipio!.selectedItem;
                          currentPoliza = listaPolizasUsuarios!.length != 0
                              ? listaPolizasUsuarios![
                                  catalogoUno!.selectedItem == null
                                      ? 0
                                      : catalogoUno!.selectedItem!]
                              : sinPoliza;
                          if (listaPolizasUsuarios!.length > 0) {
                            if (listaPolizasUsuarios![catalogoUno!.selectedItem!]
                                        .planComercial ==
                                    planSelected ||
                                planSelected!.contains("- contratado")) {
                              var encontrado = false;
                              planesList!.forEach((element) {
                                if (element.plan ==
                                    listaPolizasUsuarios![
                                            catalogoUno!.selectedItem!]
                                        .planComercial) {
                                  encontrado = true;
                                  planContratado = true;
                                  currentPlan = Planes(
                                      clavePlan: listaPolizasUsuarios![
                                              catalogoUno!.selectedItem!]
                                          .cvePlanComercial,
                                      plan: element.plan! + " - contratado");
                                }
                              });
                              if (!encontrado) {
                                planContratado = true;
                                currentPlan = Planes(
                                    clavePlan: listaPolizasUsuarios![
                                            catalogoUno!.selectedItem!]
                                        .cvePlanComercial,
                                    plan: listaPolizasUsuarios![
                                                catalogoUno!.selectedItem!]
                                            .planComercial! +
                                        " - contratado");
                              }
                            } else {
                              planesList!.forEach((element) {
                                if (element.plan ==
                                    listaPla[catalogoDos!.selectedItem!].valor) {
                                  planContratado = false;
                                  currentPlan = Planes(
                                      clavePlan: element.clavePlan,
                                      plan: element.plan);
                                }
                              });
                            }
                          } else {
                            planesList!.forEach((element) {
                              if (element.plan ==
                                  listaPla[catalogoDos!.selectedItem!].valor) {
                                planContratado = false;
                                currentPlan = Planes(
                                    clavePlan: element.clavePlan,
                                    plan: element.plan);
                              }
                            });
                          }
                          if (currentPlan!.plan == "Todos") {
                            currentPlan = Planes(clavePlan: "", plan: "");
                            planContratado = false;
                          }
                          var plan = listaPla[catalogoDos!.selectedItem!].valor;
                          var productoTecnico = planContratado == true
                              ? listaPolizasUsuarios![catalogoUno!.selectedItem!]
                                  .cveProdTecnico
                              : "";
                          var productoComercial = planContratado == true
                              ? listaPolizasUsuarios![catalogoUno!.selectedItem!]
                                  .cveProdComercial
                              : "";
                          Utils.listNivelesFiltros.clear();
                          if (planContratado == true &&
                              currentPoliza.numPoliza != "Sin póliza") {
                            var contratadoEncontrado = false;
                            presenter!
                                .getNivelHospitalario(
                                    planContratado,
                                    currentPlan!.plan!,
                                    currentPlan!.clavePlan!,
                                    productoTecnico!,
                                    productoComercial!)
                                .then((value) => Utils.listNivelesFiltros
                                    .addAll(Utils.listNiveles))
                                .then((value) =>
                                    Utils.listNiveles.forEach((element) {
                                      for (var item
                                          in Utils.listNivelesFiltros == null
                                              ? 0 as Iterable
                                              : Utils.listNivelesFiltros) {
                                        if (element.nivelHospitalario ==
                                            item.nivelHospitalario) {
                                          if (element.banContratado == true) {
                                            element.nivelHospitalario =
                                                element.nivelHospitalario! +
                                                    " - contratado";
                                            if (contratadoEncontrado == false) {
                                              cvNivelHosp = element
                                                  .claveNivelHospitalario;
                                              Utils.cvNivelHosp = cvNivelHosp!;
                                              contratadoEncontrado = true;
                                            }
                                          } else {
                                            element.nivelHospitalario =
                                                element.nivelHospitalario;
                                          }
                                          existeElement = true;
                                          break;
                                        }
                                      }
                                      if (!existeElement) {
                                        Utils.listNivelesFiltros.add(element);
                                      }
                                      existeElement = false;
                                    }));
                          }
                          if (estadosList![catalogoEstado!.selectedItem!].estado ==
                              "Todos") {
                            currentEstado =
                                Estados(claveEstado: "000", estado: "");
                          } else {
                            currentEstado = estadosList!.length != 0
                                ? estadosList![catalogoEstado!.selectedItem!]
                                : null;
                          }
                          if (municipiosList![catalogoMunicipio!.selectedItem!]
                                  .municipio ==
                              "Todos") {
                            currentMunicipio =
                                Municipios(claveMunicipio: "", municipio: "");
                          } else {
                            currentMunicipio = municipiosList!.length != 0
                                ? municipiosList![catalogoMunicipio!.selectedItem!]
                                : null;
                          }
                          Utils.lbBuscador = false;
                          if (currentPlan != null &&
                              currentEstado != null &&
                              currentMunicipio != null) {
                            //ENVIA EVENTOS A FIREBASE
                            Map<String, dynamic> eventos = {
                              "estado": estadosList![catalogoEstado!.selectedItem!]
                                  .estado,
                              "municipio":
                                  municipiosList![catalogoMunicipio!.selectedItem!]
                                      .municipio
                            };
                            AnalyticsServices().sendTag(
                                "dir_hospitales_localizacion",
                                parameters: eventos);
                            var datos2 = Parametros(
                              cvEstado: estadosList![catalogoEstado!.selectedItem!]
                                  .claveEstado,
                              cvMunicipio:
                                  municipiosList![catalogoMunicipio!.selectedItem!]
                                      .claveMunicipio,
                              codigoFiliacion: "",
                              cvPlanH: currentPlan!.clavePlan,
                              claveNivelHospitalario:
                                  planContratado ? cvNivelHosp : "",
                              bandera: planContratado,
                              productoTecnico: productoTecnico,
                              productoComercial: productoComercial,
                              origen: "APPAgentes",
                              pagina: 0,
                              dateTime: DateTime.now(),
                            );
                            //ENVIA TAGS ANALYTICS
                            presenter!
                                .sendAnalytics(
                                    "Hospitales",
                                    plan!,
                                    "",
                                    estadosList![catalogoEstado!.selectedItem!]
                                        .estado!,
                                    municipiosList![
                                            catalogoMunicipio!.selectedItem!]
                                        .municipio!,
                                    currentPoliza.numPoliza!)
                                .then((value) => presenter!.showSearch(
                                    "Hospitales en convenio",
                                    "",
                                    plan,
                                    "",
                                    estadosList![catalogoEstado!.selectedItem!]
                                        .estado!,
                                    municipiosList![
                                            catalogoMunicipio!.selectedItem!]
                                        .municipio!,
                                    datos2,
                                    currentPoliza.numPoliza!));
                          } else {
                            customAlert(
                                AlertDialogType.errorConexion, context, "", "");
                          }
                        }
                      })),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 0, right: 0),
                  child: Container(
                      margin: EdgeInsets.only(
                          top: catalogoMunicipio!.config!.dropdownSize! * 9 + 40),
                      child: Divider(
                        thickness: 1,
                        color: AppColors.scrollbar,
                        height: 60,
                      )),
                ),
              ),
            ],
          ),
          Visibility(
            visible: mostrarDropdownPolizas, //
            child: Container(
                margin: EdgeInsets.only(
                    top: catalogoMunicipio!.config!.dropdownSize! * 8 - 5),
                child: GeneraCatalogo(
                  dataObject: catalogoUno,
                  onChange: onchangePolizas,
                  refresh: refresh,
                  idDropdown: 4,
                )), //GeneraCatalogo(dataObject: catalogoDos,onChange: onchangePolizas(),)
          ),
          Visibility(
            visible: mostrarDropdownUsuario, //
            child: Container(
                margin: EdgeInsets.only(
                    top: catalogoMunicipio!.config!.dropdownSize! * 8 + 45),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "Nombre del asegurado",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: AppColors.colorVisibilty,
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height: 10.0),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 0, top: 16.0),
                            child: Text(
                              _nombreAseguradoPoliza!,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: AppColors.textDropdown,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )), //GeneraCatalogo(dataObject: catalogoDos,onChange: onchangePolizas(),)
          ),
          if (gestionroles.visualizandoPorSeccion(
              "directoriosearch", "datos_asegurado"))
            Container(
              child: Padding(
                padding: EdgeInsets.only(
                    top: catalogoMunicipio!.config!.dropdownSize! * 6 + 100),
                child: TypeAheadField(
                  builder: (context, controller, focusNode) {
                    return TextField(
                      controller: _busquedaPoliza,
                      textCapitalization: TextCapitalization.characters,
                      autofocus: false,
                      maxLengthEnforcement: MaxLengthEnforcement.none,
                      style: new TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: AppColors.textDropdown,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 8.0),
                        labelText: "Nombre o Póliza del asegurado",
                        hintStyle: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.normal,
                          color: AppColors.gnpTextSystem,
                        ),
                        focusColor: AppColors.secondary900,
                        fillColor: AppColors.primary200,
                        enabledBorder: new UnderlineInputBorder(
                          borderSide: new BorderSide(color: AppColors.primary200),
                        ),
                        border: new UnderlineInputBorder(
                          borderSide: new BorderSide(color: AppColors.primary200),
                        ),
                      ),
                    );
                  },
                  suggestionsCallback: (pattern) async {
                    if (_busquedaPoliza.text.length < 14 &&
                        (Utils.listPolizaUsuarios.length > 0 ||
                            Utils.listPersonasPoliza.length > 0)) {
                      setState(() {
                        mostrarDropdownUsuario = false;
                        mostrarDropdownPolizas = false;
                        _nombreAseguradoPoliza = '';
                        Utils.listPolizaUsuarios.clear();
                        Utils.listPersonasPoliza.clear();
                        Utils.listPolizaUsuarios.add(sinPoliza);
                        listaPolizasUsuarios = Utils.listPolizaUsuarios;
                        onChangedropDrop(Utils.listPolizaUsuarios[0]);
                        Utils.listPolizaUsuarios.clear();
                      });
                    }
                    if (_busquedaPorPoliza(_busquedaPoliza.text) == true) {
                      if (_busquedaPoliza.text.length > 6) {
                        var poliza = _busquedaPoliza.text;
                        return presenter!.getPolizaSearch(poliza);
                      }
                    } else {
                      if (_busquedaPoliza.text.length > 2) {
                        print("se habilita la busqueda por nombre");
                        return presenter!
                            .getPersonasPoliza(_busquedaPoliza.text);
                      }
                    }
                    return Future.value([]);
                  },
                  itemBuilder: (context, dynamic suggestion) {
                    if (_busquedaPorPoliza(_busquedaPoliza.text) == true) {
                      return new Row(children: [
                        Expanded(
                            child: ListTile(
                                title: Text(suggestion.numPoliza.toString())))
                      ]);
                    } else {
                      return new Row(children: [
                        Expanded(
                            child:
                                ListTile(title: Text(suggestion.nombreCliente)))
                      ]);
                    }
                  },
                  offset: Offset(5.0, 0),
                  onSelected:  (dynamic suggestion) {
                    var data;
                    var responsePoliza;
                    var responseNombre;

                    if (_busquedaPorPoliza(_busquedaPoliza.text) == true) {
                      data = suggestion.numPoliza.toString();
                      responseNombre = true;
                      responsePoliza = false;
                      concatName = suggestion.nombres +
                          ' ' +
                          suggestion.apePaterno +
                          ' ' +
                          suggestion.apeMaterno;
                      setState(() {
                        listaPolizasUsuarios = Utils.listPolizaUsuarios;
                        if (Utils.listPolizaUsuarios.length > 0) {
                          mostrarDropdownPolizas = responsePoliza;
                          mostrarDropdownUsuario = responseNombre;
                          onChangedropDrop(Utils.listPolizaUsuarios[0]);
                          _nombreAseguradoPoliza = concatName;
                        }
                        formKey.currentState!.save();
                        formKey.currentState!.didChangeDependencies();
                      });
                    } else {
                      if (_busquedaPoliza.text.length > 2) {
                        data = suggestion.nombreCliente.toString();
                        responseNombre = false;
                        responsePoliza = true;
                        presenter!
                            .getPolizasClienteSearch(
                                suggestion.idParticipanteConsolidado.toString())
                            .then((value) => setState(() {
                                  listaPolizasUsuarios =
                                      Utils.listPolizaUsuarios;
                                  if (Utils.listPolizaUsuarios.length > 0) {
                                    mostrarDropdownPolizas = responsePoliza;
                                    mostrarDropdownUsuario = responseNombre;
                                    onChangedropDrop(
                                        Utils.listPolizaUsuarios[0]);
                                    _nombreAseguradoPoliza = concatName;
                                  }
                                  formKey.currentState!.save();
                                  formKey.currentState!.didChangeDependencies();
                                }));
                      }
                    }
                    this._busquedaPoliza.text = data;
                  },
                  emptyBuilder: (context) => _sinResultados(context),
                )
                // child: TypeAheadField(
                //   textFieldConfiguration: TextFieldConfiguration(
                //     controller: _busquedaPoliza,
                //     textCapitalization: TextCapitalization.characters,
                //     autofocus: false,
                //     maxLengthEnforcement: MaxLengthEnforcement.none,
                //     style: new TextStyle(
                //       fontSize: 18,
                //       fontWeight: FontWeight.normal,
                //       color: AppColors.textDropdown,
                //     ),
                //     decoration: InputDecoration(
                //       contentPadding: EdgeInsets.only(left: 8.0),
                //       labelText: "Nombre o Póliza del asegurado",
                //       hintStyle: TextStyle(
                //         fontSize: 32,
                //         fontWeight: FontWeight.normal,
                //         color: AppColors.gnpTextSystem,
                //       ),
                //       focusColor: AppColors.secondary900,
                //       fillColor: AppColors.primary200,
                //       enabledBorder: new UnderlineInputBorder(
                //         borderSide: new BorderSide(color: AppColors.primary200),
                //       ),
                //       border: new UnderlineInputBorder(
                //         borderSide: new BorderSide(color: AppColors.primary200),
                //       ),
                //     ),
                //   ),
                //   // ignore: missing_return
                //   suggestionsCallback: (pattern) async {
                //     if (_busquedaPoliza.text.length < 14 &&
                //         (Utils.listPolizaUsuarios.length > 0 ||
                //             Utils.listPersonasPoliza.length > 0)) {
                //       setState(() {
                //         mostrarDropdownUsuario = false;
                //         mostrarDropdownPolizas = false;
                //         _nombreAseguradoPoliza = '';
                //         Utils.listPolizaUsuarios.clear();
                //         Utils.listPersonasPoliza.clear();
                //         Utils.listPolizaUsuarios.add(sinPoliza);
                //         listaPolizasUsuarios = Utils.listPolizaUsuarios;
                //         onChangedropDrop(Utils.listPolizaUsuarios[0]);
                //         Utils.listPolizaUsuarios.clear();
                //       });
                //     }
                //     if (_busquedaPorPoliza(_busquedaPoliza.text) == true) {
                //       if (_busquedaPoliza.text.length > 6) {
                //         var poliza = _busquedaPoliza.text;
                //         return presenter!.getPolizaSearch(poliza);
                //       }
                //     } else {
                //       if (_busquedaPoliza.text.length > 2) {
                //         print("se habilita la busqueda por nombre");
                //         return presenter!
                //             .getPersonasPoliza(_busquedaPoliza.text);
                //       }
                //     }
                //     return Future.value([]);
                //   },
                //   itemBuilder: (context, dynamic suggestion) {
                //     if (_busquedaPorPoliza(_busquedaPoliza.text) == true) {
                //       return new Row(children: [
                //         Expanded(
                //             child: ListTile(
                //                 title: Text(suggestion.numPoliza.toString())))
                //       ]);
                //     } else {
                //       return new Row(children: [
                //         Expanded(
                //             child:
                //                 ListTile(title: Text(suggestion.nombreCliente)))
                //       ]);
                //     }
                //   },
                //   suggestionsBoxDecoration: SuggestionsBoxDecoration(
                //       hasScrollbar: true, elevation: 0.0),
                //   suggestionsBoxVerticalOffset: 5.0,
                //   onSuggestionSelected: (dynamic suggestion) {
                //     var data;
                //     var responsePoliza;
                //     var responseNombre;

                //     if (_busquedaPorPoliza(_busquedaPoliza.text) == true) {
                //       data = suggestion.numPoliza.toString();
                //       responseNombre = true;
                //       responsePoliza = false;
                //       concatName = suggestion.nombres +
                //           ' ' +
                //           suggestion.apePaterno +
                //           ' ' +
                //           suggestion.apeMaterno;
                //       setState(() {
                //         listaPolizasUsuarios = Utils.listPolizaUsuarios;
                //         if (Utils.listPolizaUsuarios.length > 0) {
                //           mostrarDropdownPolizas = responsePoliza;
                //           mostrarDropdownUsuario = responseNombre;
                //           onChangedropDrop(Utils.listPolizaUsuarios[0]);
                //           _nombreAseguradoPoliza = concatName;
                //         }
                //         formKey.currentState!.save();
                //         formKey.currentState!.didChangeDependencies();
                //       });
                //     } else {
                //       if (_busquedaPoliza.text.length > 2) {
                //         data = suggestion.nombreCliente.toString();
                //         responseNombre = false;
                //         responsePoliza = true;
                //         presenter!
                //             .getPolizasClienteSearch(
                //                 suggestion.idParticipanteConsolidado.toString())
                //             .then((value) => setState(() {
                //                   listaPolizasUsuarios =
                //                       Utils.listPolizaUsuarios;
                //                   if (Utils.listPolizaUsuarios.length > 0) {
                //                     mostrarDropdownPolizas = responsePoliza;
                //                     mostrarDropdownUsuario = responseNombre;
                //                     onChangedropDrop(
                //                         Utils.listPolizaUsuarios[0]);
                //                     _nombreAseguradoPoliza = concatName;
                //                   }
                //                   formKey.currentState!.save();
                //                   formKey.currentState!.didChangeDependencies();
                //                 }));
                //       }
                //     }
                //     this._busquedaPoliza.text = data;
                //   },
                //   noItemsFoundBuilder: (context) => _sinResultados(context),
                // ),
              ),
            ),
          if (gestionroles.visualizandoPorSeccion(
              "directoriosearch", "datos_asegurado_opcional"))
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: catalogoMunicipio!.config!.dropdownSize! * 6 + 40),
                  child: Text("DATOS DEL ASEGURADO (OPCIONAL)",
                      style: TextStyle(
                          color: AppColors.gnpTextSystem2,
                          fontSize: 10,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Container(
                    margin: EdgeInsets.only(
                        top: catalogoMunicipio!.config!.dropdownSize! * 6 - 5),
                    child: Divider(
                      thickness: 1,
                      color: AppColors.divider,
                      height: 60,
                    ),
                  ),
                ),
              ),
            ],
          ),
          //Combo 4
          Padding(
            padding: const EdgeInsets.only(top: 14.0),
            child: Container(
                // El contenido que va bajo el dropdown
                margin: EdgeInsets.only(
                    top: catalogoMunicipio!.config!.dropdownSize! * 3 +
                        75), // El espacio que ocupa el dropdown
                child: GeneraCatalogo(
                  dataObject: catalogoMunicipio,
                  refresh: refresh,
                  idDropdown: 3,
                )),
          ),
          //COMBO 3
          Padding(
            // El cutom Dropdown
            padding: const EdgeInsets.only(top: 14.0),
            child: Container(
                margin: EdgeInsets.only(
                    top: catalogoEstado!.config!.dropdownSize! * 3 -
                        20), //*3 -20 //*3 -45
                child: GeneraCatalogo(
                  dataObject: catalogoEstado,
                  onChange: onchange,
                  refresh: refresh,
                  idDropdown: 2,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14.0),
            child: Container(
              margin: EdgeInsets.only(
                  top: catalogoEstado!.config!.dropdownSize! * 3 - 15),
              child: Text("LOCALIZACIÓN",
                  style: TextStyle(
                      color: AppColors.gnpTextSystem2,
                      fontSize: 10,
                      fontWeight: FontWeight.w500)),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Container(
                      margin: EdgeInsets.only(
                          top: catalogoEstado!.config!.dropdownSize! * 3 - 60),
                      child: Divider(
                        thickness: 1,
                        color: AppColors.divider,
                        height: 60,
                      )),
                ),
              ),
            ],
          ),
          //COMBO 2
          Padding(
            // El custom Dropdown
            padding: const EdgeInsets.only(top: 0),
            child: Container(
                margin:
                    EdgeInsets.only(top: catalogoDos!.config!.dropdownSize! - 35),
                child: GeneraCatalogo(
                  dataObject: catalogoDos,
                  refresh: refresh,
                  idDropdown: 1,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              margin:
                  EdgeInsets.only(top: catalogoDos!.config!.dropdownSize! - 40),
              child: Text("PLAN",
                  style: TextStyle(
                      color: AppColors.gnpTextSystem2,
                      fontSize: 10,
                      fontWeight: FontWeight.w500)),
            ),
          ),

          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Container(
                      margin: EdgeInsets.only(
                          top: catalogoDos!.config!.dropdownSize! - 60),
                      child: Divider(
                        thickness: 1,
                        color: AppColors.divider,
                        height: 20,
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget? seleccionaClinicas() {
    try {
      if ((clinicasEncontradas != null) &&
          (estadosList != null) &&
          (municipiosList != null)) {
        return dropdownClinicas(
            clinicasEncontradas!, estadosList!, municipiosList!);
      } else {
        var clinica = presenter!.getClinicas();
        var estado = presenter!.getEstados();
        var municipio = presenter!.getMunicipios(estadosList![0].claveEstado!);

        return FutureBuilder(
          future: Future.wait([clinica, estado, municipio]),
          builder: (context, snapshot) {
            for (int i = 0; i < 3; i++) {
              var current = i == 0 ? clinica : i == 1 ? estado : municipio;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return loadingPicker(current);
                default:
                  if (snapshot.hasError) {
                    return loadingPicker(current);
                  } else {
                    switch (i) {
                      case 0:
                        clinicasEncontradas = snapshot.data![i] as List<TipoClinica>?;
                        break;
                      case 1:
                        estadosList = snapshot.data![i] as List<Estados>?;
                        break;
                      case 2:
                        municipiosList = snapshot.data![i] as List<Municipios>?;
                        break;
                    }
                  }
              }
            }

            return dropdownClinicas(
                clinicasEncontradas!, estadosList!, municipiosList!);
          },
        );
      }
    } catch (e) {
      print(e);
    }

    return SizedBox();
  }

  Widget dropdownClinicas(List<TipoClinica> clinicas, List<Estados> estados,
      List<Municipios> municipios) {
    clinicas.forEach((element) {
      for (var item in listaTClin == null ? 0 as Iterable : listaTClin) {
        if (element.tipoClinica == item.valor) {
          existeElement = true;
          break;
        }
      }
      if (!existeElement) {
        listaTClin.add(ElementoDd(valor: element.tipoClinica));
      }
      existeElement = false;
    });

    catalogoDos = CatalogoDdObject(
        label: "Tipo de clínica",
        valores: listaTClin,
        config: config,
        selectedItem: catalogoDos == null
            ? 0
            : catalogoDos!.selectedItem == null ? 0 : catalogoDos!.selectedItem);

    estados.forEach((i) {
      for (var item in listaEst == null ? 0 as Iterable : listaEst) {
        if (i.estado == item.valor) {
          existeElement = true;
          break;
        }
      }
      if (!existeElement) {
        listaEst.add(ElementoDd(valor: i.estado));
      }
      existeElement = false;
    });

    catalogoEstado = CatalogoDdObject(
        label: "Estado",
        valores: listaEst,
        config: config,
        selectedItem: Utils.cvEstado != -1
            ? Utils.cvEstado
            : catalogoEstado == null
                ? 0
                : catalogoEstado!.selectedItem == null
                    ? 0
                    : catalogoEstado!.selectedItem);

    municipios.forEach((j) {
      for (var item in listaMun == null ? 0 as Iterable : listaMun) {
        if (j.municipio == item.valor) {
          existeElement = true;
          break;
        }
      }
      if (!existeElement) {
        listaMun.add(ElementoDd(valor: j.municipio));
      }
      existeElement = false;
    });

    catalogoMunicipio =
        CatalogoDdObject(label: "Municipio", valores: listaMun, config: config);

    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              top: catalogoMunicipio!.config!.dropdownSize! * 6 + 60),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: ButtonTheme(
              minWidth: 400.0,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(15.0),
                  backgroundColor: AppColors.secondary900,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
                  child: Text(
                    "Buscar",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        fontFamily: 'Roboto-Bold'),
                  ),
                  onPressed: () {
                    if (municipiosList!.isNotEmpty) {
                      catalogoDos!.selectedItem =
                          catalogoDos!.selectedItem == null
                              ? 0
                              : catalogoDos!.selectedItem;
                      catalogoEstado!.selectedItem =
                          catalogoEstado!.selectedItem == null
                              ? 0
                              : catalogoEstado!.selectedItem;
                      catalogoMunicipio!.selectedItem =
                          catalogoMunicipio!.selectedItem == null
                              ? 0
                              : catalogoMunicipio!.selectedItem;
                      if (clinicasEncontradas![catalogoDos!.selectedItem!]
                              .tipoClinica ==
                          "Todos") {
                        tclinicaSelected =
                            TipoClinica(claveTipoClinica: '', tipoClinica: "");
                      } else {
                        tclinicaSelected = clinicasEncontradas!.length != 0
                            ? clinicasEncontradas![catalogoDos!.selectedItem!]
                            : null;
                      }
                      if (estadosList![catalogoEstado!.selectedItem!].estado ==
                          "Todos") {
                        currentEstado = Estados(claveEstado: "000", estado: "");
                      } else {
                        currentEstado = estadosList!.length != 0
                            ? estadosList![catalogoEstado!.selectedItem!]
                            : null;
                      }
                      if (municipiosList![catalogoMunicipio!.selectedItem!]
                              .municipio ==
                          "Todos") {
                        currentMunicipio =
                            Municipios(claveMunicipio: "", municipio: "");
                      } else {
                        currentMunicipio = municipiosList!.length != 0
                            ? municipiosList![catalogoMunicipio!.selectedItem!]
                            : null;
                      }

                       var tipoClinica = clinicasEncontradas![catalogoDos!.selectedItem!]
                            .claveTipoClinica;

                      var datos2 = Parametros(
                        claveGestion: "",
                        nombre: "",
                        cvTipo: clinicasEncontradas![catalogoDos!.selectedItem!]
                            .claveTipoClinica
                            .toString(),
                        buscador: _clinicas != null ? _clinicas : "",
                        cvEstado: estadosList![catalogoEstado!.selectedItem!]
                            .claveEstado,
                        cvMunicipio:
                            municipiosList![catalogoMunicipio!.selectedItem!]
                                .claveMunicipio,
                        descEstado: estadosList![catalogoEstado!.selectedItem!]
                            .estado,
                        descMunicipio: municipiosList![catalogoMunicipio!.selectedItem!]
                                .municipio,
                        origen: "APPAgentes",
                        tipoClinica : tipoClinica,
                        pagina: 0,
                        dateTime: DateTime.now(),
                      );
                      Utils.lbBuscador = false;
                      if (tclinicaSelected != null &&
                          currentEstado != null &&
                          currentMunicipio != null) {
                        //ENVIA EVENTOS A FIREBASE
                        Map<String, dynamic> eventos = {
                          "estado":
                              estadosList![catalogoEstado!.selectedItem!].estado,
                          "municipio":
                              municipiosList![catalogoMunicipio!.selectedItem!]
                                  .municipio
                        };
                        AnalyticsServices().sendTag("dir_clinicas_localizacion",
                            parameters: eventos);

                        //ENVIA TAGS ANALYTICS
                        presenter!
                            .sendAnalytics(
                                "Clínicas",
                                clinicasEncontradas![catalogoDos!.selectedItem!]
                                    .tipoClinica!,
                                "",
                                estadosList![catalogoEstado!.selectedItem!].estado!,
                                municipiosList![catalogoMunicipio!.selectedItem!]
                                    .municipio!,
                                "")
                            .then((value) => presenter!.showSearch(
                                "Clínicas en convenio",
                                "",
                                clinicasEncontradas![catalogoDos!.selectedItem!]
                                    .tipoClinica!,
                                "",
                                estadosList![catalogoEstado!.selectedItem!].estado!,
                                municipiosList![catalogoMunicipio!.selectedItem!]
                                    .municipio!,
                                datos2,
                                ""));
                      } else {
                        customAlert(
                            AlertDialogType.errorConexion, context, "", "");
                      }
                    }
                  }),
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 0, right: 0),
                child: Container(
                    margin: EdgeInsets.only(
                        top: catalogoMunicipio!.config!.dropdownSize! * 5 + 90),
                    child: Divider(
                      thickness: 1,
                      color: AppColors.scrollbar,
                      height: 60,
                    )),
              ),
            ),
          ],
        ),
        //Combo 3
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Container(
              // El contenido que va bajo el dropdown
              margin: EdgeInsets.only(
                  top: catalogoMunicipio!.config!.dropdownSize! * 3 +
                      70), // El espacio que ocupa el dropdown
              child: GeneraCatalogo(
                dataObject: catalogoMunicipio,
                refresh: refresh,
                idDropdown: 3,
              )),
        ),

        //COMBO 2
        Padding(
          // El cutom Dropdown
          padding: const EdgeInsets.only(top: 0),
          child: Container(
              margin: EdgeInsets.only(
                  top: catalogoEstado!.config!.dropdownSize! * 2 + 60),
              child: GeneraCatalogo(
                dataObject: catalogoEstado,
                onChange: onchange,
                refresh: refresh,
                idDropdown: 2,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            margin: EdgeInsets.only(
                top: catalogoEstado!.config!.dropdownSize! * 2 + 50),
            child: Text("LOCALIZACIÓN",
                style: TextStyle(
                    color: AppColors.gnpTextSystem2,
                    fontSize: 10,
                    fontWeight: FontWeight.w500)),
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Container(
                    margin: EdgeInsets.only(
                        top: catalogoEstado!.config!.dropdownSize! * 2 + 5),
                    child: Divider(
                      thickness: 1,
                      color: AppColors.divider,
                      height: 60,
                    )),
              ),
            ),
          ],
        ),
        //COMBO 1
        Padding(
          // El cutom Dropdown
          padding: const EdgeInsets.only(top: 0),
          child: Container(
              margin: EdgeInsets.only(
                  top: catalogoDos!.config!.dropdownSize! * 1 - 43),
              child: GeneraCatalogo(
                dataObject: catalogoDos,
                refresh: refresh,
                idDropdown: 1,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Container(
            margin: EdgeInsets.only(top: catalogoDos!.config!.dropdownSize! - 45),
            child: Text("CLÍNICAS",
                style: TextStyle(
                    color: AppColors.gnpTextSystem2,
                    fontSize: 10,
                    fontWeight: FontWeight.w500)),
          ),
        ),

        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Container(
                    margin: EdgeInsets.only(
                        top: catalogoDos!.config!.dropdownSize! - 70),
                    child: Divider(
                      thickness: 1,
                      color: AppColors.divider,
                      height: 20,
                    )),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget? seleccionaTServicio() {
    try {
      if ((tipoServiciosList != null) &&
          (estadosList != null) &&
          (municipiosList != null)) {
        return dropdownOtrosServicios(
            tipoServiciosList!, estadosList!, municipiosList!);
      } else {
        var tipoServicio = presenter!.getTipoServicio();
        var estado = presenter!.getEstados();
        var municipio = presenter!.getMunicipios(estadosList![0].claveEstado!);

        return FutureBuilder(
          future: Future.wait([tipoServicio, estado, municipio]),
          builder: (context, snapshot) {
            for (int i = 0; i < 3; i++) {
              var current = i == 0 ? tipoServicio : i == 1 ? estado : municipio;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return loadingPicker(current);
                default:
                  if (snapshot.hasError) {
                    return loadingPicker(current);
                  } else {
                    switch (i) {
                      case 0:
                        tipoServiciosList = snapshot.data![i] as List<TipoServicios>?;
                        break;
                      case 1:
                        estadosList = snapshot.data![i] as List<Estados>?;
                        break;
                      case 2:
                        municipiosList = snapshot.data![i] as List<Municipios>?;
                        break;
                    }
                  }
              }
            }

            return dropdownOtrosServicios(
                tipoServiciosList!, estadosList!, municipiosList!);
          },
        );
      }
    } catch (e) {
      print(e);
    }
    return SizedBox();
  }

  Widget dropdownOtrosServicios(List<TipoServicios> otrosServicios,
      List<Estados> estados, List<Municipios> municipios) {
    otrosServicios.forEach((element) {
      for (var item in listaOServ == null ? 0 as Iterable : listaOServ) {
        if (element.tipoProveedor == item.valor) {
          existeElement = true;
          break;
        }
      }
      if (!existeElement) {
        listaOServ.add(ElementoDd(valor: element.tipoProveedor));
      }
      existeElement = false;
    });

    catalogoDos = CatalogoDdObject(
        label: "Tipo de servicios",
        valores: listaOServ,
        config: config,
        selectedItem: catalogoDos == null
            ? 0
            : catalogoDos!.selectedItem == null ? 0 : catalogoDos!.selectedItem);

    estados.forEach((i) {
      for (var item in listaEst == null ? 0 as Iterable : listaEst) {
        if (i.estado == item.valor) {
          existeElement = true;
          break;
        }
      }
      if (!existeElement) {
        listaEst.add(ElementoDd(valor: i.estado));
      }
      existeElement = false;
    });

    catalogoEstado = CatalogoDdObject(
        label: "Estado",
        valores: listaEst,
        config: config,
        selectedItem: Utils.cvEstado != -1
            ? Utils.cvEstado
            : catalogoEstado == null
                ? 0
                : catalogoEstado!.selectedItem == null
                    ? 0
                    : catalogoEstado!.selectedItem);

    municipios.forEach((j) {
      for (var item in listaMun == null ? 0 as Iterable : listaMun) {
        if (j.municipio == item.valor) {
          existeElement = true;
          break;
        }
      }
      if (!existeElement) {
        listaMun.add(ElementoDd(valor: j.municipio));
      }
      existeElement = false;
    });

    catalogoMunicipio =
        CatalogoDdObject(label: "Municipio", valores: listaMun, config: config);

    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            top: catalogoMunicipio!.config!.dropdownSize! * 6 + 45,
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: ButtonTheme(
              minWidth: 400.0,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(15.0),
                  backgroundColor: AppColors.secondary900,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                child: Text(
                    "Buscar",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        fontFamily: 'Roboto-Bold'),
                  ),
                  onPressed: () {
                    if (municipiosList!.isNotEmpty) {
                      catalogoDos!.selectedItem =
                          catalogoDos!.selectedItem == null
                              ? 0
                              : catalogoDos!.selectedItem;
                      catalogoEstado!.selectedItem =
                          catalogoEstado!.selectedItem == null
                              ? 0
                              : catalogoEstado!.selectedItem;
                      catalogoMunicipio!.selectedItem =
                          catalogoMunicipio!.selectedItem == null
                              ? 0
                              : catalogoMunicipio!.selectedItem;
                      if (tipoServiciosList![catalogoDos!.selectedItem!]
                              .tipoProveedor ==
                          "Todos") {
                        currentTipoServicio = TipoServicios(
                            claveTipoProveedor: 0, tipoProveedor: "");
                      } else {
                        currentTipoServicio = tipoServiciosList!.length != 0
                            ? tipoServiciosList![catalogoDos!.selectedItem!]
                            : null;
                      }
                      if (estadosList![catalogoEstado!.selectedItem!].estado ==
                          "Todos") {
                        currentEstado = Estados(claveEstado: "000", estado: "");
                      } else {
                        currentEstado = estadosList!.length != 0
                            ? estadosList![catalogoEstado!.selectedItem!]
                            : null;
                      }
                      if (municipiosList![catalogoMunicipio!.selectedItem!]
                              .municipio ==
                          "Todos") {
                        currentMunicipio =
                            Municipios(claveMunicipio: "", municipio: "");
                      } else {
                        currentMunicipio = municipiosList!.length != 0
                            ? municipiosList![catalogoMunicipio!.selectedItem!]
                            : null;
                      }
                      var datos2 = Parametros(
                        claveGestion: "",
                        nombre: "",
                        cvTipo:
                            currentTipoServicio!.claveTipoProveedor.toString(),
                        buscador:
                            _otrosServicios != null ? _otrosServicios : "",
                        cvEstado: currentEstado!.claveEstado,
                        cvMunicipio: currentMunicipio!.claveMunicipio,
                        pagina: 0,
                        dateTime: DateTime.now(),
                      );
                      Utils.lbBuscador = false;
                      if (currentTipoServicio != null &&
                          currentEstado != null &&
                          currentMunicipio != null) {
                        //ENVIA EVENTOS A FIREBASE
                        AnalyticsServices().sendTag("dir_otros_servicio");
                        Map<String, dynamic> eventos = {
                          "estado":
                              estadosList![catalogoEstado!.selectedItem!].estado,
                          "municipio":
                              municipiosList![catalogoMunicipio!.selectedItem!]
                                  .municipio
                        };
                        AnalyticsServices().sendTag("dir_otros_localizacion",
                            parameters: eventos);

                        //ENVIA TAGS ANALYTICS
                        presenter!
                            .sendAnalytics(
                                "Otros servicios de salud",
                                tipoServiciosList![catalogoDos!.selectedItem!]
                                    .tipoProveedor!,
                                "",
                                estadosList![catalogoEstado!.selectedItem!].estado!,
                                municipiosList![catalogoMunicipio!.selectedItem!]
                                    .municipio!,
                                "")
                            .then((value) => presenter!.showSearch(
                                "Otros servicios de salud",
                                "",
                                tipoServiciosList![catalogoDos!.selectedItem!]
                                    .tipoProveedor!,
                                "",
                                estadosList![catalogoEstado!.selectedItem!].estado!,
                                municipiosList![catalogoMunicipio!.selectedItem!]
                                    .municipio!,
                                datos2,
                                ""));
                      } else {
                        customAlert(
                            AlertDialogType.errorConexion, context, "", "");
                      }
                    }
                  }),
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 0, right: 0),
                child: Container(
                    margin: EdgeInsets.only(
                        top: catalogoMunicipio!.config!.dropdownSize! * 5 + 75),
                    child: Divider(
                      thickness: 1,
                      color: AppColors.scrollbar,
                      height: 60,
                    )),
              ),
            ),
          ],
        ),
        //Combo 3
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Container(
              // El contenido que va bajo el dropdown
              margin: EdgeInsets.only(
                  top: catalogoMunicipio!.config!.dropdownSize! * 3 +
                      70), // El espacio que ocupa el dropdown
              child: GeneraCatalogo(
                dataObject: catalogoMunicipio,
                refresh: refresh,
                idDropdown: 3,
              )),
        ),

        //COMBO 2
        Padding(
          // El cutom Dropdown
          padding: const EdgeInsets.only(top: 0),
          child: Container(
              margin: EdgeInsets.only(
                  top: catalogoEstado!.config!.dropdownSize! * 2 + 60),
              child: GeneraCatalogo(
                dataObject: catalogoEstado,
                onChange: onchange,
                refresh: refresh,
                idDropdown: 2,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            margin: EdgeInsets.only(
                top: catalogoEstado!.config!.dropdownSize! * 2 + 50),
            child: Text("LOCALIZACIÓN",
                style: TextStyle(
                    color: AppColors.gnpTextSystem2,
                    fontSize: 10,
                    fontWeight: FontWeight.w500)),
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Container(
                    margin: EdgeInsets.only(
                        top: catalogoEstado!.config!.dropdownSize! * 2 + 5),
                    child: Divider(
                      thickness: 1,
                      color: AppColors.divider,
                      height: 60,
                    )),
              ),
            ),
          ],
        ),
        //COMBO 1
        Padding(
          // El cutom Dropdown
          padding: const EdgeInsets.only(top: 0),
          child: Container(
              margin: EdgeInsets.only(
                  top: catalogoDos!.config!.dropdownSize! * 1 - 43),
              child: GeneraCatalogo(
                dataObject: catalogoDos,
                refresh: refresh,
                idDropdown: 1,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Container(
            margin: EdgeInsets.only(top: catalogoDos!.config!.dropdownSize! - 45),
            child: Text("OTROS SERVICIOS",
                style: TextStyle(
                    color: AppColors.gnpTextSystem2,
                    fontSize: 10,
                    fontWeight: FontWeight.w500)),
          ),
        ),

        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Container(
                    margin: EdgeInsets.only(
                        top: catalogoDos!.config!.dropdownSize! - 70),
                    child: Divider(
                      thickness: 1,
                      color: AppColors.divider,
                      height: 20,
                    )),
              ),
            ),
          ],
        ),
      ],
    );
  }

  bool _busquedaPorPoliza(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  Widget _sinResultados(BuildContext context) {
    /*Future.delayed(Duration(milliseconds: 2000), () => showAlertZeroResults( context));
    return ListTile(
        title: Text('Sin Resultados'),
      );*/
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        'No se encontraron resultados',
        textAlign: TextAlign.center,
        style:
            TextStyle(color: Theme.of(context).disabledColor, fontSize: 18.0),
      ),
    );
  }

  void showAlertZeroResults(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            title: new Text("Búsqueda sin resultados "),
            content: new Text(
              "No se encontró ninguna póliza con el nombre o número de póliza especificado. "
              "\n Verifica que los datos especificados y vuelve a realizar tu búsqueda. "
              "\n Si el problema persiste, puedes ponerte en contacto al 800 5227 900",
            ),
            actions: <Widget>[
              TextButton(
                child: new Text(
                  "Aceptar",
                  style: TextStyle(color: Utilidades.color_primario),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      },
    );
  }
}
