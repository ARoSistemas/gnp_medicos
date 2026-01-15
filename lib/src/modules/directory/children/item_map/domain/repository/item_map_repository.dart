import 'package:get/get_connect/http/src/response/response.dart'; 
import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/core/services/network/network_service.dart';
import 'package:medicos/src/modules/directory/children/item_map/domain/entities/dtos/directions_dto.dart';

class ItemMapRepository extends ApiBaseProvider {
  @override
  final String url = AppConfig.urlMaps;

  @override
  final String contextPath = '/maps/api/directions/json';

  Future<Response<DirectionsDto>> getRoutePoints(String directions) => get(
    headers: {},
    directions,
    decoder: (data) {
      if (data != null) {
        return DirectionsDto.fromJson(data);
      }
      return DirectionsDto.empty();
    },
  );

  // Future<Response<DirectionsDto>> getRoutePoints(String directions) async {
  //   try {
  //     http.Response? response;
  //     final Uri uri = Uri.parse('$url$contextPath$directions');
  //     response = await http.get(
  //       uri,
  //       headers: {},
  //     );

  //     if (response.statusCode == HttpStatus.ok) {
  //       final Response<DirectionsDto> res = Response<DirectionsDto>(
  //         body: DirectionsDto.fromJson(jsonDecode(response.body)),
  //         statusCode: response.statusCode,
  //         statusText: response.reasonPhrase,
  //       );

  //       return res;
  //     }

  //     return Response<DirectionsDto>(
  //       body: DirectionsDto.empty(),
  //       statusCode: response.statusCode,
  //       statusText: response.reasonPhrase,
  //     );
  //   } on Exception catch (_) {
  //     return Response<DirectionsDto>(
  //       body: DirectionsDto.empty(),
  //       statusCode: 500,
  //     );
  //   }
  // }
}
