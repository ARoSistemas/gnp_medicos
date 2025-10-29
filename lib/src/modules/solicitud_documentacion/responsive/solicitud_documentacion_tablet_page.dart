part of '../solicitud_documentacion_page.dart';

class _SolicitudDocumentacionTabletPage extends StatelessWidget {
  _SolicitudDocumentacionTabletPage();

  final SolicitudDocumentacionController _c =
      Get.find<SolicitudDocumentacionController>();

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
            'SolicitudDocumentacion module tablet page',
            style: Get.textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}
