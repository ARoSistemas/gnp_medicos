part of '../{{module_name.snakeCase()}}_page.dart';

class _{{module_name.pascalCase()}}DesktopPage extends StatelessWidget {
  _{{module_name.pascalCase()}}DesktopPage();

  final {{module_name.pascalCase()}}Controller _c = Get.find<{{module_name.pascalCase()}}Controller>();

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
            '{{module_name.pascalCase()}} module desktop page',
            style: Get.textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}
