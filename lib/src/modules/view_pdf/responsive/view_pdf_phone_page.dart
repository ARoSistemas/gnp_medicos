part of '../view_pdf_page.dart';

class _ViewPdfPhonePage extends StatelessWidget {
  _ViewPdfPhonePage();
  final ViewPdfController _c = Get.find<ViewPdfController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhone(title: _c.title),
    body: Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
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
                child: SizedBox(
                  height: context.scale(10, axis: ScaleAxis.height),
                ),
              ),
              Visibility(
                visible: _c.download,
                child: OutlinedButton(
                  onPressed: _c.downloadDevice,
                  child: Text(msg.download.tr()),
                ),
              ),
              SizedBox(height: context.scale(40, axis: ScaleAxis.height)),
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
