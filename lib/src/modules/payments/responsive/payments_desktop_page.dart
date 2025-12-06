part of '../payments_page.dart';

class _PaymentsDesktopPage extends StatelessWidget {
  _PaymentsDesktopPage();

  final PaymentsController _c = Get.find<PaymentsController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Get.theme.colorScheme.inversePrimary,
      title: Text(_c.state?.name ?? 'Mis Pagos'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Payments module desktop page',
            style: Get.textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}
