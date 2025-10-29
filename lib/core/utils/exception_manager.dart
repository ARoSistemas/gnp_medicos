import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/services/network/network_service.dart';
import 'package:medicos/shared/services/alerts/notification_service.dart';
import 'package:medicos/shared/widgets/custom_notification.dart';

final class ExceptionManager {
  static void handleError(
    Exception e,

    String message,
  ) {
    final NotificationServiceImpl notification = AppService.i.notifications;

    if (e is HttpException) {
      notification.show(
        //  title: '${e.code} : ${e.message}',
        title: 'Http exception',
        message: message.isNotEmpty ? message : e.message,
        type: AlertType.error,
      );
    } else if (e is ApiException) {
      notification.show(
        title: 'Api exception',
        message: message.isNotEmpty ? message : e.message,
        type: AlertType.error,
      );
    } else if (e is InternalServerException) {
      notification.show(
        title: 'Error',
        message: message.isNotEmpty ? message : e.message,
        type: AlertType.error,
      );
    } else {
      notification.show(
        title: 'Error',
        message: 'Ocurrió un error inesperado',
        type: AlertType.error,
      );
    }
  }
}
