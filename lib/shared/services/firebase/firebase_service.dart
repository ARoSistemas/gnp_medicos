import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/config/firebase_config.dart';

class FirebaseService extends GetxService {
  static FirebaseService get i => Get.find();

  late FirebaseDatabase _db;

  Future<void> init() async {
    await Firebase.initializeApp(
      options: FirebaseConfig.currentPlatformOptions,
    );
    _db = FirebaseDatabase.instance;
  }

  Future<Map?> getDataOnce(String path) async {
    final DataSnapshot snapshot = await _db.ref(path).get();
    if (snapshot.exists) {
      return Map<String, dynamic>.from(snapshot.value! as Map);
    }
    return null;
  }


  Future<bool> setDataOnce(String path, dynamic data) async {
    try {
      await _db.ref(path).set(data);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
