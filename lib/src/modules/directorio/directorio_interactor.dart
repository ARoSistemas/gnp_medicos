import 'dart:convert';

import 'package:medicos/src/modules/directorio/directorio_contract.dart';
import 'package:medicos/src/modules/directorio/entity/catalogos.dart';
import 'package:medicos/src/modules/directorio/stubs/constants.dart'
    as constants;
import 'package:medicos/src/modules/directorio/stubs/main_configuration.dart';
import 'package:medicos/src/modules/directorio/stubs/request_handler.dart';

class DirectorioInteractor implements DirectorioUseCase {
  // The interactor is now a stateless service and doesn't need
  //a constructor with dependencies.

  @override
  Future<List<Planes>> getPlanes() async {
    // Removed connection check and context-based alerts.
    // The controller will be responsible for this.

    // Using stubbed config directly instead of AppConfig.of(context)
    final Configuration config = mainConfiguration!;
    final Map<String, String> headers = {'apiKey': config.apiKeyServices!};
    final request = MyRequest(
      baseUrl: config.baseOSCP!,
      path: constants.getPlanes,
      method: Method.get,
      headers: headers,
    );

    final MyResponse response = await RequestHandler.httpRequest(request);

    if (response.success) {
      final list = response.response as List;
      final List<Planes> planes =
          list.map((item) => Planes.fromJson(item)).toList()
            // Add the 'Todos' option manually as the old code did.
            ..insert(0, Planes.fromJson({'plan': 'Todos'}));
      return planes;
    } else {
      // The caller should handle the error.
      return [];
    }
  }

  @override
  Future<List<CirculoMedico>> getCirculosM() async => [];
  // The original implementation depended on another interactor and context.
  // This needs to be refactored properly.
  // For now, returning an empty list.
  // TO DO: Implement the actual API call for CirculoMedico

  @override
  Future<List<Especialidad>> getEspecialidades() async {
    final Configuration config = mainConfiguration!;
    final Map<String, String> headers = {'apiKey': config.apiKeyServices!};
    final request = MyRequest(
      baseUrl: config.baseOSCP!,
      path: constants.getEspecialidad,
      method: Method.get,
      headers: headers,
    );

    final MyResponse response = await RequestHandler.httpRequest(request);

    if (response.success) {
      final list = response.response as List;
      final List<Especialidad> especialidades =
          list.map((item) => Especialidad.fromJson(item)).toList()..insert(
            0,
            Especialidad.fromJson({'especialidad': 'Todos'}),
          );
      return especialidades;
    } else {
      return [];
    }
  }

  @override
  Future<List<TipoClinica>> getClinicas() async {
    final Configuration config = mainConfiguration!;
    final Map<String, String> headers = {'apiKey': config.apiKeyServices!};
    final request = MyRequest(
      baseUrl: config.baseIntegracion!,
      path: constants.getTiposClinicas,
      method: Method.get,
      headers: headers,
    );

    final MyResponse response = await RequestHandler.httpRequest(request);

    if (response.success) {
      final list = response.response as List;
      return list.map((item) => TipoClinica.fromJson(item)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<List<TipoServicios>> getTipoServicio() async {
    final Configuration config = mainConfiguration!;
    final Map<String, String> headers = {'apiKey': config.apiKeyServices!};
    final request = MyRequest(
      baseUrl: config.baseOSCP!,
      path: constants.getTiposServicio,
      method: Method.get,
      headers: headers,
    );

    final MyResponse response = await RequestHandler.httpRequest(request);

    if (response.success) {
      final list = response.response as List;
      final List<TipoServicios> servicios =
          list.map((item) => TipoServicios.fromJson(item)).toList()
            ..insert(0, TipoServicios.fromJson({'tipoProveedor': 'Todos'}));
      return servicios;
    } else {
      return [];
    }
  }

  @override
  Future<List<Estados>> getEstados() async {
    final Configuration config = mainConfiguration!;
    final Map<String, String> headers = {'apiKey': config.apiKeyServices!};
    final request = MyRequest(
      baseUrl: config.baseOSCP!,
      path: constants.getEstados,
      method: Method.get,
      headers: headers,
    );

    final MyResponse response = await RequestHandler.httpRequest(request);

    if (response.success) {
      final list = response.response as List;
      final List<Estados> estados =
          list.map((item) => Estados.fromJson(item)).toList()
            ..insert(0, Estados.fromJson({'estado': 'Todos'}));
      // The old logic called getMunicipios here.
      //This should be done in the controller.
      return estados;
    } else {
      return [];
    }
  }

  @override
  Future<List<Municipios>> getMunicipios(String cvEstado) async {
    final Configuration config = mainConfiguration!;
    final Map<String, String> headers = {'apiKey': config.apiKeyServices!};
    final String path = constants.getMunicipios + cvEstado;
    final request = MyRequest(
      baseUrl: config.baseOSCP!,
      path: path,
      method: Method.get,
      headers: headers,
    );

    final MyResponse response = await RequestHandler.httpRequest(request);

    if (response.success) {
      final list = response.response as List;
      final List<Municipios> municipios =
          list.map((item) => Municipios.fromJson(item)).toList()
            ..insert(0, Municipios.fromJson({'municipio': 'Todos'}));
      return municipios;
    } else {
      return [];
    }
  }

  @override
  Future<List<SubEspecialidad>> getSubEspecialidades() async {
    final Configuration config = mainConfiguration!;
    final Map<String, String> headers = {'apiKey': config.apiKeyServices!};
    final request = MyRequest(
      baseUrl: config.baseOSCP!,
      path: constants.getSubEspecialidad,
      method: Method.get,
      headers: headers,
    );

    final MyResponse response = await RequestHandler.httpRequest(request);

    if (response.success) {
      final list = response.response as List;
      return list.map((item) => SubEspecialidad.fromJson(item)).toList();
    } else {
      return [];
    }
  }

  @override
  Future sendAnalytics(String opcion) async {
    final Configuration config = mainConfiguration!;
    final headers = {'Content-Type': 'application/json'};
    final body = {
      'ec': 'App Agentes / $opcion',
      'ea': 'Click directorio',
      'el': 'visita',
    };

    final request = MyRequest(
      baseUrl: config.baseIntegracion!,
      path: constants.apiclient,
      method: Method.post,
      body: json.encode(body),
      headers: headers,
    );

    await RequestHandler.httpRequest(request);
    // The result is not handled, so we don't return anything.
  }
}
