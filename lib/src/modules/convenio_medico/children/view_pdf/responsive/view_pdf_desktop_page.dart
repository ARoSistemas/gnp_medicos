part of '../view_pdf_page.dart';

class _ViewPdfDesktopPage extends StatelessWidget {
  _ViewPdfDesktopPage();

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
            'ViewPdf module desktop page',
            style: Get.textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}
