part of '../welcome_page.dart';

class _WelcomeTabletPage extends StatelessWidget {
  _WelcomeTabletPage();

  final WelcomeController _c = Get.find<WelcomeController>();

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
            'Welcome module tablet page',
            style: Get.textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}
