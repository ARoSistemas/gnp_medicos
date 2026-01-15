import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/services/firebase/analytics_service.dart';
import 'package:medicos/shared/utils/tools.dart';

class AnalyticsRouteObserver extends RouteObserver<PageRoute<dynamic>> {

  AnalyticsRouteObserver() {
    analytics = Get.find<AnalyticsService>();
  }
  AppStateController get _appState => Get.find<AppStateController>();

  late final AnalyticsService analytics;

  String _extractName(Route<dynamic> route) => 
  route.settings.name ?? route.runtimeType.toString();  

  Future<void> _sendScreenView(Route<dynamic> route) async {
    final String screenName = _extractName(route);
    await analytics.setTag(
      'navegacion',
      params: {
        'seccion': screenName,
        'plataforma': Tools.getPlatformName(),
        if (_appState.userLogued.email.isNotEmpty)
          'usuario': _appState.userLogued.email,
      }
    );
  }

  @override
  Future<void> didPush(Route route, Route? previousRoute) async {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      await _sendScreenView(route);
    }
  }

  @override
  Future<void> didReplace({Route? newRoute, Route? oldRoute}) async {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      await _sendScreenView(newRoute);
    }
  }

  @override
  Future<void> didPop(Route route, Route? previousRoute) async {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute) {
      await _sendScreenView(previousRoute);
    }
  }
}
