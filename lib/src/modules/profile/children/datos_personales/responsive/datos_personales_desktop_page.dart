part of '../datos_personales_page.dart';

class _DatosPersonalesDesktopPage extends StatelessWidget {
  _DatosPersonalesDesktopPage();

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
            'DatosPersonales module desktop page',
            style: Get.textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}
