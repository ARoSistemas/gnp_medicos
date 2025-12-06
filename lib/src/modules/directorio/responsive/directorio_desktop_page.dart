part of '../directorio_page.dart';

class _DirectorioDesktopPage extends StatelessWidget {
  _DirectorioDesktopPage();

  final DirectorioController _c = Get.find<DirectorioController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Get.theme.colorScheme.inversePrimary,
      title: Text(_c.state?.name ?? 'Directorio'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Directorio module desktop page',
            style: Get.textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}
