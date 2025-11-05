import 'package:get/get.dart';
import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/core/services/network/network_service.dart';
import 'package:medicos/core/utils/logger.dart';
import 'package:medicos/shared/models/incoming/tipos_assistant_model.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/domain/dtos/assistant_dto.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/domain/dtos/permissions_dto.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/domain/dtos/register_assistant_dto.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/domain/entities/assistant_update_model.dart';

class AddUserRepository extends ApiBaseProvider {
  @override
  final String url = AppConfig.baseUrlMedicos;

  @override
  final String contextPath = '/admonproveedores/asistentes';

  /// Fetch for assistants list.
  ///
  /// Response:
  /// Body:
  /// [
  ///   {
  ///     "idTipoAsistente":"aba",
  ///     "nombre":"Asistente Básico"
  ///   },
  ///   {
  ///     "idTipoAsistente":"asi",
  ///     "nombre":"Asistente General"
  ///   },
  ///   {
  ///     "idTipoAsistente":"sec",
  ///     "nombre":"Secretari@"
  ///   }
  /// ]
  Future<Response<List<TiposAsistentesModel>>> getTypeAssistants(
    String jwt,
  ) => get(
    '/tipos',
    headers: finalHeaders(jwt),
    decoder: (data) {
      if (data is List) {
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data);
        return dataList.map(TiposAsistentesModel.fromMap).toList();
        // return data.map((e) => TiposAsistentesModel.fromMap(e)).toList();
      }
      return [];
    },
  );

  /// Fetch registerAssistants :
  ///
  /// Responsse:
  ///
  /// Body:
  /// {
  ///   "": 52
  ///   "codigoFiliacionMedico":"0000799393",
  ///   "idTipoAsistente":"asi",
  ///   "asistente":
  ///     {
  ///       "idAsistente":"",
  ///       "nombre":"Demo andres 8",
  ///       "apellidoPaterno":"demo 8",
  ///       "apellidoMaterno":"demo 8",
  ///       "fechaNacimiento":"2007-10-23",
  ///       "cveLada":"",
  ///       "telefono":"8123456789",
  ///       "email":"demo8@demo.com",
  ///       "activo":true
  ///     }
  /// }
  Future<Response<String>> registerAssistants(
    RegisterAssistantModel registerModel,
    String jwt,
  ) => post(
    headers: finalHeaders(jwt),
    '/relacion-medico',
    registerModel.toJson(),
    decoder: (data) {
      if (data is Map) {
        final Map<String, dynamic> assistant = data['asistente'] ?? {};
        return assistant['idAsistente'] ?? '';
      }
      return '';
    },
  );

  /// Fetch update assistant.
  ///
  /// Response:
  /// {
  ///   "idAsistente":"MDUDEDD001",
  ///   "nombre":"demo",
  ///   "apellidoPaterno":"demo mod",
  ///   "apellidoMaterno":"demo mod",
  ///   "fechaNacimiento":"2007-10-16",
  ///   "cveLada":"212",
  ///   "telefono":
  ///   "2123456780",
  ///   "email":"demo1@demo.com",
  ///   "activo":true
  /// }
  Future<Response<AssistantDto>> updateAssistant({
    required String idAssistant,
    required AssistantUpdateModel updateAssistantModel,
    required String jwt,
  }) => put(
    '/$idAssistant',
    headers: finalHeaders(jwt),
    updateAssistantModel.toJson(),
    decoder: (data) {
      if (data is AssistantDto) {
        return data;
      }
      return AssistantDto.empty();
    },
  );

  /// Fetch getPermissions
  ///
  /// Response:
  /// [
  ///   {
  ///     "id":"/mis-tramites",
  ///     "descripcion":"Mis trámites",
  ///     "activo":false
  ///   },
  ///   {
  ///     "id":"/beneficios",
  ///     "descripcion":"Beneficios",
  ///     "activo":false
  ///   },
  ///   {
  ///     "id":"/solicitar-convenio",
  ///     "descripcion":"Solicitar convenio",
  ///     "activo":false
  ///   },
  ///   {
  ///     "id":"/convenio-medico",
  ///     "descripcion":"Convenio Médico",
  ///     "activo":false
  ///   },
  ///   {
  ///     "id":"/directorio-medico",
  ///     "descripcion":"Directorio médico",
  ///     "activo":false
  ///   },
  ///   {
  ///     "id":"/formatos",
  ///     "descripcion":"Formatos",
  ///     "activo":false
  ///   },
  ///   {
  ///     "id":"/mi-perfil",
  ///     "descripcion":"Mi Perfil",
  ///     "activo":false,
  ///     "submodulos":
  ///       [
  ///         {
  ///           "id":"/datos-fiscales",
  ///           "descripcion":"Datos fiscales",
  ///           "activo":false
  ///         },
  ///         {
  ///           "id":"/datos-academicos",
  ///           "descripcion":"Datos académicos",
  ///           "activo":false
  ///         },
  ///         {
  ///           "id":"/datos-personales",
  ///           "descripcion":"Datos personales",
  ///           "activo":false
  ///         }
  ///       ]
  ///     },
  ///     {
  ///       "id":"/anexos",
  ///       "descripcion":"Anexos",
  ///       "activo":false
  ///     },
  ///     {
  ///       "id":"/tabuladores",
  ///       "descripcion":"Tabuladores",
  ///       "activo":false
  ///     },
  ///     {
  ///       "id":"/mis-pagos",
  ///       "descripcion":"Mis pagos",
  ///       "activo":false
  ///     }
  ///   ]
  Future<Response<List<PermissionsDto>>> getPermissions(
    String idAssistant,
    String affiliationCode,
    String jwt,
  ) => get(
    headers: finalHeaders(jwt),
    '/$idAssistant/medicos/$affiliationCode/permisos',
    decoder: (data) {
      if (data is List) {
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data);
        return dataList.map(PermissionsDto.fromMap).toList();
      }
      return [];
    },
  );

  /// Fetch updateAssistantsPermissions
  ///
  /// Response
  /// [
  ///   {
  ///     "id":"/mis-tramites",
  ///     "descripcion":"Mis trámites",
  ///     "activo":true
  ///   },
  ///   {
  ///     "id":"/beneficios",
  ///     "descripcion":"Beneficios",
  ///     "activo":false
  ///   },
  ///   {
  ///     "id":"/solicitar-convenio",
  ///     "descripcion":"Solicitar convenio",
  ///     "activo":false
  ///   },
  ///   {
  ///     "id":"/convenio-medico",
  ///     "descripcion":"Convenio Médico",
  ///     "activo":false
  ///   },
  ///   {
  ///     "id":"/directorio-medico",
  ///     "descripcion":"Directorio médico",
  ///     "activo":false
  ///   },
  ///   {
  ///     "id":"/formatos",
  ///     "descripcion":"Formatos",
  ///     "activo":false
  ///   },
  ///   {
  ///     "id":"/mi-perfil",
  ///     "descripcion":"Mi Perfil",
  ///     "activo":false,
  ///     "submodulos":
  ///       [
  ///         {
  ///           "id":"/datos-fiscales",
  ///           "descripcion":"Datos fiscales",
  ///           "activo":false},
  ///         {
  ///           "id":"/datos-academicos",
  ///           "descripcion":"Datos académicos",
  ///           "activo":false},
  ///         {
  ///           "id":"/datos-personales",
  ///           "descripcion":"Datos personales",
  ///           "activo":false
  ///         }
  ///       ]
  ///   },
  ///   {
  ///     "id":"/anexos",
  ///     "descripcion":"Anexos",
  ///     "activo":false
  ///   },
  ///   {
  ///     "id":"/tabuladores",
  ///     "descripcion":"Tabuladores",
  ///     "activo":false
  ///   },
  ///   {
  ///     "id":"/mis-pagos",
  ///     "descripcion":
  ///     "Mis pagos",
  ///     "activo":false
  ///   }
  /// ]
  Future<int> updateAssistantsPermissions({
    required String idAssistant,
    required String affiliationCode,
    required List<String> permissions,
    required String jwt,
  }) async {
    final String endpoint = '/$idAssistant/medicos/$affiliationCode/permisos';

    Response response = const Response(
      statusCode: 0,
      bodyString: '',
    );

    response = await post(
      endpoint,
      permissions,
      headers: finalHeaders(jwt),
    );

    /// Se procesa la respuesta correcta
    return response.statusCode ?? 0;
  }

  Future getDoctors(String idAssistant, String jwt) async {
    final String loginEnpoint = '/$idAssistant/medicos';

    final Response response = await get(
      headers: finalHeaders(jwt),
      loginEnpoint,
    );

    if (response.statusCode == 200) {
      logger.i('${response.body}');
    }
  }

  Map<String, String> finalHeaders(String jwt) => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $jwt',
  };
}
