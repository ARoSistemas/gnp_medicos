import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/core/services/network/network_service.dart';
import 'package:medicos/src/modules/profile/domain/entities/dtos/profile_dto.dart';

class ProfileRepository extends ApiBaseProvider {
  @override
  final String url = AppConfig.baseUrlMedicos;

  @override
  final String contextPath = '/gestor-medico/';

  Future<Response<ProfileDto>> fetchProfile({
    required String rfc,
    required String jwt,
    required String codigoFiliacion
  }) => get(
    'medicos/$rfc/perfil${
      codigoFiliacion.isNotEmpty
      ? '?codigoFiliacion=$codigoFiliacion' : ''}',
    headers: {
      'Authorization': 'Bearer $jwt',
    },
    decoder: (data) {
      final tmp = data as Map<String, dynamic>;

      final Map<String, dynamic> tmpDatosPersonales =
          tmp['datosPersonales'] ?? {};

      if (tmpDatosPersonales.isNotEmpty) {
        return ProfileDto.fromMap(data);
      }

      return ProfileDto.empty();
    },
  );

  Future<Response> uploadProfilePhoto({
    required String jwt,
    required String rfc,
    required String fileName,
    required Uint8List? fileBytes,
  }) {
    final FormData form = FormData({
      'file': MultipartFile(
        fileBytes,
        filename: fileName,
        contentType: 'image/png',
      ),
    });

    return post(
      'assets/avatar/$rfc',
      form,
      headers: {
        'Authorization': 'Bearer $jwt',
      },
    );
  }
}
