part of '../view_pdf_page.dart';

class _ViewPdfDesktopPage extends StatelessWidget {
  _ViewPdfDesktopPage();

  final ViewPdfController _c = Get.find<ViewPdfController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarWeb(title: _c.title, onBack: Get.back),
    body: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.pWidth(10),
        vertical: context.pHeight(5),
      ),
      child: _c.obx(
        (_) => Column(
          children: [
            if (_c.file != null)
              if (_c.isPdf)
                Flexible(
                  child: PdfViewer.data(
                    _c.file!,
                    sourceName: _c.title.value(),
                  ),
                )
              else if (_c.isImage)
                Expanded(
                  child: Image.memory(
                    _c.file!,
                    fit: BoxFit.contain,
                  ),
                )
              else if (_c.isDoc)
                Flexible(
                  child: DocxView(
                    bytes: _c.file,
                  ),
                ),
            Visibility(
              visible: _c.download,
              child: SizedBox(height: context.pHeight(5)),
            ),
            Visibility(
              visible: _c.download,
              child: OutlinedButton(
                onPressed: _c.downloadDevice,
                child: Text(msg.download.tr()),
              ),
            ),
          ],
        ),
        onLoading: const Center(
          child: CircularProgressIndicator(
            color: ColorPalette.primary,
          ),
        ),
      ),
    ),
  );
}
