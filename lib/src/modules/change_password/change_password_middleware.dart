part of 'change_password_page.dart';

// If you don't use it, you can remove this file
class _ChangePasswordMiddleware extends GetMiddleware {}

class _ActivarMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (route != null && route.contains('activar')) {
      final Uri uri = Uri.parse(route);
      final String? token = uri.queryParameters['token'];
      if (token != null) {
        return RouteSettings(
          name: '/change-password',
          arguments: {'token': token},
        );
      }
      return const RouteSettings(name: '/change-password');
    }
    return null;
  }
}
