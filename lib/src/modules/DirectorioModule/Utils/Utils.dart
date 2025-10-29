import 'package:agentesgnp/SolicitudMovimientos/Models/BusquedaNombre/Personas.dart';
import 'package:agentesgnp/SolicitudMovimientos/Models/BusquedaNombre/Polizas.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Catalogos.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Hospitales.dart';
import 'package:flutter/material.dart';

class Utils {

  //Imprime Logs
  static void LogPrint(Object object) async {
    int defaultPrintLength = 1020;
    if (object == null || object.toString().length <= defaultPrintLength) {
      print(object);
    } else {
      String log = object.toString();
      int start = 0;
      int endIndex = defaultPrintLength;
      int logLength = log.length;
      int tmpLogLength = log.length;
      while (endIndex < logLength) {
        print(log.substring(start, endIndex));
        endIndex += defaultPrintLength;
        start += defaultPrintLength;
        tmpLogLength -= defaultPrintLength;
      }
      if (tmpLogLength > 0) {
        print(log.substring(start, logLength));
      }
    }
  }
  static String distance = "";
  static String walking = "";
  static String driving = "";
  static bool lbBuscador = false;
  static List<TipoClinica> listTClinicas = [];
  static List<Planes> listPlanes = [];
  static List<NivelHospitalario> listNiveles = [];
  static List<NivelHospitalario> listNivelesFiltros = [];
  static List<Estados> listEstados = [];
  static List<Municipios> listMunicipios = [];
  static List<Municipios> listMunicipiosFiltros = [];
  static List<Especialidad> listEspecialidades = [];
  static List<SubEspecialidad> listSubEspecialidades = [];
  static List<CirculoMedico> listCirculos = [];
  static List<CirculoMedico> listCirculosFiltros = [];
  static List<TipoServicios> listTServicios = [];
  static int cvEstado = -1;
  static List<Hospitales> listHospitales = [];
  static List<PolizasUsuario> listPolizaUsuarios = [];
  static List<Personas> listPersonasPoliza = [];
  static List<Poliza> listPolizasSearch = [];
  static bool permissions = false;
  static String circuloPoliza = "";
  static String planPoliza = "";
  static String cvNivelHosp = "";
  static String vistaDirectorio = "";
  static int focusDropdown = 0;
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  //Map swatch = <int, Color>{};
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);

}