import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class RealtimeService extends GetxService {
  static RealtimeService get i => Get.find();

  late FirebaseDatabase _db;

  Future<void> init() async {
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
