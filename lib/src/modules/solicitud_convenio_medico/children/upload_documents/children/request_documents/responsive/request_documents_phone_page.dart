part of '../request_documents_page.dart';

class _RequestDocumentsPhonePage extends StatelessWidget {
  _RequestDocumentsPhonePage();

  final RequestDocumentsController _c = Get.find<RequestDocumentsController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhone(title: esMessages.mx.documentationRequest.value),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
        BannerMedico(
          name: _c.user.nombreCompleto,
          medicalIdentifier: _c.user.codigoFiliacion,
        ),
        SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                esMessages.mx.selectDocumentUpload.value,
                style: Get.textTheme.titleMedium?.copyWith(
                  color: ColorPalette.textTertiary,
                ),
              ),
              _c.obx(
                (data) => Obx(
                  () => DropdownButtonFormField<String>(
                    focusColor: ColorPalette.white,
                    initialValue: _c.selectedDocumentType.value,
                    items: data!.listTypeDocuments
                        .map(
                          (document) => DropdownMenuItem<String>(
                            value: document.cveTipoDocumento,
                            child: Text(
                              document.descripcion,
                              style: Get.textTheme.titleMedium?.copyWith(
                                color: ColorPalette.textTertiary,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: _c.onDocumentTypeChanged,
                    hint: Text(esMessages.mx.selectDocumentUpload.value),
                    isExpanded: true,
                  ),
                ),
                onEmpty: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: ColorPalette.primary,
                    ),
                  ),
                ),
                onError: (_) => const Center(
                  child: LoadingGnp(
                    title: 'No se cargaron los datos',
                    subtitle: '',
                    icon: Icon(
                      Icons.error,
                      size: 70,
                      color: ColorPalette.primary,
                    ),
                  ),
                ),
              ),
              SizedBox(height: context.scale(30, axis: ScaleAxis.height)),
              OutlinedButton.icon(
                label: Text(esMessages.mx.uploadFile.value),
                icon: const Icon(Icons.cloud_upload_outlined),
                onPressed: () {},
              ),
              SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
              RichText(
                text: TextSpan(
                  style: Get.textTheme.bodySmall,
                  children: <TextSpan>[
                    TextSpan(text: esMessages.mx.fileMaximum.value),
                    TextSpan(
                      text: esMessages.mx.threeMB.value,
                      style: Get.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(text: esMessages.mx.format.value),
                  ],
                ),
              ),
              Text(
                esMessages.mx.formatsForUpload.value,
                style: Get.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: context.scale(30, axis: ScaleAxis.height)),
              CardUploadFormat(
                titleDocument: esMessages.mx.accessionLetter.value,
                onTapDelete: () {},
                onTapView: () {},
              ),
              SizedBox(height: context.scale(30, axis: ScaleAxis.height)),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  esMessages.mx.requestAgreement.value,
                ),
              ),
              SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
              OutlinedButton(
                child: Text(esMessages.mx.requiredDocumentation.value),
                onPressed: () async {
                  await showModalBottomSheet(
                    context: context,
                    builder: (context) => DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            SizedBox(
                              height: context.scale(20, axis: ScaleAxis.height),
                            ),
                            Text(
                              esMessages.mx.requiredDocumentation.value,
                              style: Get.textTheme.titleMedium?.copyWith(
                                color: ColorPalette.textTertiary,
                              ),
                            ),
                            SizedBox(
                              height: context.scale(20, axis: ScaleAxis.height),
                            ),
                            DocumentoRequerido(
                              name: esMessages.mx.accessionLetter.value,
                              upload: true,
                            ),
                            DocumentoRequerido(
                              name: esMessages.mx.accessionLetter.value,
                              upload: true,
                            ),
                            DocumentoRequerido(
                              name: esMessages.mx.accessionLetter.value,
                              upload: true,
                            ),
                            DocumentoRequerido(
                              name: esMessages.mx.accessionLetter.value,
                              upload: true,
                            ),
                            DocumentoRequerido(
                              name: esMessages.mx.accessionLetter.value,
                              upload: true,
                            ),
                            DocumentoRequerido(
                              name: esMessages.mx.accessionLetter.value,
                              upload: true,
                            ),
                            SizedBox(
                              height: context.scale(20, axis: ScaleAxis.height),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(esMessages.mx.understood.value),
                            ),
                            SizedBox(
                              height: context.scale(30, axis: ScaleAxis.height),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class DocumentoRequerido extends StatelessWidget {
  const DocumentoRequerido({
    required this.name,
    required this.upload,
    super.key,
  });

  final String name;
  final bool upload;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            esMessages.mx.requiredDocumentation.value,
            style: Get.textTheme.bodyMedium?.copyWith(
              color: ColorPalette.textSecondary,
            ),
          ),
          Icon(
            upload ? Icons.check_circle_outline : Icons.info_outline,
            size: 20,
            color: upload ? ColorPalette.success : ColorPalette.iconBlue,
          ),
        ],
      ),
      SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
    ],
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('name', name))
      ..add(DiagnosticsProperty<bool>('upload', upload));
  }
}
