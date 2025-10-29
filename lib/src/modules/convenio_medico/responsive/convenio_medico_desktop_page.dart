part of '../convenio_medico_page.dart';

class _ConvenioMedicoDesktopPage extends StatelessWidget {
  _ConvenioMedicoDesktopPage();

  final ConvenioMedicoController _c = Get.find<ConvenioMedicoController>();

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
            'ConvenioMedico module desktop page',
            style: Get.textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}
