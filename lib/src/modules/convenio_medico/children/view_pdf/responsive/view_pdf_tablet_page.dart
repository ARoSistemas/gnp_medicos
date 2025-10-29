part of '../view_pdf_page.dart';

class _ViewPdfTabletPage extends StatelessWidget {
  _ViewPdfTabletPage();

  final ViewPdfController _c = Get.find<ViewPdfController>();

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
            'ViewPdf module tablet page',
            style: Get.textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}
