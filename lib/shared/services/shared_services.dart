import 'package:get/get.dart';
import 'package:medicos/shared/services/firebase/analytics_service.dart';
import 'package:medicos/shared/services/firebase/firebase_service.dart';
import 'package:medicos/shared/services/firebase/realtime_service.dart';
import 'package:pdfrx/pdfrx.dart';

class SharedServices extends GetxService {
  late final FirebaseService firebaseService;
  late final RealtimeService realtimeService;
  late final AnalyticsService analyticsService;

  Future<void> init() async {
    firebaseService = Get.put(FirebaseService());
    realtimeService = Get.put(RealtimeService());
    analyticsService = Get.put(AnalyticsService());
    await firebaseService.init();
    await realtimeService.init();
    await analyticsService.init();
    await pdfrxFlutterInitialize();
  }
}
