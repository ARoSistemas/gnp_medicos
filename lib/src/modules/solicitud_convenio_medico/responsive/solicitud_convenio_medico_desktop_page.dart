part of '../solicitud_convenio_medico_page.dart';

class _SolicitudConvenioMedicoDesktopPage extends StatelessWidget {
  _SolicitudConvenioMedicoDesktopPage();

  final SolicitudConvenioMedicoController _c =
      Get.find<SolicitudConvenioMedicoController>();

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
