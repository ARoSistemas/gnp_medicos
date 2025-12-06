part of '../contacto_page.dart';

class _ContactoDesktopPage extends StatelessWidget {
  _ContactoDesktopPage();

  final ContactoController _c = Get.find<ContactoController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Get.theme.colorScheme.inversePrimary,
      title: Text(_c.state?.name ?? 'Contacto'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Contacto module desktop page',
            style: Get.textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}
