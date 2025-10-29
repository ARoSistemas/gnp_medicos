import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/navigation/route_params.dart';

class NavigationService extends GetxService {

  String _getFullPath(
    GetPage page,
    RouteParams? routeParams,
  ) {
    final GetPage? parentPage = Get.routeTree.routes.firstWhereOrNull(
      (route) => route.children.any(
        (e) => e.name == page.name,
      ),
    );

    String fullPath = parentPage != null
        ? '${parentPage.name}${page.name}'
        : page.name;
    routeParams?.pathsMap.forEach(
      (key, value) {
        fullPath = fullPath.replaceAll(':$key', value);
      },
    );

    return fullPath;
  }

  void to({
    required GetPage page,
    RouteParams? routeParams,
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
  }) {
    final String fullPath = _getFullPath(page, routeParams);
    unawaited(
      Get.toNamed(
        fullPath,
        parameters: routeParams?.queriesMap,
        id: id,
        preventDuplicates: preventDuplicates,
        arguments: arguments,
      ),
    );
  }

  void off({
    required GetPage page,
    RouteParams? routeParams,
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
  }) {
    final String fullPath = _getFullPath(page, routeParams);
    unawaited(
      Get.offNamed(
        fullPath,
        parameters: routeParams?.queriesMap,
        id: id,
        preventDuplicates: preventDuplicates,
        arguments: arguments,
      ),
    );
  }

  void offAll({
    required GetPage page,
    RoutePredicate? predicate,
    RouteParams? routeParams,
    dynamic arguments,
    int? id,
  }) {
    final String fullPath = _getFullPath(page, routeParams);
    unawaited(
      Get.offAllNamed(
        fullPath,
        predicate: predicate,
        parameters: routeParams?.queriesMap,
        id: id,
        arguments: arguments,
      ),
    );
  }

  void offUntil({
    required GetPage page,
    required RoutePredicate predicate,
    RouteParams? routeParams,
    dynamic arguments,

    int? id,
    bool preventDuplicates = true,
  }) {
    final String fullPath = _getFullPath(page, routeParams);
    unawaited(
      Get.offNamedUntil(
        fullPath,
        predicate,
        parameters: routeParams?.queriesMap,
        id: id,
        arguments: arguments,
      ),
    );
  }
}
