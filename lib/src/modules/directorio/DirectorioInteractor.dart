import 'dart:convert';

import 'DirectorioContract.dart';
import 'Entity/Catalogos.dart';
import 'stubs/RequestHandler.dart';
import 'stubs/constants.dart' as Constants;
import 'stubs/main_configuration.dart';

class DirectorioInteractor implements DirectorioUseCase {
  // The interactor is now a stateless service and doesn't need a constructor with dependencies.

  @override
  Future<List<Planes>> getPlanes() async {
    // Removed connection check and context-based alerts.
    // The controller will be responsible for this.

    // Using stubbed config directly instead of AppConfig.of(context)
    final config = mainConfiguration!;
    final headers = {"apiKey": config.apiKeyServices!};
    final request = MyRequest(
      baseUrl: config.baseOSCP!,
      path: Constants.getPlanes,
      method: Method.GET,
      headers: headers,
    );

    final response = await RequestHandler.httpRequest(request);

    if (response.success) {
      final list = response.response as List;
      final planes = list.map((item) => Planes.fromJson(item)).toList();
      // Add the 'Todos' option manually as the old code did.
      planes.insert(0, Planes.fromJson({'plan': 'Todos'}));
      return planes;
    } else {
      // The caller should handle the error.
      return [];
    }
  }

  @override
  Future<List<CirculoMedico>> getCirculosM() async {
    // The original implementation depended on another interactor and context.
    // This needs to be refactored properly.
    // For now, returning an empty list.
    // TODO: Implement the actual API call for CirculoMedico
    return [];
  }

  @override
  Future<List<Especialidad>> getEspecialidades() async {
    final config = mainConfiguration!;
    final headers = {"apiKey": config.apiKeyServices!};
    final request = MyRequest(
      baseUrl: config.baseOSCP!,
      path: Constants.getEspecialidad,
      method: Method.GET,
      headers: headers,
    );

    final response = await RequestHandler.httpRequest(request);

    if (response.success) {
      final list = response.response as List;
      final especialidades = list.map((item) => Especialidad.fromJson(item)).toList();
      especialidades.insert(0, Especialidad.fromJson({'especialidad': 'Todos'}));
      return especialidades;
    } else {
      return [];
    }
  }

  @override
  Future<List<TipoClinica>> getClinicas() async {
    final config = mainConfiguration!;
    final headers = {"apiKey": config.apiKeyServices!};
    final request = MyRequest(
      baseUrl: config.baseIntegracion!,
      path: Constants.getTiposClinicas,
      method: Method.GET,
      headers: headers,
    );

    final response = await RequestHandler.httpRequest(request);

    if (response.success) {
      final list = response.response as List;
      return list.map((item) => TipoClinica.fromJson(item)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<List<TipoServicios>> getTipoServicio() async {
    final config = mainConfiguration!;
    final headers = {"apiKey": config.apiKeyServices!};
    final request = MyRequest(
      baseUrl: config.baseOSCP!,
      path: Constants.getTiposServicio,
      method: Method.GET,
      headers: headers,
    );

    final response = await RequestHandler.httpRequest(request);

    if (response.success) {
      final list = response.response as List;
      final servicios = list.map((item) => TipoServicios.fromJson(item)).toList();
      servicios.insert(0, TipoServicios.fromJson({'tipoProveedor': 'Todos'}));
      return servicios;
    } else {
      return [];
    }
  }

  @override
  Future<List<Estados>> getEstados() async {
    final config = mainConfiguration!;
    final headers = {"apiKey": config.apiKeyServices!};
    final request = MyRequest(
      baseUrl: config.baseOSCP!,
      path: Constants.getEstados,
      method: Method.GET,
      headers: headers,
    );

    final response = await RequestHandler.httpRequest(request);

    if (response.success) {
      final list = response.response as List;
      final estados = list.map((item) => Estados.fromJson(item)).toList();
      estados.insert(0, Estados.fromJson({'estado': 'Todos'}));
      // The old logic called getMunicipios here. This should be done in the controller.
      return estados;
    } else {
      return [];
    }
  }

  @override
  Future<List<Municipios>> getMunicipios(String cvEstado) async {
    final config = mainConfiguration!;
    final headers = {"apiKey": config.apiKeyServices!};
    final path = Constants.getMunicipios + cvEstado;
    final request = MyRequest(
      baseUrl: config.baseOSCP!,
      path: path,
      method: Method.GET,
      headers: headers,
    );

    final response = await RequestHandler.httpRequest(request);

    if (response.success) {
      final list = response.response as List;
      final municipios = list.map((item) => Municipios.fromJson(item)).toList();
      municipios.insert(0, Municipios.fromJson({'municipio': 'Todos'}));
      return municipios;
    } else {
      return [];
    }
  }

  Future<List<SubEspecialidad>> getSubEspecialidades() async {
    final config = mainConfiguration!;
    final headers = {"apiKey": config.apiKeyServices!};
    final request = MyRequest(
      baseUrl: config.baseOSCP!,
      path: Constants.getSubEspecialidad,
      method: Method.GET,
      headers: headers,
    );

    final response = await RequestHandler.httpRequest(request);

    if (response.success) {
      final list = response.response as List;
      return list.map((item) => SubEspecialidad.fromJson(item)).toList();
    } else {
      return [];
    }
  }

  @override
  Future sendAnalytics(String opcion) async {
    final config = mainConfiguration!;
    final headers = {"Content-Type": "application/json"};
    final body = {
      "ec": "App Agentes / $opcion",
      "ea": "Click directorio",
      "el": "visita",
    };

    final request = MyRequest(
      baseUrl: config.baseIntegracion!,
      path: Constants.apiclient,
      method: Method.POST,
      body: json.encode(body),
      headers: headers,
    );

    await RequestHandler.httpRequest(request);
    // The result is not handled, so we don't return anything.
  }
}