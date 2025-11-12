import 'package:get/get_connect/http/src/response/response.dart';
import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/core/services/network/network_service.dart';
import 'package:medicos/src/modules/directorio/children/item_map/domain/entities/dtos/directions_dto.dart';

class ItemMapRepository extends ApiBaseProvider {
  @override
  final String url = AppConfig.urlMaps;

  @override
  final String contextPath = '/maps/api/directions/json';

  Future<Response<DirectionsDto>> getRoutePoints(String directions) => get(
    directions,
    decoder: (data) {
      if (data != null) {
        return DirectionsDto.fromJson(data);
      }
      return DirectionsDto.empty();
    },
  );
}
