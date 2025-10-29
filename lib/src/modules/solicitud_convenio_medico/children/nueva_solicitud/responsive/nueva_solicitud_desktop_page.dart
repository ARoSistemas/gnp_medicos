part of '../nueva_solicitud_page.dart';

class _NuevaSolicitudDesktopPage extends StatelessWidget {
  _NuevaSolicitudDesktopPage();

  final NuevaSolicitudController _c = Get.find<NuevaSolicitudController>();

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
            'NuevaSolicitud module desktop page',
            style: Get.textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}
