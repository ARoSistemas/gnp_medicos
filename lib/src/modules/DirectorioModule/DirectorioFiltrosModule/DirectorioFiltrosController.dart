import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioFiltrosModule/DirectorioFiltrosContract.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioFiltrosModule/DirectorioFiltrosPresenter.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioSearchModule/CatalogoDdObject.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioSearchModule/GeneraCatalogoDd.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Catalogos.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Parametros.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/AppColors.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/Utils.dart';
import 'package:flutter/material.dart';

class DirectorioFiltrosController extends StatefulWidget{
  DirectorioFiltrosController({Key? key, this.servicio, this.parametros, this.catalogo, this.poliza, this.especialidad})
      : super(key: key);
  final String? servicio;
  final Parametros? parametros;
  final String? catalogo;
  final String? poliza;
  final String? especialidad;

  @override
  DirectorioFiltrosControllerState createState() =>
      DirectorioFiltrosControllerState(servicio!, parametros!, catalogo!, poliza!, especialidad!);

}

class DirectorioFiltrosControllerState extends State<DirectorioFiltrosController>
    implements DirectorioFiltrosView{

  bool existeElement = false;
  String? estado;
  String? municipio;
  String? catalogodos;
  String? catalogo;
  String? especialidad;
  Parametros? parametros;
  String? poliza;

  DirectorioFiltrosPresenter? presenter;
  String? servicio;
  Widget currentContent = Scaffold();

  List<Estados>? estadosList;
  Estados? currentEstado;

  List<Municipios>? municipiosList;
  Municipios? currentMunicipio;

  List<NivelHospitalario>? nivelHospList;
  Planes? currentNivelHosp;

  List<CirculoMedico>? circulosList;
  CirculoMedico? currentCirculo;

  CatalogoDdObject? catalogoUno;
  CatalogoDdObject? catalogoDos;
  CatalogoDdObject? catalogoEstado;
  CatalogoDdObject? catalogoMunicipio;

  List<ElementoDd>? listaPla = [];
  List<ElementoDd>? listaCM = [];
  List<ElementoDd>? listaEst = [];
  List<ElementoDd>? listaMun = <ElementoDd>[];

  ConfiguracionDd config = ConfiguracionDd(
      selectedTextItemColor: AppColors.secondary900, // Color del texto del elemento seleccionado de la lista de opciones
      textItemColor: AppColors.gnpTextSystem,//Color por defecto de todos los elementos de la lista de opciones cuando no se han seleccionado
      defaultSelectedIndex: 0, //El que se muestra por defecto
      labelColorActive: AppColors.secondary900, //color del label cuando esta abierto
      listSize: 150, //la altura de la lista desplegable (que tiene scroll)
      innnerMargin: 10, // margen interno entre la label, y el borde. Margen el icono y el borde
      dropdownSize: 70, // La altura del boton que despliega la lista, DOUBLE
      labelColor: AppColors.gnpTextSystem2, // Color del label cuando no está activo
      borderColor: AppColors.primary200, //Color del borde cuando no está activo
      activeBorderColor: AppColors.secondary900, // Color del borde del boton que despliega la lista cuando está abierta
      borderSize: 1 , //linea inferior
      dropdownBackgroundColor: Colors.white, // El background del boton que despliega la lista
      selectedColor: AppColors.secondary50, //Color del elemento seleccionado
      icon: Icon(Icons.arrow_drop_down,
          color: AppColors.gnpTextSystem2));


  DirectorioFiltrosControllerState(String servicio, Parametros parametros, String catalogo, String poliza, String especialidad){
    this.presenter = DirectorioFiltrosPresenter(this);
    this.servicio =  servicio;
    this.catalogo = catalogo;
    this.parametros = parametros;
    this.poliza = poliza;
    this.especialidad = especialidad;
  }

  onchange(){
    setState(() {
      //actualizar catalogo municipio
      print(estadosList![catalogoEstado!.selectedItem!].claveEstado);
      if(Utils.cvEstado != catalogoEstado!.selectedItem && catalogoEstado!.label == "Estado"){
        Utils.cvEstado = catalogoEstado!.selectedItem!;
        Utils.listMunicipiosFiltros.clear();
        catalogoMunicipio!.valores!.clear();
        catalogoMunicipio!.selectedItem = 0;
        presenter!.getMunicipios(estadosList![Utils.cvEstado].claveEstado!).then((value) =>
        (municipiosList = Utils.listMunicipiosFiltros)).then((value) =>
            municipiosList!.forEach((j) {
              for(var item in (listaMun == null ? 0 : listaMun) as List){
                if(j.municipio == item.valor){
                  existeElement = true;
                  break;
                }
              }
              if(!existeElement){
                listaMun!.add(ElementoDd(valor: j.municipio!));
              }
              existeElement = false;
            })).then((value) =>
        (print("nueva lista")));
      }
    });
  }

  refresh(){
    setState(() {

    });
  }

  @override
  void initState() {
    Utils.cvEstado = -1;
    Utils.vistaDirectorio = "filtros";
    Utils.focusDropdown = 0;
    if(Utils.listEstados.isEmpty){
      presenter?.getEstados();
      if(estadosList!.isNotEmpty){
        Utils.listMunicipiosFiltros.clear();
        presenter!.getMunicipios(estadosList![0].claveEstado!).then((value) => (municipiosList = Utils.listMunicipiosFiltros));
      }
    }else{
      setState(() {
        estadosList = Utils.listEstados;
        if(estadosList!.isNotEmpty && Utils.listMunicipiosFiltros.isEmpty){
          presenter?.getMunicipios(estadosList![0].claveEstado!);
        }
        else{
          municipiosList = Utils.listMunicipiosFiltros;
        }
      });
    }

    if(Utils.listNiveles.isEmpty){
      presenter?.getNivelHospitalario(parametros!.cvPlanH, parametros!.productoTecnico, parametros!.productoComercial);
    }else{
      setState(() {
        nivelHospList = Utils.listNiveles;
      });
    }
    /*if(Utils.listCirculos.isEmpty){
      presenter?.getCirculosM();
    }else{
      setState(() {
        circulosList = Utils.listCirculos;
      });
    }*/

    setState(() {
      circulosList = Utils.listCirculosFiltros;
    });

    switch (widget.servicio) {
      case "Hospitales en convenio":
        currentContent = getFiltrosHospitales();
        break;

      case "Médicos en convenio":
        currentContent = getFiltrosMedicos();
        break;

      case "Médico":
        currentContent = getFiltrosMedicos();
        break;

      case "Hospital":
        currentContent = getFiltrosHospitales();
        break;
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    switch (widget.servicio) {
      case "Hospitales en convenio":
        return getFiltrosHospitales();
        break;

      case "Médicos en convenio":
        return getFiltrosMedicos();
        break;

      case "Médico":
        return getFiltrosMedicos();
        break;

      case "Hospital":
        return getFiltrosHospitales();
        break;
      default:
        return Container();
        break;
    }
  }

   getFiltrosHospitales(){
    return WillPopScope(
      onWillPop: () {
        Utils.vistaDirectorio = "search";
        presenter!.backToHome();
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.orange),
            title: Text(
              "Filtros",
              style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.dirTextColor),
            ),
            elevation: 0.0,
            surfaceTintColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                Utils.vistaDirectorio = "search";
                presenter!.backToHome();
              },
            ),
          ),
          body: Container(
              padding: EdgeInsets.only(top: 0, left: 20, right: 20),
              color: Colors.white,
              child: ListView(
                  physics: ClampingScrollPhysics(),
                  children: [

                    seleccionaHospitales()!,

                  ]
              )),
          bottomSheet: Container(
            width: double.infinity,
            padding: const EdgeInsets.only( bottom: 16.0, right: 16, left: 16),
            child: ButtonTheme(
              minWidth: 400.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),),
              child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.secondary900,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.only(right: 10.0, top: 15.0, bottom:15.0, left: 10.0),
                  ),
                  //color: AppColors.secondary900,
                  //textColor: Colors.white,
                  //padding: EdgeInsets.only(right: 10.0, top: 15.0, bottom:15.0, left: 10.0),
                  child: Text(
                    "Aplicar",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18,fontFamily: 'Roboto-Bold'),
                  ),
                  onPressed: () {
                    if(catalogoMunicipio!.valores!.isNotEmpty){
                      print("Parametros");
                      //setState(() {
                      poliza = this.poliza;
                      estado = catalogoEstado!.valores!.elementAt(catalogoEstado?.selectedItem == null ? 0 : catalogoEstado!.selectedItem!).valor;
                      municipio = catalogoMunicipio!.valores!.elementAt(catalogoMunicipio?.selectedItem == null ? 0 : catalogoMunicipio!.selectedItem!).valor;
                      catalogodos = catalogoDos!.valores!.elementAt(catalogoDos?.selectedItem == null ? 0 : catalogoDos!.selectedItem!).valor;

                      setState(() {
                        widget.parametros?.cvEstado = estadosList![catalogoEstado?.selectedItem == null ? 0 : catalogoEstado!.selectedItem!].claveEstado;
                        widget.parametros?.cvMunicipio = municipiosList![catalogoMunicipio?.selectedItem == null ? 0 : catalogoMunicipio!.selectedItem!].claveMunicipio;
                        widget.parametros?.claveNivelHospitalario =  Utils.listNivelesFiltros.isNotEmpty ? Utils.listNivelesFiltros[catalogoDos?.selectedItem == null ? 0 : catalogoDos!.selectedItem!].claveNivelHospitalario : "0";
                        widget.parametros?.filtros = true;
                        widget.parametros?.pagina = 0;
                      });
                      // });
                      Utils.listMunicipiosFiltros.clear();
                      Utils.cvEstado = -1;
                      Utils.vistaDirectorio = "search";
                      Navigator.pop(context);
                      Navigator.pop(context);
                      presenter?.showSearch("Hospitales en convenio", "", catalogodos!, widget.catalogo!, estado!, municipio!, widget.parametros!, poliza!, widget.parametros!.filtros!);
                    }
                  }),
            ),
          ),
      ),
    );
  }

   getFiltrosMedicos(){
    return WillPopScope(
      onWillPop: () {
        Utils.vistaDirectorio = "search";
        presenter?.backToHome();
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.orange),
            title: Text(
              "Filtros",
              style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.dirTextColor
              ),
            ),
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                Utils.vistaDirectorio = "search";
                presenter!.backToHome();
              },
            ),
          ),
          body: Container(
              padding: EdgeInsets.only(top: 0, left: 20, right: 20),
              color: Colors.white,
              child: ListView(
                  physics: ClampingScrollPhysics(),
                  children: [

                    seleccionaMedicos()!,
                  ]
              )),
          bottomSheet: Container(
            width: double.infinity,
            padding: const EdgeInsets.only( bottom: 16.0, right: 16, left: 16),
            child: ButtonTheme(
              minWidth: 400.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.secondary900,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.only(right: 10.0, top: 15.0, bottom:15.0, left: 10.0),
                ),
                  //color: AppColors.secondary900,
                  //textColor: Colors.white,
                  //padding: EdgeInsets.only(right: 10.0, top: 15.0, bottom:15.0, left: 10.0),
                  child: Text(
                    "Aplicar",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18,fontFamily: 'Roboto-Bold'),
                  ),
                  onPressed: () {
                    if(catalogoMunicipio!.valores!.isNotEmpty){
                      // setState(() {
                      poliza = this.poliza;
                      estado = catalogoEstado!.valores!.elementAt(catalogoEstado?.selectedItem == null ? 0 : catalogoEstado!.selectedItem!).valor;
                      municipio = catalogoMunicipio!.valores!.elementAt(catalogoMunicipio?.selectedItem == null ? 0 : catalogoMunicipio!.selectedItem!).valor;
                      catalogo = catalogoDos!.valores!.elementAt(catalogoDos?.selectedItem == null ? 0 : catalogoDos!.selectedItem!).valor;

                      widget.parametros!.cvEstado = estadosList![catalogoEstado?.selectedItem == null ? 0 : catalogoEstado!.selectedItem!].claveEstado;
                      widget.parametros!.cvMunicipio = municipiosList![catalogoMunicipio?.selectedItem == null ? 0 : catalogoMunicipio!.selectedItem!].claveMunicipio;
                      widget.parametros!.cvCirculoM = circulosList![catalogoDos?.selectedItem == null ? 0 :catalogoDos!.selectedItem!].claveCirculoMedico;
                      widget.parametros!.pagina = 0;

                      if(catalogo!.contains(" - contratado")){
                        widget.parametros!.bandera = true;
                      }else{
                        widget.parametros!.bandera = false;
                      }
                      // });
                      widget.parametros!.filtros = true;
                      Utils.listMunicipiosFiltros.clear();
                      Utils.cvEstado = -1;
                      Utils.vistaDirectorio = "search";
                      Navigator.pop(context);
                      Navigator.pop(context);
                      presenter!.showSearch("Médicos en convenio", "", catalogo!, especialidad!, estado!, municipio!, widget.parametros!, poliza!, widget.parametros!.filtros!);
                    }
                  }),
            ),
          ),
      ),
    );
  }

  Widget loadingPicker(valor) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 100.0, bottom: 100.0),
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

  Widget? seleccionaHospitales(){
    try{
      if((nivelHospList != null && nivelHospList!.isNotEmpty) && (estadosList != null && estadosList!.isNotEmpty)
          && (municipiosList != null && municipiosList!.isNotEmpty)){
        return dropdownHospitales(nivelHospList!, estadosList!, municipiosList!);
      }else{
        var nivel = presenter!.getNivelHospitalario(parametros!.cvPlanH!, parametros!.productoTecnico!, parametros!.productoComercial!);
        var estado = presenter!.getEstados();
        var municipio = presenter!.getMunicipios(estadosList![Utils.cvEstado != -1 ? Utils.cvEstado : 0].claveEstado!);

        return FutureBuilder(
          future: Future.wait([nivel, estado, municipio]),
          builder: (context, snapshot){

            for(int i = 0; i<3; i++){
              var current = i == 0 ? nivel : i == 1 ? estado : municipio;
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
                        nivelHospList = snapshot.data?[i] as List<NivelHospitalario>;
                        break;
                      case 1:
                        estadosList = snapshot.data?[i] as List<Estados>;
                        break;
                      case 2:
                        municipiosList = snapshot.data?[i] as List<Municipios>;
                        break;
                    }
                  }
              }
            }

            return dropdownHospitales(nivelHospList!, estadosList!, municipiosList!);
          },
        );
      }
    }catch(e){
      print(e);
    }

  }

  Widget dropdownHospitales(List<NivelHospitalario> nivelH, List<Estados> estados, List<Municipios> municipios){

    nivelH.forEach((i) {
      for(var item in (listaPla == null ? 0 : listaPla) as List){

        if(i.nivelHospitalario == item.valor){
          existeElement = true;
          break;
        }
      }
      if(!existeElement){
        listaPla!.add(ElementoDd(valor: i.nivelHospitalario!));
      }
      existeElement = false;
    });
    catalogoDos = CatalogoDdObject (label: "Nivel hospitalario", valores: listaPla!, config: config, selectedItem: catalogoDos == null ? 0 : catalogoDos?.selectedItem == null && listaPla!.length>1 && listaPla![0].valor!.contains("contratado") ? 0 : catalogoDos!.selectedItem);

    estados.forEach((i) {
      for(var item in (listaEst == null ? 0 : listaEst)as List){

        if(i.estado == item.valor){
          existeElement = true;
          break;
        }
      }
      if(!existeElement){
        listaEst!.add(ElementoDd(valor: i.estado!));
      }
      existeElement = false;
    });

    catalogoEstado = CatalogoDdObject (label: "Estado", valores: listaEst!, config: config, selectedItem: (Utils.cvEstado != -1 ? Utils.cvEstado : null));

    municipios.forEach((j) {
      for(var item in (listaMun == null ? 0 : listaMun)as List){

        if(j.municipio == item.valor){
          existeElement = true;
          break;
        }
      }
      if(!existeElement){
        listaMun!.add(ElementoDd(valor: j.municipio!));
      }
      existeElement = false;
    });

    catalogoMunicipio = CatalogoDdObject (label: "Municipio", valores: listaMun!, config: config, selectedItem: catalogoMunicipio == null ? 0 : catalogoMunicipio?.selectedItem == null ? 0 : catalogoMunicipio!.selectedItem);

    return Stack(
      children: <Widget>[

        //Combo 3
        Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Container(// El contenido que va bajo el dropdown
              margin: EdgeInsets.only(top: catalogoMunicipio!.config!.dropdownSize! *2 +20), // El espacio que ocupa el dropdown * 2 +20
              child: GeneraCatalogo(dataObject: catalogoMunicipio!, refresh: refresh, idDropdown: 3)

          ),
        ),

        //COMBO 2
        Padding( // El cutom Dropdown
          padding: const EdgeInsets.only(top: 0.0),
          child: Container(
              margin: EdgeInsets.only(top: catalogoEstado!.config!.dropdownSize! *1 +10), //* 1 +10
              child: GeneraCatalogo(dataObject: catalogoEstado!,onChange: onchange, refresh: refresh, idDropdown: 2,)
          ),
        ),

        //COMBO 1
        Padding( // El cutom Dropdown
          padding: const EdgeInsets.only(top: 0.0),
          child: Container(
              margin: EdgeInsets.only(top: catalogoDos!.config!.dropdownSize! *1 -70), //*1 -70
              child: GeneraCatalogo(dataObject: catalogoDos!, refresh: refresh, idDropdown: 1,)
          ),
        ),
      ],
    );
  }

  Widget? seleccionaMedicos(){
    try{
      if((circulosList != null && circulosList!.isNotEmpty) && (estadosList != null && estadosList!.isNotEmpty)
          && (municipiosList != null && municipiosList!.isNotEmpty)){
        return dropdownMedicos(circulosList!, estadosList!, municipiosList!);
      }else{
        var circulo = presenter!.getCirculosM();
        var estado = presenter!.getEstados();
        var municipio = presenter!.getMunicipios(estadosList![Utils.cvEstado != -1 ? Utils.cvEstado : 0].claveEstado!);

        return FutureBuilder(
          future: Future.wait([circulo, estado, municipio]),
          builder: (context, snapshot){

            for(int i = 0; i<3; i++){
              var current = i == 0 ? circulo : i == 1 ? estado : municipio;
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
                        circulosList = snapshot.data?[i] as List<CirculoMedico>;
                        break;
                      case 1:
                        estadosList = snapshot.data?[i] as List<Estados>;
                        break;
                      case 2:
                        municipiosList = snapshot.data?[i] as List<Municipios>;
                        break;
                    }
                  }
              }
            }

            return dropdownMedicos(circulosList!, estadosList!, municipiosList!);
          },
        );
      }
    }catch(e){
      print(e);
    }

  }

  Widget dropdownMedicos(List<CirculoMedico> circulos, List<Estados> estados, List<Municipios> municipios){

    circulos.forEach((i) {
      for(var item in (listaCM == null ? 0 : listaCM)as List){

        if(i.circuloMedico == item.valor || i.circuloMedico!.toUpperCase()+" - contratado" == item.valor){
          existeElement = true;
          break;
        }
      }
      if(!existeElement){
        listaCM!.add(ElementoDd(valor: i.circuloMedico!));
      }
      existeElement = false;
    });
    catalogoDos = CatalogoDdObject (label: "Círculo o tabulador médico", valores: listaCM!, config: config, selectedItem: catalogoDos == null ? 0 : catalogoDos?.selectedItem == null ? 0 : catalogoDos!.selectedItem);

    estados.forEach((i) {
      for(var item in (listaEst == null ? 0 : listaEst)as List){

        if(i.estado == item.valor){
          existeElement = true;
          break;
        }
      }
      if(!existeElement){
        listaEst!.add(ElementoDd(valor: i.estado!));
      }
      existeElement = false;
    });

    catalogoEstado = CatalogoDdObject (label: "Estado", valores: listaEst!, config: config, selectedItem: (Utils.cvEstado != -1 ? Utils.cvEstado as int: null));

    municipios.forEach((j) {
      for(var item in (listaMun == null ? 0 : listaMun) as List){

        if(j.municipio == item.valor){
          existeElement = true;
          break;
        }
      }
      if(!existeElement){
        listaMun!.add(ElementoDd(valor: j.municipio!));
      }
      existeElement = false;
    });

    catalogoMunicipio = CatalogoDdObject (label: "Municipio", valores: listaMun!, config: config, selectedItem: catalogoMunicipio == null ? 0 : catalogoMunicipio?.selectedItem == null ? 0 : catalogoMunicipio!.selectedItem);

    return Stack(
      children: <Widget>[
        //Combo 3
        Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Container(// El contenido que va bajo el dropdown
              margin: EdgeInsets.only(top: catalogoMunicipio!.config!.dropdownSize! * 2 +20), // El espacio que ocupa el dropdown
              child: GeneraCatalogo(dataObject: catalogoMunicipio!, refresh: refresh, idDropdown: 3,)

          ),
        ),

        //COMBO 2
        Padding( // El cutom Dropdown
          padding: const EdgeInsets.only(top: 0),
          child: Container(
              margin: EdgeInsets.only(top: catalogoEstado!.config!.dropdownSize! * 1 +10),
              child: GeneraCatalogo(dataObject: catalogoEstado!,onChange: onchange, refresh: refresh, idDropdown: 2,)
          ),
        ),

        //COMBO 1
        Padding( // El cutom Dropdown
          padding: const EdgeInsets.only(top: 0),
          child: Container(
              margin: EdgeInsets.only(top: catalogoDos!.config!.dropdownSize! * 1 - 70),
              child: GeneraCatalogo(dataObject: catalogoDos!, refresh: refresh, idDropdown: 1,)
          ),
        ),
      ],
    );
  }

}