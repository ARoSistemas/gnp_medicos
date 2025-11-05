import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart'; // Importamos GetPlatform

/// Clase estática para acceder a todas las
/// variables de configuración de Firebase
/// inyectadas al momento de la compilación.
class FirebaseConfig {
  // ----------------------------------------
  // 1. Lectura de Variables (Misma que antes)
  // ----------------------------------------
  static const String _projectId = String.fromEnvironment('firebaseProjectId');
  static const String _authDomain = String.fromEnvironment(
    'firebaseAuthDomain',
  );
  static const String _storageBucket = String.fromEnvironment(
    'firebaseStorageBucket',
  );
  static const String _messagingSenderId = String.fromEnvironment(
    'firebaseMessagingSenderId',
  );

  static const String _databaseUrl = String.fromEnvironment(
    'firebaseDatabaseUrl',
  );

  static const String _webApiKey = String.fromEnvironment('webFirebaseApiKey');
  static const String _webAppId = String.fromEnvironment('webFirebaseAppId');

  static const String _androidApiKey = String.fromEnvironment(
    'androidFirebaseApiKey',
  );
  static const String _androidAppId = String.fromEnvironment(
    'androidFirebaseAppId',
  );

  static const String _iosApiKey = String.fromEnvironment('iosFirebaseApiKey');
  static const String _iosAppId = String.fromEnvironment('iosFirebaseAppId');

  // ----------------------------------------
  // 2. Método de Acceso Principal (currentPlatformOptions)
  // ----------------------------------------

  /// Retorna el objeto [FirebaseOptions] correcto usando la detección
  /// de plataforma de GetX.
  static FirebaseOptions get currentPlatformOptions {
    if (GetPlatform.isWeb) {
      return const FirebaseOptions(
        apiKey: _webApiKey,
        appId: _webAppId,
        messagingSenderId: _messagingSenderId,
        projectId: _projectId,
        authDomain: _authDomain,
        storageBucket: _storageBucket,
        databaseURL: _databaseUrl,
      );
    } else if (GetPlatform.isAndroid) {
      return const FirebaseOptions(
        apiKey: _androidApiKey,
        appId: _androidAppId,
        messagingSenderId: _messagingSenderId,
        projectId: _projectId,
        storageBucket: _storageBucket,
        authDomain: _authDomain,
        databaseURL: _databaseUrl,
      );
    } else if (GetPlatform.isIOS || GetPlatform.isMacOS) {
      return const FirebaseOptions(
        apiKey: _iosApiKey,
        appId: _iosAppId,
        messagingSenderId: _messagingSenderId,
        projectId: _projectId,
        storageBucket: _storageBucket,
        authDomain: _authDomain,
        databaseURL: _databaseUrl,
      );
    } else {
      throw UnsupportedError(
        'Plataforma no configurada para Firebase',
      );
    }
  }
}
