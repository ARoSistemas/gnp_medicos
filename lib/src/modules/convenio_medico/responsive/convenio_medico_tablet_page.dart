part of '../convenio_medico_page.dart';

class _ConvenioMedicoTabletPage extends StatelessWidget {
  _ConvenioMedicoTabletPage();

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
            'ConvenioMedico module tablet page',
            style: Get.textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}
