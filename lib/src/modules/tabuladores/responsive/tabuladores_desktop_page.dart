part of '../tabuladores_page.dart';

class _TabuladoresDesktopPage extends StatelessWidget {
  _TabuladoresDesktopPage();

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
            'Tabuladores module desktop page',
            style: Get.textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}
