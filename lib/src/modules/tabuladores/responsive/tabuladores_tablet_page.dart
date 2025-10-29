part of '../tabuladores_page.dart';

class _TabuladoresTabletPage extends StatelessWidget {
  _TabuladoresTabletPage();

  final TabuladoresController _c = Get.find<TabuladoresController>();

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
            'Tabuladores module tablet page',
            style: Get.textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}
