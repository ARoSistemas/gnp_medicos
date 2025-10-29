import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/utils/logger.dart';
import 'package:medicos/src/app.dart';

Future<void> main() async {
  final AppService app = Get.put(AppService());
  await app.init();
  logger.i('App Service started');
  runApp(const App());
}
