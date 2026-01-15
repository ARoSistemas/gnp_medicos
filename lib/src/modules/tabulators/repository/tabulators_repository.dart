import 'package:get/get.dart';
import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/core/services/network/network_service.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/src/modules/tabulators/repository/dtos/circulo_dto.dart';
import 'package:medicos/src/modules/tabulators/repository/dtos/estado_dto.dart';
import 'package:medicos/src/modules/tabulators/repository/dtos/tabulator_dto.dart';

class TabulatorsRepository extends ApiBaseProvider {
  final AppStateController stateControllers = Get.find<AppStateController>();

  @override
  final String url = AppConfig.baseUrlMedicos;

  @override
  final String contextPath = '/gestor-medico';


  Future<Response<List<EstadoDto>>> getEstados() => get(
    '/catalogo/estados-municipios',
    headers: _getHeaders(stateControllers.user.token.jwt),
    decoder: (data) {
      if (data is List) {
        final List<EstadoDto> list = data
        .map((item) => EstadoDto.fromMap(item as Map<String, dynamic>))
        .toList();
        return list;
      }
      return [];
    },
  );

  Future<Response<List<CirculoDto>>> getCirculos() => get(
    '/catalogo/circulos-medicos',
    headers: _getHeaders(stateControllers.user.token.jwt),
    decoder: (data) {
      if (data is List) {
        final List<CirculoDto> list = data
        .map((item) => CirculoDto.fromMap(item as Map<String, dynamic>))
        .toList();
        return list;
      }
      return [];
    },
  );


  Future<Response<List<TabulatorDto>>> getTabuladores(String filters) => get(
    '/tabuladores?$filters',
    headers: _getHeaders(stateControllers.user.token.jwt),
    decoder: (data) {
      if (data is Map) {
        if (data['entidad'] != null) {
          final List<TabulatorDto> list = (data['entidad'] as List)
          .map((item) => TabulatorDto.fromMap(item as Map<String, dynamic>))
          .toList();
          return list;
        }
      }
      return [];
    },
  );

  Map<String, String> _getHeaders(String jwt) => {
    'Authorization': 'Bearer $jwt',
  };
}
