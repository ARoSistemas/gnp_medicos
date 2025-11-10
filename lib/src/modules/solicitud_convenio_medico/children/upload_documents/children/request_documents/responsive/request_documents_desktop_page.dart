part of '../request_documents_page.dart';

class _RequestDocumentsDesktopPage extends StatelessWidget {
  _RequestDocumentsDesktopPage();

  final RequestDocumentsController _c = Get.find<RequestDocumentsController>();

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
            'RequestDocuments module desktop page',
            style: Get.textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}
