import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/services/network/network_service.dart';
import 'package:medicos/shared/widgets/custom_alert.dart';

class ExceptionAlertProperties {
  ExceptionAlertProperties({
    required this.message,
    this.title = 'Error',
  });

  final String title;
  final String message;
}

final class ExceptionManager {
  static void handleError(
    Exception e,
    Map<Exception, ExceptionAlertProperties>? customExceptionMessages,
  ) {
    if (customExceptionMessages != null) {
      final Iterable<MapEntry<Exception, ExceptionAlertProperties>> entries =
          customExceptionMessages.entries;
      final Type ert = e.runtimeType;
      for (final entry in entries) {
        if (ert == entry.key.runtimeType) {
          appService.alert.show(
            title: entry.value.title,
            message: entry.value.message,
            type: AlertType.error,
          );
          return;
        }
      }
      final bool hasMainException = entries.any(
        (element) => element.key.runtimeType == Exception().runtimeType,
      );
      if (hasMainException) {
        final MapEntry<Exception, ExceptionAlertProperties> entry = entries
            .firstWhere(
              (element) => element.key.runtimeType == Exception().runtimeType,
            );

        appService.alert.show(
          title: entry.value.title,
          message: entry.value.message,
          type: AlertType.error,
        );
        return;
      }
    }

    if (e is HttpException) {
      appService.alert.show(
        title: 'Error',
        message: e.message,
        type: AlertType.error,
      );
    } else if (e is ApiException) {
      appService.alert.show(
        title: 'Error',
        message: e.message,
        type: AlertType.error,
      );
    } else {
      appService.alert.show(
        title: 'Error',
        message: 'Ocurrió un error inesperado.',
        type: AlertType.error,
      );
    }
  }
}
