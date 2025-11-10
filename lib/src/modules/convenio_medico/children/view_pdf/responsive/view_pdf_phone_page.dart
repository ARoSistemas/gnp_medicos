part of '../view_pdf_page.dart';

class _ViewPdfPhonePage extends StatelessWidget {
  _ViewPdfPhonePage();
  final ViewPdfController _c = Get.find<ViewPdfController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhone(title: _c.type),
    body: Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
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
                      height: context.scale(10, axis: ScaleAxis.height)
                    )
                  ),
                  Visibility(
                    visible: _c.type != FileTypesAgree.agreement,
                    child: OutlinedButton(
                      onPressed: _c.downloadDevice,
                      child: Text(msg.download.value),
                    ),
                  ),
                  SizedBox(height: context.scale(40, axis: ScaleAxis.height)),
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
