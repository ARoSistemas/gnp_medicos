part of '../view_pdf_page.dart';

class _ViewPdfPhonePage extends StatelessWidget {
  _ViewPdfPhonePage();
  final ViewPdfController _c = Get.find<ViewPdfController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const AppBarPhone(title: 'Convenio'),
    body: Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
      child: Obx(
        () => Stack(
          children: [
            if (_c.documentLineamiento != null && !_c.isLoading.value)
              Column(
                children: [
                  Flexible(
                    child: PdfViewer.data(
                      _c.documentLineamiento!,
                      sourceName: 'lineamientos',
                    ),
                  ),
                  SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
                  OutlinedButton(
                    onPressed: _c.downloadDevice,
                    child: const Text('Descargar'),
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
