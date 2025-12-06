part of '../view_pdf_page.dart';

class _ViewPdfDesktopPage extends StatelessWidget {
  _ViewPdfDesktopPage();

  final ViewPdfController _c = Get.find<ViewPdfController>();

  @override
  Widget build(BuildContext context) =>  Scaffold(
    appBar: AppBarWeb(title: _c.type),
    body: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.pWidth(10),
        vertical: context.pHeight(5)
      ),
      child: Obx(
        () => Stack(
          children: [
            if (_c.document != null && !_c.isLoading.value)
              Column(
                children: [
                  Flexible(
                    child: PdfViewer.data(
                      _c.document!,
                      sourceName: _c.type,
                    ),
                  ),
                  Visibility(
                    visible: _c.type != FileTypesAgree.agreement,
                    child: SizedBox(
                      height: context.pHeight(5)
                    )
                  ),
                  Visibility(
                    visible: _c.type != FileTypesAgree.agreement,
                    child: OutlinedButton(
                      onPressed: _c.downloadDevice,
                      child: Text(msg.download.value),
                    ),
                  ),
                ],
              )
            else
              const SizedBox.shrink(),
            Visibility(
              visible: _c.isLoading.value,
              child: const Center(
                child: CircularProgressIndicator(
                  color: ColorPalette.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
