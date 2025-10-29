part of '../evaluations_page.dart';

class _EvaluationsPhonePage extends StatelessWidget {
  _EvaluationsPhonePage();

  final EvaluationsController _c = Get.find<EvaluationsController>();

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
            'Evaluations module phone page',
            style: Get.textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}
