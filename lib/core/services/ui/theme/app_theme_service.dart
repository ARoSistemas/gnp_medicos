import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medicos/core/services/storage/istorage.dart';
import 'package:medicos/core/services/storage/storage_property.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';

part 'app_theme_storage.dart';

class AppThemeService extends GetxService {
  final st = _AppThemeStorage._();

  Future<void> init() async {
    await st.loadAll();
    _themeMode.value = st.themeMode.value;
  }

  /* Other properties */
  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;

  ThemeMode get themeMode => _themeMode.value;

  set themeMode(ThemeMode themeMode) {
    st.save(st.themeMode, themeMode);
    _themeMode.value = themeMode;
    Get.changeThemeMode(themeMode);
  }

  void changeThemeMode() {
    switch (themeMode) {
      case ThemeMode.system:
        themeMode = ThemeMode.light;
      case ThemeMode.light:
        themeMode = ThemeMode.dark;
      case ThemeMode.dark:
        themeMode = ThemeMode.system;
    }
  }

  final FlexScheme _usedScheme = FlexScheme.bahamaBlue;

  ThemeData get lightTheme =>
      FlexThemeData.light(
        scheme: _usedScheme,
        primary: const Color(0xFF0072BC),
        secondary: const Color(0xFF00B9F1),
        onSecondary: const Color(0xFF42A5F5),
        tertiary: const Color(0xFFFD4138),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: ColorPalette.textPrimary,
          ),
          titleLarge: TextStyle(color: ColorPalette.textPrimary),
          titleMedium: TextStyle(color: ColorPalette.textPrimary),
          titleSmall: TextStyle(color: ColorPalette.textPrimary),
          labelLarge: TextStyle(color: ColorPalette.textPrimary),
          labelMedium: TextStyle(color: ColorPalette.textPrimary),
          labelSmall: TextStyle(color: ColorPalette.textPrimary),
          bodySmall: TextStyle(color: ColorPalette.textPrimary),
          bodyMedium: TextStyle(color: ColorPalette.textPrimary),
        ),
      ).copyWith(
        cardTheme: _cardTheme(),
        elevatedButtonTheme: _elevatedButtonTheme(),
        outlinedButtonTheme: _outlineButtonTheme(),
        textButtonTheme: _textButtonTheme(),
        inputDecorationTheme: _inputDecorationTheme(),
        checkboxTheme: _checkBoxTheme(),
      );

  ThemeData get darkTheme => FlexThemeData.dark(
    scheme: _usedScheme,
  ).copyWith(cardTheme: _cardTheme());

  CardThemeData _cardTheme() => CardThemeData(
    color: ColorPalette.white,
    elevation: 2,
    shadowColor: const Color(0xD89E9E9E),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
      side: const BorderSide(
        color: ColorPalette.borderCardUser,
      ),
    ),
  );

  InputDecorationTheme _inputDecorationTheme() => InputDecorationTheme(
    hintStyle: Get.textTheme.titleMedium?.copyWith(
      color: ColorPalette.textSecondary,
      fontWeight: FontWeight.w400,
    ),
    border: const UnderlineInputBorder(
      borderSide: BorderSide(color: ColorPalette.labelText),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: ColorPalette.borderInput,
      ),
    ),
    focusColor: ColorPalette.primary,
    floatingLabelStyle: WidgetStateTextStyle.resolveWith(
      (states) {
        if (states.contains(WidgetState.focused)) {
          return const TextStyle(
            color: ColorPalette.primary,
          );
        }
        return const TextStyle(color: ColorPalette.hintText);
      },
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: ColorPalette.primary),
    ),
    disabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: ColorPalette.backgroundCard),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: const BorderSide(
        color: ColorPalette.errorText,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    labelStyle: Get.textTheme.titleMedium?.copyWith(
      color: ColorPalette.textTertiary,
      fontWeight: FontWeight.w400,
    ),
    helperStyle: const TextStyle(color: ColorPalette.textPrimary),
    filled: true,
    fillColor: ColorPalette.white,
  );

  ElevatedButtonThemeData _elevatedButtonTheme() => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 20),
      backgroundColor: ColorPalette.primary,
      foregroundColor: ColorPalette.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      textStyle: Get.textTheme.titleMedium?.copyWith(inherit: false),
    ),
  );

  OutlinedButtonThemeData _outlineButtonTheme() => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(double.infinity, 20),
      foregroundColor: ColorPalette.primary,
      iconSize: 25,
      side: const BorderSide(
        color: ColorPalette.primary,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      textStyle: Get.textTheme.titleMedium?.copyWith(inherit: false),
    ),
  );

  TextButtonThemeData _textButtonTheme() => TextButtonThemeData(
    style: TextButton.styleFrom(
      minimumSize: const Size(double.infinity, 20),
      foregroundColor: ColorPalette.primary,
      iconSize: 25,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: Get.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w400,
        color: ColorPalette.primary,
        inherit: false,
      ),
    ),
  );

  CheckboxThemeData _checkBoxTheme() => CheckboxThemeData(
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    fillColor: WidgetStateProperty.resolveWith<Color>(
      (states) {
        if (states.contains(WidgetState.selected)) {
          return ColorPalette.primary;
        }
        return Colors.white;
      },
    ),
  );
}
