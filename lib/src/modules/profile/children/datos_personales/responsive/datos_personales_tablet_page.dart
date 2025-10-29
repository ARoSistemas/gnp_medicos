part of '../datos_personales_page.dart';

class _DatosPersonalesTabletPage extends StatelessWidget {
  _DatosPersonalesTabletPage();

  final DatosPersonalesController _c = Get.find<DatosPersonalesController>();

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
            'DatosPersonales module tablet page',
            style: Get.textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}
