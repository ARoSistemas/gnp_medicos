part of '../datos_fiscales_page.dart';

class _DatosFiscalesTabletPage extends StatelessWidget {
  _DatosFiscalesTabletPage();

  final DatosFiscalesController _c = Get.find<DatosFiscalesController>();

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
            'DatosFiscales module tablet page',
            style: Get.textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}
