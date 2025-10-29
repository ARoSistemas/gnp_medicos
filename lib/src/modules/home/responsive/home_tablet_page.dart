part of '../home_page.dart';

class _HomeTabletPage extends StatelessWidget {
  _HomeTabletPage();

  final HomeController _c = Get.find<HomeController>();

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
            'Home module tablet page',
            style: Get.textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}
