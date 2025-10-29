part of '../payments_page.dart';

class _PaymentsPhonePage extends StatelessWidget {
  _PaymentsPhonePage();

  final PaymentsController _c = Get.find<PaymentsController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Get.theme.colorScheme.inversePrimary,
      title: Text(_c.state!.name),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Payments module phone page',
            style: Get.textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}
