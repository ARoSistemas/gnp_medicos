part of 'app_theme_service.dart';

class _AppThemeStorage extends IStorage {
  _AppThemeStorage._();

  @override
  String get boxName => 'appTheme';

  @override
  GetStorage get box => GetStorage(boxName);

  @override
  Set<StorageProperty> get properties => {
    themeMode,
  };

  StorageProperty<ThemeMode> themeMode = ThemeMode.system.st(
    key: 'themeMode',
    enumLoad: (v) => ThemeMode.values[v],
  );
}
