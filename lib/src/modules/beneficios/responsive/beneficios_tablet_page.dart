part of '../beneficios_page.dart';

class _BeneficiosTabletPage extends StatelessWidget {
  _BeneficiosTabletPage();

  final BeneficiosController _c = Get.find<BeneficiosController>();

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
            'Beneficios module tablet page',
            style: Get.textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}
