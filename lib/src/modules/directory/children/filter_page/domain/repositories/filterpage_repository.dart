import 'package:get/get_connect/http/src/response/response.dart';
import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/core/services/network/network_service.dart';
import 'package:medicos/src/modules/directory/children/filter_page/domain/entities/models/circulo_medico_mdl.dart';
import 'package:medicos/src/modules/directory/children/filter_page/domain/entities/models/clinica_mdl.dart';
import 'package:medicos/src/modules/directory/children/filter_page/domain/entities/models/especialidad_mdl.dart';
import 'package:medicos/src/modules/directory/children/filter_page/domain/entities/models/estado_mdl.dart';
import 'package:medicos/src/modules/directory/children/filter_page/domain/entities/models/municipio_mdl.dart';
import 'package:medicos/src/modules/directory/children/filter_page/domain/entities/models/otro_servicio_mdl.dart';
import 'package:medicos/src/modules/directory/children/filter_page/domain/entities/models/plan_hospitalario_mdl.dart';

class FilterPageRepository extends ApiBaseProvider {
  @override
  final String url = AppConfig.urlDirectorio;

  @override
  final String contextPath = '/integracion/catalogo';

  final Map<String, String> _header = {};

  /// Fetch data for Circulo Medico
  /// url:: https://api-uat.oscpuat.gnp.com.mx/redesMedicas/catalogo/circuloMedico
  //  Respuesta de apiResponseCirculoMedico ::
  // [
  //   {
  //      "claveCirculoMedico":"0024",
  //      "circuloMedico":"D"
  //   },
  //   {
  //      "claveCirculoMedico":"0023",
  //      "circuloMedico":"C"
  //   },
  // ]''';
  Future<Response<List<CirculoMedicoMdl>>> fetchCirculoMedico() => get(
    '/circuloMedico',
    headers: _header,
    decoder: (data) {
      if (data is List) {
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data);
        return dataList.map(CirculoMedicoMdl.fromMap).toList();
      }

      return [];
    },
  );

  /// Fetch data for Especialidades Medicas
  // Respuesta de apiResponseEspecialidades ::
  // [
  //   {
  //      "claveEspecialidad":"1",
  //      "especialidad":"ANATOMOPATOLOGIA"
  //  },
  //  {
  //      "claveEspecialidad":"2",
  //      "especialidad":"ANESTESIOLOGIA Y C. DEL DOLOR"
  //   }
  // ]
  Future<Response<List<EspecialidadMdl>>> fetchEspecialidades() => get(
    '/especialidad',
    headers: _header,
    decoder: (data) {
      if (data is List) {
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data);
        return dataList.map(EspecialidadMdl.fromMap).toList();
      }
      return [];
    },
  );

  /// Fetch data for Estados
  // url:: https://api-uat.oscpuat.gnp.com.mx/redesMedicas/catalogo/estados
  // Respuesta de apiResponseEstados ::
  // [
  //    {
  //       "claveEstado":"01",
  //       "estado":"AGUASCALIENTES"
  //    },
  //    {
  //       "claveEstado":"02",
  //       "estado":"BAJA CALIFORNIA"
  //    }
  // ]
  Future<Response<List<EstadoMdl>>> fetchEstados() => get(
    '/estados',
    headers: _header,
    decoder: (data) {
      if (data is List) {
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data);
        return dataList.map(EstadoMdl.fromMap).toList();
      }

      return [];
    },
  );

  /// Fetch data for Municipios
  // url:: https://api-uat.oscpuat.gnp.com.mx/redesMedicas/catalogo/municipios/estado/{codigo_estado}
  // Respuesta de apiResponseMunicipios ::
  //      [
  //    {
  //       "claveEstado":"02",
  //       "claveMunicipio":"02001",
  //       "municipio":"ENSENADA"
  //    },
  //    {
  //       "claveEstado":"02",
  //       "claveMunicipio":"02002",
  //       "municipio":"MEXICALI"
  //    }
  // ]
  //     ''';
  Future<Response<List<MunicipioMdl>>> fetchMunicipios(
    String cveMunicipio,
  ) => get(
    '/municipios/estado/$cveMunicipio',
    headers: _header,
    decoder: (data) {
      if (data is List) {
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data);
        return dataList.map(MunicipioMdl.fromMap).toList();
      }

      return [];
    },
  );

  /// Fetch data Plan hospitalario
  // Respuesta de apiResponsePlanes ::
  // [
  //   {
  //      "clavePlan":"RVER",
  //      "plan":"Versátil",
  //      "idplan":"12"
  //   },
  //   {
  //      "clavePlan":"RPRM",
  //      "plan":"Premium",
  //      "idplan":"20"
  //   },
  // ]
  Future<Response<List<PlanHospitalarioMdl>>> fetchPlanHospitalario() => get(
    '/planes',
    headers: _header,
    decoder: (data) {
      if (data is List) {
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data);
        return dataList.map(PlanHospitalarioMdl.fromMap).toList();
      }
      return [];
    },
  );

  /// Fetch data Plan hospitalario
  // Respuesta de apiResponseClinicas ::
  //  [
  //    {
  //       "claveTipoClinica":"CE",
  //       "tipoClinica":"CLINICA DE CORTA ESTANCIA"
  //    },
  //    {
  //       "claveTipoClinica":"CF",
  //       "tipoClinica":"CLINICA OFTAMOLOGICA"
  //    }
  // ]

  // Respuesta de apiResponseClinicas ::
  // [
  //    {
  //       "claveTipoClinica":"CE",
  //       "tipoClinica":"CLINICA DE CORTA ESTANCIA"
  //    },
  //    {
  //       "claveTipoClinica":"CF",
  //       "tipoClinica":"CLINICA OFTAMOLOGICA"
  //    }
  // ]
  Future<Response<List<ClinicaMdl>>> fetchClinicas() => get(
    '/tiposClinica',
    headers: _header,
    decoder: (data) {
      if (data is List) {
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data);
        return dataList.map(ClinicaMdl.fromMap).toList();
      }

      return [];
    },
  );

  /// Fetch data Otros servicios
  // Respuesta del API de catalogo/tiposServicio ::
  // [
  //    {
  //       "claveTipoProveedor":3,
  //       "tipoProveedor":"Laboratorios"
  //    },
  //    {
  //       "claveTipoProveedor":4,
  //       "tipoProveedor":"Gabinetes"
  //    },
  //    {
  //       "claveTipoProveedor":5,
  //       "tipoProveedor":"Farmacias"
  //    }
  // ]
  Future<Response<List<OtroServicioMdl>>> fetchOtrosServicios() => get(
    '/tiposServicio',
    headers: _header,
    decoder: (data) {
      if (data is List) {
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data);
        return dataList.map(OtroServicioMdl.fromMap).toList();
      }
      return [];
    },
  );
}
