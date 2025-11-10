part of '../upload_documents_page.dart';

class _UploadDocumentsDesktopPage extends StatelessWidget {
  _UploadDocumentsDesktopPage();

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
            'UploadDocuments module desktop page',
            style: Get.textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}
