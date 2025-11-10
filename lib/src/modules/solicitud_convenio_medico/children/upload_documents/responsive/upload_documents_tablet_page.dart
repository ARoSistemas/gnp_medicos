part of '../upload_documents_page.dart';

class _UploadDocumentsTabletPage extends StatelessWidget {
  _UploadDocumentsTabletPage();

  final UploadDocumentsController _c = Get.find<UploadDocumentsController>();

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
            'UploadDocuments module tablet page',
            style: Get.textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}
