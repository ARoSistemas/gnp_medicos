import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:medicos/core/config/flavor_config.dart';
import 'package:medicos/core/messages/messages.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/services/ui/theme/app_theme_service.dart';
import 'package:medicos/core/utils/logger.dart';
import 'package:medicos/shared/bindings/initial_bindings.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/navigation/app_navigation.dart';
import 'package:medicos/src/modules/directorio/directorio_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final AppThemeService theme = appService.ui.appTheme;
    return GetMaterialApp(
      title: FlavorConfig.appName,
      theme: theme.lightTheme,
      darkTheme: theme.darkTheme,
      themeMode: theme.themeMode,
      translations: Messages(),
      locale: Get.deviceLocale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', ''),
      ],
      fallbackLocale: esMessages.mx.locale,
      logWriterCallback: _logWriter,
      // initialRoute: LoginPage.page.name,
      initialRoute: DirectorioPage.page.name,
      initialBinding: InitialBindings(),
      getPages: AppNavigation.pages,
    );
  }
}

void _logWriter(String t, {bool isError = false}) => logger.d(t);
