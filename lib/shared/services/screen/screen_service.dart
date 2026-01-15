import 'dart:async';

import 'package:get/get.dart';
import 'package:medicos/shared/utils/enums.dart';

class ScreenService extends GetxService {
  /// Timer para actualizar el layout cada 200ms.
  Timer? _timer;

  /// Layout actual.
  final Rx<AppLayout> currentLayout = AppLayout.mobile.obs;
  
  /// Obtiene el layout actual.
  AppLayout get layout => currentLayout.value;

  @override
  void onReady() {
    super.onReady();
    /// Se actualiza el layout inmediatamente.
    _updateLayout();

    /// Se inicializa el timer para observar el layout.
    _timer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      _updateLayout();
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void _updateLayout() {
    // Se necesita un contexto para Get.width, onReady lo garantiza.
    final double width = Get.width;
    AppLayout newLayout;

    if (width < 600) {
      newLayout = AppLayout.mobile;
    } else if (width < 1200) {
      newLayout = AppLayout.tablet;
    } else {
      newLayout = AppLayout.desktop;
    }

    if (currentLayout.value != newLayout) {
      currentLayout.value = newLayout;
    }
  }

  // Helpers específicos para facilitar la lectura en el código
  bool get isMobile => layout == AppLayout.mobile;
  bool get isTablet => layout == AppLayout.tablet;
  bool get isDesktop => layout == AppLayout.desktop;
}
