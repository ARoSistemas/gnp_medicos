import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';

class AnalyticsService extends GetxService {
  static AnalyticsService get i => Get.find();

  late FirebaseAnalytics _analytics;

  Future<void> init() async {
    _analytics = FirebaseAnalytics.instance;
  }

  Future<void> setTag(String eventName, {Map<String, Object>? params}) async {
    await _analytics.logEvent(
      name: eventName,
      parameters: params
    );
  }
}
