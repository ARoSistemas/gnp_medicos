part of '../datos_academicos_page.dart';

class _DatosAcademicosDesktopPage extends StatelessWidget {
  _DatosAcademicosDesktopPage();

  final DatosAcademicosController _c = Get.find<DatosAcademicosController>();

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
            'DatosAcademicos module desktop page',
            style: Get.textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}
