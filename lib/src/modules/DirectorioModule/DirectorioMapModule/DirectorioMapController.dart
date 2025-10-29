import 'dart:async';
import 'dart:io';
import 'package:agentesgnp/CommonsV2/Widgets/CustomAlerts.dart';
import 'package:agentesgnp/EnvironmentVariablesSetup/app_config.dart';
import 'package:agentesgnp/RequestHandler/MyRequest.dart';
import 'package:agentesgnp/RequestHandler/MyResponse.dart';
import 'package:agentesgnp/RequestHandler/RequestHandler.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioMapModule/DirectorioMapContract.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioMapModule/DirectorioMapPresenter.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioResultsModule/SearchResult.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/AppColors.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/Utils.dart';
import 'package:agentesgnp/Utils/ConnectionManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/constants.dart' as Constants;
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class DirectorioMapController extends StatefulWidget {
  DirectorioMapController(
      {Key? key, this.searchResult, this.title, this.catalogo})
      : super(key: key);
  final SearchResult? searchResult;
  final String? title;
  final String? catalogo;

  @override
  DirectorioMapControllerState createState() =>
      DirectorioMapControllerState(searchResult!, title!, catalogo!);
}

class DirectorioMapControllerState extends State<DirectorioMapController>
    implements DirectorioMapView {
  DirectorioMapPresenter? presenter;
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? _mapController;
  static LatLng _center = LatLng(19.483945, -99.689972);
  static LatLng _lastMapPosition = LatLng(19.348573, -99.129698);

  SearchResult? searchResult;
  String? title, currentloc, lastloc, catalogo;
  Set<Marker>? _markers = {};
  Set<Polyline>? _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  BitmapDescriptor? sourceIcon;
  bool car = false;
  bool walk = false;
  bool distanceVisible = false;
  Polyline? polyline;
  PolylineResult? result;
  var inactiveBoton = AppColors.gnpTextSystem2;
  var activeBoton = AppColors.secondary900;
  final availableMaps = MapLauncher.installedMaps;
  String distancia = "";

  //variables para controlar etiqueta
  var colorBeneficio = AppColors.stateVali,
      colorPenalizacion = AppColors.ribbonError,
      colorContratado = AppColors.ribbonAlert;
  bool activarEtiquetaBeneficio = false, 
      activarEtiquetaPenalizacion = false, 
      activarEtiquetaContratado = false, 
      activarEtiquetaNoContratado = false;

  DirectorioMapControllerState(
      SearchResult searchResult, String title, String catalogo) {
    this.presenter = DirectorioMapPresenter(this);
    this.searchResult = searchResult;

    _center = LatLng(double.parse(this.searchResult?.latitud??""), double.parse(this.searchResult?.longitud??""));
    _lastMapPosition = LatLng(double.parse(this.searchResult?.latitud??""), double.parse(this.searchResult?.longitud??""));
    this.title = title;
    this.catalogo = catalogo;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    _mapController = controller;
  }

  Future<void> _getUserLocation(String Ubicacion) async {
    if (Utils.permissions == false) {
      await requestLocationPermission();
    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if(_lastMapPosition == LatLng(0.0, 0.0)){
      _lastMapPosition = LatLng(position.latitude, position.longitude);
    }
    var ubicacion = Ubicacion.contains("myubication") ? _center : _lastMapPosition;
    if (this.mounted) {
      setState(() {
        _center = LatLng(position.latitude, position.longitude);
        _mapController!.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: ubicacion, zoom: 15.0)));
        _markers!.add(Marker(
          markerId: MarkerId('dest'),
          position: ubicacion,
          icon: sourceIcon!,
        ));
      });
    }
  }

  showAlert() {
    switch (this.searchResult!.tipo.toString()) {
      case "CONTRATADO":
        setState(() {
          activarEtiquetaContratado = true;
        });
        break;
      case "BENEFICIO":
        setState(() {
          activarEtiquetaBeneficio = true;
        });
        break;
      case "PENALIZACION":
        setState(() {
          activarEtiquetaPenalizacion = true;
        });
        break;
      case "NO_CONTRATADO":
        setState(() {
          activarEtiquetaNoContratado = true;
        });
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserLocation("Place");
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(26, 26)), "assets/img/point_map.png")
        .then((d) {sourceIcon = d;});

    if (this.searchResult!.alertaMensaje != "") {
      showAlert();
    }
  }

  showLoading(BuildContext context) async {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
        builder: (context) => Container(
          color: Colors.white,
          child: Center(
            child: Container(
                child: SizedBox(
                  width: 60.0,
                  height: 60.0,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation(AppColors.clearBlue),
                    strokeWidth: 4.0,
                  ),
                )),
          ),
        ));
    overlayState!.insert(overlayEntry);
    await Future.delayed(Duration(seconds: 4));
    overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.orange),
          title: Text(
            this.title!,
            style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.dirTextColor),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              presenter?.backToHome();
            },
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: (MediaQuery.of(context).size.height - 80.0) / 2,
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(target: _center, zoom: 50.0),
                      markers: _markers!,
                      polylines: _polylines!,
                      zoomControlsEnabled: false,
                      myLocationEnabled: false,
                      myLocationButtonEnabled: false,
                    ),
                  ),
                  Positioned(
                    bottom: 12.0,
                    left: MediaQuery.of(context).size.width / 3.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                            ),
                            color: Colors.white,
                          ),
                          child: IconButton(
                            iconSize: 20,
                            icon: Image.asset('assets/img/my_location.png'),
                            onPressed: () async{
                              showLoading(context);
                              presenter!.sendAnalytics(this.title!, "Ubicación Actual", "", "");
                              await _getUserLocation("myubication");
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: AppColors.gnpBackLight2,
                                width: 2.0,
                              ),
                              right: BorderSide(
                                color: AppColors.gnpBackLight2,
                                width: 2.0,
                              ),
                            ),
                            color: Colors.white,
                          ),
                          child: IconButton(
                            iconSize: 20,
                            icon: Image.asset('assets/img/directions_car.png', color: (car ? activeBoton : inactiveBoton),),
                            onPressed: () {
                              showLoading(context);
                              setState(() {
                                car = true;
                                walk = false;
                              });
                              _onAddMarkerButtonPressed();
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                            color: Colors.white,
                          ),
                          child: IconButton(
                            iconSize: 20,
                            icon: Image.asset('assets/img/directions_walk.png', color: (walk ? activeBoton : inactiveBoton),),
                            onPressed: () {
                              showLoading(context);
                              setState(() {
                                car = false;
                                walk = true;
                              });
                              _onAddMarkerButtonPressed();
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                child: Expanded(
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Visibility(
                                visible: distanceVisible ? true : false,
                                child: Row(
                                  children: <Widget>[
                                    Text(distancia != "" ? distancia : "",
                                      style: TextStyle(
                                          color: AppColors.colorVisibilty,
                                          fontSize: 16, fontWeight: FontWeight.normal),
                                    ),
                                    IconButton(
                                      iconSize: 10,
                                      icon: Image.asset('assets/img/navigation.png'),
                                      onPressed: () {
                                        presenter!.sendAnalytics(this.title!, "Navegar", "Mapa", "").then((value) =>
                                                openMapsSheet(context));
                                      },
                                    ),
                                    IconButton(
                                      iconSize: 10,
                                      icon: Image.asset('assets/img/share.png'),
                                      onPressed: () {
                                        presenter?.sendAnalytics(this.title!, "Compartir", "Mapa", "")
                                            .then((value) => presenter?.share(_lastMapPosition));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Visibility(
                                  visible: (activarEtiquetaBeneficio || activarEtiquetaPenalizacion|| activarEtiquetaContratado || activarEtiquetaNoContratado) ? true : false,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30.0),
                                        bottomLeft: Radius.circular(30.0),
                                      ),
                                      color: (activarEtiquetaBeneficio ? colorBeneficio :
                                            activarEtiquetaPenalizacion ? colorPenalizacion :
                                            activarEtiquetaContratado ? colorContratado : colorContratado),
                                    ),
                                    child: IconButton(
                                      iconSize: 20,
                                      icon: Image.asset(activarEtiquetaBeneficio ? 'assets/img/benefitLabel.png' : 'assets/img/penaltyLabel.png',
                                      ),
                                      onPressed: () {
                                        setState(() {});
                                        _onAddMarkerButtonPressed();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                        ),
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                              alignment: Alignment.bottomLeft,
                              child: Text(this.searchResult?.titulo??"",
                                  style: TextStyle(
                                      color: AppColors.primary700,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                            ),
                            Visibility(
                              visible: catalogo != "" ? true : false,
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                padding: EdgeInsets.only(top: 0.0),
                                child: Text(this.catalogo!,
                                    style: TextStyle(
                                        color: AppColors.gnpTextSystem,
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400)),
                                //isThreeLine: true,
                              ),
                            ),
                            Visibility(
                              visible: this.searchResult?.extra != ""
                                  ? true
                                  : false,
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                padding: EdgeInsets.only(top: 0.0),
                                child: Text(this.searchResult?.extra??"",
                                    style: TextStyle(
                                        color: AppColors.gnpTextSystem,
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400)),
                                //isThreeLine: true,
                              ),
                            ),
                            if (searchResult?.etiquetas?.isNotEmpty ?? false)
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 16,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: searchResult!.etiquetas!
                                      .map(
                                        (e) => Text(
                                          e,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: AppColors.gnpTextSystem,
                                            fontSize: 16,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            height: 1.5,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            Visibility(
                              visible: this.searchResult?.subEsp != "" ? true : false,
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                padding: EdgeInsets.only(top: 0.0),
                                child: Text(this.searchResult?.subEsp??"",
                                    style: TextStyle(
                                        color: AppColors.gnpTextSystem,
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400)),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 0.0),
                              alignment: Alignment.bottomLeft,
                              child: Text(this.searchResult?.texto??"",
                                  style: TextStyle(
                                      color: AppColors.gnpTextSystem,
                                      fontSize: 16,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400)),
                              //isThreeLine: true,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 0.0),
                              alignment: Alignment.bottomLeft,
                              child: GestureDetector(
                                onTap: () {
                                  String telefono = "";
                                  String newTel = "";
                                  if (this.searchResult!.extension != "N/A" && this.searchResult!.extension != "" && this.searchResult!.extension != " ") {
                                    telefono = this.searchResult!.telefono??"" +"," + (this.searchResult?.extension??"");
                                    newTel = telefono.replaceAll(" ", "");
                                    canLaunchUrl(Uri.parse("tel://$newTel"))
                                        .then((value) => launchUrl(Uri.parse("tel://$newTel")))
                                        .then((value) => presenter?.sendAnalytics(this.title!, "Contactar vía telefónica", "","Interacción"));
                                  } else {
                                    telefono = this.searchResult?.telefono??"";
                                    newTel = telefono.replaceAll(" ", "");
                                    canLaunchUrl(Uri.parse("tel://$newTel"))
                                        .then((value) => launchUrl(Uri.parse("tel://$newTel")))
                                        .then((value) => presenter?.sendAnalytics(this.title!, "Contactar vía telefónica", "","Interacción"));
                                  }
                                },
                                child: Row(
                                  children: <Widget>[
                                    Text(this.searchResult?.telefono??"",
                                        style: TextStyle(
                                            //decoration: TextDecoration.underline,
                                            color: AppColors.secondary900,
                                            fontSize: 16,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400)),
                                    Visibility(
                                      visible: this.searchResult!.extension != "N/A" && this.searchResult!.extension != "" && this.searchResult!.extension != " " ? true : false,
                                      child: Text(" Ext. " + (this.searchResult?.extension??""),
                                          style: TextStyle(
                                              color: AppColors.gnpTextSystem,
                                              fontSize: 16,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400)),
                                    ),
                                  ],
                                ),
                              ),
                              //isThreeLine: true,
                            ),
                            Visibility(
                              visible: ((searchResult!.complemnto?.isNotEmpty ?? false) && (searchResult!.etiquetas?.isEmpty ?? true)),
                              child: Container(
                                padding: EdgeInsets.only(top: 0.0),
                                alignment: Alignment.bottomLeft,
                                child: Text(this.searchResult?.complemnto??"",
                                    style: TextStyle(
                                        color: AppColors.gnpTextSystem,
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400)),
                                //isThreeLine: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void setMapPins() {
    setState(() {
      _markers!.add(Marker(
        markerId: MarkerId('dest'),
        position: _center,
        icon: sourceIcon!,
      ));
      // destination pin
      _markers!.add(Marker(
        markerId: MarkerId('destPin'),
        position: _lastMapPosition,
        icon: sourceIcon!,
      ));
    });
  }

  setPolylines() async {
    var config = AppConfig.of(context);
    _mapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _lastMapPosition, zoom: 15.0)));
    if (car == true) {
      result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: config?.apiKeyGM?? "",
        request: PolylineRequest(
          origin: PointLatLng(_center.latitude, _center.longitude),
          destination: PointLatLng(_lastMapPosition.latitude, _lastMapPosition.longitude), 
          mode: TravelMode.driving
        )
      );
    } else {
      result = await polylinePoints.getRouteBetweenCoordinates(
        request: PolylineRequest(
          origin:  PointLatLng(_center.latitude, _center.longitude),
          destination:  PointLatLng(_lastMapPosition.latitude, _lastMapPosition.longitude),
          mode: TravelMode.walking
        )
      );
    }

    polylineCoordinates.clear();
    if (result!.points.isNotEmpty) {
      result!.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    setState(() {
      // create a Polyline instance
      polyline = Polyline(
          polylineId: PolylineId("poly"),
          color: AppColors.secondary900,
          points: polylineCoordinates);
      _polylines!.add(polyline!);
      _mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: _lastMapPosition, zoom: 15.0)));
    });

   /* _mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _lastMapPosition, zoom: 10.0)));*/
  }

  void _onAddMarkerButtonPressed() {
    _mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _lastMapPosition, zoom: 50.0)));
    if (car == true) {
      goToPoint(_center, _lastMapPosition, "driving");
      presenter?.sendAnalytics(this.title!, "Conducir", "Mapa", "");
    } else {
      goToPoint(_center, _lastMapPosition, "walking");
      presenter?.sendAnalytics(this.title!, "Caminar", "Mapa", "");
    }
    setMapPins();
    setPolylines();
  }

  openMapsSheet(context) async {
    try {
      final title = searchResult!.titulo;
      final description = searchResult!.texto;
      final coords = Coords(_lastMapPosition.latitude, _lastMapPosition.longitude);
      final availableMaps = await MapLauncher.installedMaps;

      print(availableMaps);

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: new List.generate(
                    availableMaps.length,
                    (index) => new ListTile(
                      title: Text(availableMaps[index].mapName),
                      onTap: () => availableMaps[index].showMarker(
                        coords: coords,
                        title: title??"",
                        description: description,
                      ),
                      leading: Image(
                        image: availableMaps[index].icon as ImageProvider,
                        height: 30.0,
                        width: 30.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<bool> _requestPermission(Permission permission) async{
    var status = await permission.request();
    if(status == PermissionStatus.granted){
      Utils.permissions = true;
      return true;
    }else{
      status = await Permission.locationWhenInUse.request();
      if(status == PermissionStatus.granted){
        Utils.permissions = true;
        return true;
      }
      return false;
    }
  }

  Future<bool> requestLocationPermission() async{
    return _requestPermission(Permission.locationAlways);
  }

  //API obtiene distancia
  goToPoint(LatLng current, LatLng last, String mode) async {
    if (!await ConnectionManager.isConnected()) {
      customAlert(AlertDialogType.errorConexion, context, "", "");
    }
    try{
      var config = AppConfig.of(context);
      String currentloc = current.latitude.toString() +"," + current.longitude.toString();
      String lastloc = last.latitude.toString() +"," + last.longitude.toString();
      var parametros;
      if(Platform.isAndroid){
        setState(() {
          parametros = Constants.apiDistance + "origin=$currentloc&destination=$lastloc&mode=$mode&key=" + (config?.apiKeyGM??"");
        });
      }else if(Platform.isIOS){
        setState(() {
          parametros = Constants.apiDistance + "origin=$currentloc&destination=$lastloc&mode=$mode&key=" + "AIzaSyD2bbZFGV3US6N_qtlrkxHUc1Sj_tAozPg";
        });
      }


      var request = MyRequest(
        baseUrl: config?.baseGoogleApis??"",
        path: parametros,
        method: Method.GET,
        body: null,
        headers: null,
      );

      MyResponse response = await RequestHandler.httpRequest(request);

      if (response.success) {

        var routes = response.response;
        if(routes['status'] == "OK"){
          var element = routes['routes'][0]['legs'][0];
          String  distance = element["distance"]["text"];
          String  time = element["duration"]["text"];

          time = time.replaceAll("hour", "hora").replaceAll("hours", "horas").replaceAll("days", "dias").replaceAll("day", "día");
          setState(() {
            distancia = time + " (" + distance + ")";
            distanceVisible = true;
          });
          Utils.LogPrint("LOCATION: "+ currentloc);
        }else{
          throw Exception("No se encontraron resultados");
        }
      }else{
        print("sin conexión a internet");
      }
    }catch(e){
      throw Exception("Coordenadas null");
    }
  }
}
