part of '../upload_documents_page.dart';

class _UploadDocumentsDesktopPage extends StatelessWidget {
  _UploadDocumentsDesktopPage();

  final UploadDocumentsController _c = Get.find<UploadDocumentsController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: ColorPalette.white,
    appBar: AppBarWeb(
      title: msg.documentationRequest.tr(),
      onBack: Get.back,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
            title: 'SUBIR DOCUMENTOS', 
            widget: ElevatedButton(
              onPressed: _c.downloadFormats,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorPalette.white,
                foregroundColor: ColorPalette.primary,
                side: const BorderSide(color: ColorPalette.primary),
                elevation: 0,
                minimumSize: const Size(0, 48),
              ),
              child: Row(
                spacing: 8,
                children:[
                  Text(msg.downloadFormats.tr()),
                  SizedBox(width: context.scale(4)),
                  const Icon(Icons.cloud_download_outlined)
                  
                ]
              ),
            ),
          ),
          SizedBox(height: context.scale(8, axis: ScaleAxis.height)),
          Text(
            msg.requestMedicalAgreement.tr(),
            style: Get.textTheme.bodyMedium?.copyWith(
              color: ColorPalette.textSecondary,
              height: 1.5,
            ),
          ),
          SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
          const RequestDocumentsDesktopView(),
        ],
      ),
    ),
  );
}
