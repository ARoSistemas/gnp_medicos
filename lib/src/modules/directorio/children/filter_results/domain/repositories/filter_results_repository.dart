import 'package:get/get_connect/http/src/response/response.dart';
import 'package:medicos/core/services/network/network_service.dart';
import 'package:medicos/src/modules/directorio/children/filter_results/domain/entities/dtos/clinicas_dto.dart';
import 'package:medicos/src/modules/directorio/children/filter_results/domain/entities/dtos/hospitales_dto.dart';
import 'package:medicos/src/modules/directorio/children/filter_results/domain/entities/dtos/medico_dto.dart';
import 'package:medicos/src/modules/directorio/children/filter_results/domain/entities/dtos/otros_servicios_dto.dart';

class FilterResultsRepository extends ApiBaseProvider {
  @override
  final String url = 'https://soycliente.gnp.com.mx';

  @override
  final String contextPath = '';

  /// Fetch data for medicos filtered items
  // uri:: /integracion/catalogo/medicos ?origen=corporativo&pagina=1
  // Response example:
  // {
  //    "registrosTotales":11412,
  //    "pagActual":1,
  //    "pagTotales":115,
  //    "gruposMedicos":[
  //       {
  //          "etiquetaGrupoBusqueda":"CÍRCULO / TABULADOR MÉDICO SELECCIONADO",
  //          "medicos":[
  //             {
  //                "categorizador":5,
  //                "claveConvenio":"81968202",
  //                "codigoFiliacion":"0002733207",
  //                "rfc":"EIJA690203VE9",
  //                "apellidoPaterno":"ESPINOSA",
  //                "apellidoMaterno":"JARAMILLO",
  //                "nombre":"ADRIANA",
  //                "nombreConcatenado":"ADRIANA ESPINOSA JARAMILLO",
  //                "claveCirculoMedico":"0002",
  //                "circuloMedico":"NOVUS",
  //                "claveEspecialidad":"10",
  //                "especialidad":"CIRUGIA GENERAL",
  //                "claveSubespecialidad":"",
  //                "subespecialidad":"",
  //                "descripcionsubespecialidad":"",
  //                "descripcionMedico":"CIRUGIA GENERAL / NOVUS / TABULADOR MEDICO: A - C",
  //                "sitioWeb":null,
  //                "centroDeAtencion":null,
  //                "correo":null,
  //                "latitud":"19.4376855",
  //                "maps":"19.4376855, -99.1935827",
  //                "longitud":"-99.1935827",
  //                "estado":"CIUDAD DE MEXICO",
  //                "cp":"11560",
  //                "claveEstado":"09",
  //                "claveMunicipio":"09011",
  //                "municipio":"MIGUEL HIDALGO",
  //                "colonia":"POLANCO",
  //                "calleNumero":"EUGENIO SUE 355",
  //                "extensionTelefono":"",
  //                "ladaTelefono":"55",
  //                "telefono":"52034920",
  //                "direccionCompleta":"EUGENIO SUE 355,
  //POLANCO, 11560, MIGUEL HIDALGO, CIUDAD DE MEXICO",
  //                "telefonoCompleto":"55 52034920",
  //                "claveTabuladorNG":"0023",
  //                "tabuladorNG":"A - C",
  //                "ngOrd":23
  //             },
  //             {
  //                "categorizador":5,
  //                "claveConvenio":"81310402",
  //                "codigoFiliacion":"0004146354",
  //                "rfc":"MAAA730515UE1",
  //                "apellidoPaterno":"MAFFUZ",
  //                "apellidoMaterno":"AZIZ",
  //                "nombre":"ANTONIO",
  //                "nombreConcatenado":"ANTONIO MAFFUZ AZIZ",
  //                "claveCirculoMedico":"0002",
  //                "circuloMedico":"NOVUS",
  //                "claveEspecialidad":"13",
  //                "especialidad":"CIRUGIA ONCOLOGICA",
  //                "claveSubespecialidad":"",
  //                "subespecialidad":"",
  //                "descripcionsubespecialidad":"",
  //                "descripcionMedico":
  //"CIRUGIA ONCOLOGICA / NOVUS / TABULADOR MEDICO: A",
  //                "sitioWeb":null,
  //                "centroDeAtencion":null,
  //                "correo":null,
  //                "latitud":"19.400991",
  //                "maps":"19.400991, -99.204086",
  //                "longitud":"-99.204086",
  //                "estado":"CIUDAD DE MEXICO",
  //                "cp":"01120",
  //                "claveEstado":"09",
  //                "claveMunicipio":"09001",
  //                "municipio":"ALVARO OBREGON",
  //                "colonia":"LAS AMERICAS",
  //                "calleNumero":"SUR 136 116 INT. CONS-9",
  //                "extensionTelefono":"",
  //                "ladaTelefono":"55",
  //                "telefono":"52770422",
  //                "direccionCompleta":
  //"SUR 136 116 INT. CONS-9, LAS AMERICAS, 01120,
  //ALVARO OBREGON, CIUDAD DE MEXICO",
  //                "telefonoCompleto":"55 52770422",
  //                "claveTabuladorNG":"0021",
  //                "tabuladorNG":"A",
  //                "ngOrd":21
  //             }
  //          ]
  //       }
  //    ]
  // }
  Future<Response<MedicosDto>> fetchItemMedicosFiltered(String filters) => get(
    '/integracion/catalogo/medicos$filters',
    headers: {'Content-Type': 'application/json'},
    decoder: (data) {
      if (data != null) {
        return MedicosDto.fromMap(data);
      }
      return MedicosDto.empty();
    },
  );

  /// Fetch data for Hospitales filtered items
  // uri:: /integracion/catalogo/hospitales ?origen=corporativo&pagina=1
  // Response example:
  //   {
  //    "registrosTotales":459,
  //    "pagActual":1,
  //    "pagTotales":5,
  //    "alertaConsulta":"",
  //    "gruposHospitalarios":[
  //       {
  //          "banNivelContratado":true,
  //          "etiquetaGrupoBusqueda":"NIVEL HOSPITALARIO SELECCIONADO",
  //          "hospitales":[
  //             {
  //                "idHospital":"81133001",
  //                "razonSocial":"THE AMERICAN BRITISH COWDRAY MEDICAL CENTER",
  //                "nombreComercial":"HOSPITAL ABC SANTA FE",
  //                "rfc":"ABC4107047I0",
  //                "codigoFiliacion":"0000798693",
  //                "categorizador":457,
  //                "nivelHosptilarioNuevoEsquema":"Premium",
  //                "nivelHosptilarioViejoEsquema":"Nivel 100",
  //                "nivelHosptilarioNuevaGama":"Nivel A",
  //                "nivelHospitalarioAbreviado":
  //  "Nivel 100 - Premium - Nivel A",
  //                "nivelHospitalarioCompleto":
  //"Nivel hospitalario 100 - Premium - Nivel A",
  //                "latitud":"19.357920",
  //                "longitud":"-99.282554",
  //                "maps":"19.357920, -99.282554",
  //                "cp":"05348",
  //                "estado":"CIUDAD DE MEXICO",
  //                "claveEstado":"09",
  //                "municipio":"CUAJIMALPA DE MORELOS",
  //                "claveMunicipio":"09005",
  //                "colonia":"SANTA FE CUAJIMALPA",
  //                "calleNumero":"CARLOS GRAEF FERNANDEZ 154",
  //                "direccionCompleta":
  //"CARLOS GRAEF FERNANDEZ 154, SANTA FE CUAJIMALPA, 05348,
  //CUAJIMALPA DE MORELOS, CIUDAD DE MEXICO",
  //                "sitioWeb":"NR",
  //                "ladaTelefono":"55",
  //                "extensionTelefono":"",
  //                "telefono":"11031600",
  //                "telefonoCompleto":"55 11031600",
  //                "centroDeAtencion":true,
  //                "banTipoMensaje":"NO_CONTRATADO",
  //                "mensaje":"",
  //                "accesoHospitalario":""
  //             },
  //             {
  //                "idHospital":"8451301",
  //                "razonSocial":
  //"THE AMERICAN BRITISH COWDRAY MEDICAL CENTER IAP",
  //                "nombreComercial":"HOSPITAL ABC OBSERVATORIO",
  //                "rfc":"ABC4107047I0",
  //                "codigoFiliacion":"0000798694",
  //                "categorizador":456,
  //                "nivelHosptilarioNuevoEsquema":"Premium",
  //                "nivelHosptilarioViejoEsquema":"Nivel 100",
  //                "nivelHosptilarioNuevaGama":"Nivel A",
  //                "nivelHospitalarioAbreviado":
  //"Nivel 100 - Premium - Nivel A",
  //                "nivelHospitalarioCompleto":
  //"Nivel hospitalario 100 - Premium - Nivel A",
  //                "latitud":"19.400888",
  //                "longitud":"-99.203699",
  //                "maps":"19.400888, -99.203699",
  //                "cp":"01120",
  //                "estado":"DISTRITO FEDERAL",
  //                "claveEstado":"09",
  //                "municipio":"ALVARO OBREGON",
  //                "claveMunicipio":"09001",
  //                "colonia":"LAS AMERICAS",
  //                "calleNumero":"SUR 136 INT. 116",
  //                "direccionCompleta":
  //"SUR 136 INT. 116, LAS AMERICAS, 01120, ALVARO OBREGON, DISTRITO FEDERAL",
  //                "sitioWeb":"NR",
  //                "ladaTelefono":"55",
  //                "extensionTelefono":"",
  //                "telefono":"52308000",
  //                "telefonoCompleto":"55 52308000",
  //                "centroDeAtencion":true,
  //                "banTipoMensaje":"NO_CONTRATADO",
  //                "mensaje":"",
  //                "accesoHospitalario":""
  //             }
  //             ]
  //       }
  //    ]
  // }
  Future<Response<HospitalesDto>> fetchItemHospitalesFiltered(String filters) =>
      get(
        '/integracion/catalogo/hospitales$filters',
        headers: {'Content-Type': 'application/json'},
        decoder: (data) {
          if (data != null) {
            return HospitalesDto.fromMap(data);
          }
          return HospitalesDto.empty();
        },
      );

  /// Fetch data for Clinicas filtered items
  // uri:: /integracion/catalogo/clinicas ?pagina=1&banClinicaCE=CE
  // Response example:
  // {
  //    "registrosTotales":169,
  //    "pagActual":null,
  //    "pagTotales":null,
  //    "gruposClinicas":[
  //       {
  //          "etiquetaGrupoBusqueda":"CLÍNICAS SELECCIONADAS",
  //          "clinicas":[
  //             {
  //                "categorizador":45.88,
  //                "claveGestion":"0108551067",
  //                "claveTipoClinica":6,
  //                "tipoClinica":"CLINICA ONCOLOGICA",
  //                "nombreComercial":"ALIVIA - SAN PEDRO GARZA GARCIA",
  //                "sitioWeb":"NR",
  //                "telefono":"19658808",
  //                "maps":"25.658244, -100.363469",
  //                "longitud":"-100.363469",
  //                "telefonoCompleto":"8119658808",
  //                "cp":"66220",
  //                "extensionTelefono":"",
  //                "claveEstado":"NUEVO LEON",
  //                "estado":"NUEVO LEON",
  //                "calleNumero":"RIO MISSISSIPI 265",
  //                "claveMunicipio":"SAN PEDRO GARZA GARCIA",
  //                "direccionCompleta":
  //"CALLE RIO MISSISSIPI 265 COLONIA DEL VALLE OTE 66220
  //SAN PEDRO GARZA GARCIA NUEVO LEON",
  //                "municipio":"SAN PEDRO GARZA GARCIA",
  //                "colonia":"SAN PEDRO GARZA GARCIA",
  //                "ladaTelefono":"81",
  //                "latitud":"25.658244",
  //                "bndirectorio":"S",
  //                "nivelHospitalarioAbreviado":
  //"Flexible Ambar - Nivel 300 - C",
  //                "nivelHospitalarioCompleto":
  //"Flexible Ambar - Nivel 300 - C",
  //                "nivelHosptilarioNuevoEsquema":"Flexible Ambar",
  //                "nivelHosptilarioViejoEsquema":"Nivel 300",
  //                "nivelHosptilarioNuevaGama":"C",
  //                "banFueraRed":false
  //             },
  //             {
  //                "categorizador":45.88,
  //                "claveGestion":"0108555141",
  //                "claveTipoClinica":6,
  //                "tipoClinica":"CLINICA ONCOLOGICA",
  //                "nombreComercial":"ALIVIA - CD JUAREZ",
  //                "sitioWeb":"NR",
  //                "telefono":"4294838",
  //                "maps":"31.729090, -106.409755",
  //                "longitud":"-106.409755",
  //                "telefonoCompleto":"6564294838",
  //                "cp":"32500",
  //                "extensionTelefono":"",
  //                "claveEstado":"CHIHUAHUA",
  //                "estado":"CHIHUAHUA",
  //                "calleNumero":"BOULEVARD TOMAS FERNANDEZ 7930",
  //                "claveMunicipio":"JUAREZ",
  //                "direccionCompleta":
  //"CALLE BOULEVARD TOMAS FERNANDEZ 7930
  //CAMPAMENTO CAMPESTRE PRIMAVERA  32500 JUAREZ CHIHUAHUA",
  //                "municipio":"JUAREZ",
  //                "colonia":"JUAREZ",
  //                "ladaTelefono":"656",
  //                "latitud":"31.729090",
  //                "bndirectorio":"S",
  //                "nivelHospitalarioAbreviado":
  //"Flexible Cuarzo - Nivel 400 - D",
  //                "nivelHospitalarioCompleto":
  //"Flexible Cuarzo - Nivel 400 - D",
  //                "nivelHosptilarioNuevoEsquema":"Flexible Cuarzo",
  //                "nivelHosptilarioViejoEsquema":"Nivel 400",
  //                "nivelHosptilarioNuevaGama":"D",
  //                "banFueraRed":false
  //             }
  //          ]
  //       }
  //    ]
  // }
  Future<Response<ClinicasDto>> fetchItemClinicasFiltered(String filters) =>
      get(
        '/integracion/catalogo/clinicas$filters',
        headers: {'Content-Type': 'application/json'},
        decoder: (data) {
          if (data != null) {
            return ClinicasDto.fromMap(data);
          }
          return ClinicasDto.empty();
        },
      );

  /// Fetch data for otros servicios filtered items
  /// https://soycliente.gnp.com.mx/integracion/catalogo/sauxs?pagina=1
  // uri:: /integracion/catalogo/sauxs ?pagina=1&banClinicaCE=CE
  // Response example:
  // {
  // "registrosTotales": 75,
  // "pagActual": 1,
  // "pagTotales": 1,
  // "gruposSauxs": [
  //   {
  //     "etiquetaGrupoBusqueda": "OTROS SERVICIOS DE SALUD SELECCIONADOS",
  //     "sauxs": [
  //       {
  //          "etiquetaGrupoBusqueda":"CLÍNICAS SELECCIONADAS",
  //          "sauxs":[
  //            {
  //              "claveGestion": "25224",
  //              "claveTipoServicio": 52,
  //              "tipoServicio": "ESTUDIOS DE GABINETE Y LABORATORIO",
  //              "categorizador": 0,
  //              "nombreComercial": "ASESORES DE DIAGNOSTICO CLINICO PUEBLA",
  //              "maps": "19.060849, -98.1962455",
  //              "latitud": "19.060849",
  //              "longitud": "-98.1962455",
  //              "cp": "72080",
  //              "claveEstado": "21",
  //              "estado": "PUEBLA",
  //              "claveMunicipio": "21114",
  //              "municipio": "PUEBLA",
  //              "colonia": "SANTA MARIA PUEBLA",
  //              "direccionCompleta":
  //"34 PONIENTE 708, SANTA MARIA PUEBLA, 72080, PUEBLA, PUEBLA",
  //              "calleNumero": "34 PONIENTE 708",
  //              "extensionTelefono": "",
  //              "ladaTelefono": "222",
  //              "telefonoCompleto": "222 4540933",
  //              "telefono": "4540933"
  //          },
  //          {
  //              "claveGestion": "18500",
  //              "claveTipoServicio": 7,
  //              "tipoServicio": "CLINICA DE REHABILITACION",
  //              "categorizador": 0,
  //              "nombreComercial": "ATHLOS TFD REHABILITACION FISICA",
  //              "maps": "19.4937982, -99.139011",
  //              "latitud": "19.4937982",
  //              "longitud": "-99.139011",
  //              "cp": "07300",
  //              "claveEstado": "09",
  //              "estado": "DISTRITO FEDERAL",
  //              "claveMunicipio": "09007",
  //              "municipio": "GUSTAVO A MADERO",
  //              "colonia": "LINDAVISTA",
  //              "direccionCompleta":
  //"SULLANA 741, LINDAVISTA, 07300, GUSTAVO A MADERO, DISTRITO FEDERAL",
  //              "calleNumero": "SULLANA 741",
  //              "extensionTelefono": "",
  //              "ladaTelefono": "",
  //              "telefonoCompleto": " ",
  //              "telefono": ""
  //          }
  //          ]
  //       }
  //    ]
  // }
  Future<Response<OtrosServiciosDto>> fetchItemOtrosServiciosFiltered(
    String filters,
  ) => get(
    '/integracion/catalogo/sauxs?$filters',
    headers: {'Content-Type': 'application/json'},
    decoder: (data) {
      if (data != null) {
        return OtrosServiciosDto.fromMap(data);
      }
      return OtrosServiciosDto.empty();
    },
  );
}
