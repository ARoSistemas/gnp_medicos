import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/models/entities/session_mdl.dart';

class AuthGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final AppStateController appState = Get.find();
    // final AppService appService = Get.find();

    if (appState.user.token.jwt.isEmpty) {
      if (kIsWeb) {
        final SessionModel? session = appService.userStorage.getSessionWeb();
        if (session != null) {
          appState..user = session.selected
          ..userLogued = session.logged
          ..userPermissions = session.permissions
          ..buildMenuWeb(msg.home.tr(), []);
          return null;
        }
      }
      return const RouteSettings(name: '/login');
    }

    return null;
  }
}
