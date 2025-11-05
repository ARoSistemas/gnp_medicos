import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/config/firebase_config.dart';

class FirebaseService extends GetxService {
  static FirebaseService get i => Get.find();

  Future<void> init() async {
    await Firebase.initializeApp(
      options: FirebaseConfig.currentPlatformOptions,
    );
  }
}
