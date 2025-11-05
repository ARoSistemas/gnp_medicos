import 'package:get/get.dart';
import 'package:medicos/shared/services/firebase/firebase_service.dart';
import 'package:pdfrx/pdfrx.dart';

class SharedServices extends GetxService {
  late final FirebaseService firebaseService;

  Future<void> init() async {
    firebaseService = Get.put(FirebaseService());

    await firebaseService.init();
    await pdfrxFlutterInitialize();
  }
}
