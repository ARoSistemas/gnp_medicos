part of '../request_documents_page.dart';

class _RequestDocumentsTabletPage extends StatelessWidget {
  _RequestDocumentsTabletPage();

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
            'RequestDocuments module tablet page',
            style: Get.textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}
