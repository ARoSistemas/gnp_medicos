part of '../procedures_page.dart';

class _ProceduresDesktopPage extends StatelessWidget {
  _ProceduresDesktopPage();

  final ProceduresController _c = Get.find<ProceduresController>();

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
            'Procedures module desktop page',
            style: Get.textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}
