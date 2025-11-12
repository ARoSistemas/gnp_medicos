part of '../request_documents_page.dart';

class _RequestDocumentsPhonePage extends StatelessWidget {
  _RequestDocumentsPhonePage();

  final RequestDocumentsController _c = Get.find<RequestDocumentsController>();

  @override
  Widget build(BuildContext context) => Obx(
    () => Stack(
      children: [
        Scaffold(
          appBar: AppBarPhone(title: esMessages.mx.documentationRequest.value),
          body: SingleChildScrollView(
            child: Column(
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
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: _c.obx(
                          (data) => Obx(
                            () => DropdownButtonFormField<String>(
                              focusColor: ColorPalette.white,
                              initialValue: _c.selectedDocumentType.value,
                              items: data!.listTypeDocuments
                                  .map(
                                    (document) => DropdownMenuItem<String>(
                                      value: document.cveTipoDocumento,
                                      child: Text(
                                        document.descripcion.value(),
                                        style: Get.textTheme.titleMedium
                                            ?.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: ColorPalette.textTertiary,
                                            ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: _c.onDocumentTypeChanged,
                              hint: Text(
                                esMessages.mx.selectDocumentUpload.value,
                              ),
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
                      ),
                      SizedBox(
                        height: context.scale(30, axis: ScaleAxis.height),
                      ),
                      OutlinedButton.icon(
                        label: Text(esMessages.mx.uploadFile.value),
                        icon: const Icon(Icons.cloud_upload_outlined),
                        onPressed: _c.pickDocument,
                      ),
                      SizedBox(
                        height: context.scale(10, axis: ScaleAxis.height),
                      ),
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
                      SizedBox(
                        height: context.scale(30, axis: ScaleAxis.height),
                      ),
                      _c.obx(
                        (data) {
                          if (data?.listUploadedDocuments.isEmpty ?? true) {
                            return const SizedBox.shrink();
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data!.listUploadedDocuments.length,
                            itemBuilder: (context, index) {
                              final TypeDocumentModel document =
                                  data.listUploadedDocuments[index];
                              return CardUploadFormat(
                                titleDocument: document.nombre.value(),
                                onTapDelete: () => _c.deleteDocument(
                                  document.id.value(),
                                ),
                                onTapView: () {},
                              );
                            },
                          );
                        },
                        onEmpty: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text('Aún no has subido documentos.'),
                          ),
                        ),
                        onError: (error) => Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              'Error: ${error ?? "No se cargaron los datos"}',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: context.scale(30, axis: ScaleAxis.height),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          esMessages.mx.requestAgreement.value,
                        ),
                      ),
                      SizedBox(
                        height: context.scale(20, axis: ScaleAxis.height),
                      ),
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
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: context.scale(
                                        20,
                                        axis: ScaleAxis.height,
                                      ),
                                    ),
                                    Text(
                                      esMessages.mx.requiredDocumentation.value,
                                      style: Get.textTheme.titleMedium
                                          ?.copyWith(
                                            color: ColorPalette.textTertiary,
                                          ),
                                    ),
                                    SizedBox(
                                      height: context.scale(
                                        20,
                                        axis: ScaleAxis.height,
                                      ),
                                    ),
                                    ..._c.state!.listTypeDocuments.map((
                                      document,
                                    ) {
                                      final bool isUploaded = _c
                                          .state!
                                          .listUploadedDocuments
                                          .any(
                                            (uploadedDoc) =>
                                                (uploadedDoc.nombre
                                                        .value()
                                                        .split('.')
                                                        .first) ==
                                                document.descripcion.value(),
                                          );
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 10,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                document.descripcion.value(),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                            Icon(
                                              isUploaded
                                                  ? Icons.check_circle_outline
                                                  : Icons.info_outline,
                                              color: isUploaded
                                                  ? Colors.green
                                                  : ColorPalette.iconBlue,
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
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
          ),
        ),
        if (_c.isLoading.value)
          const Opacity(
            opacity: 0.5,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (_c.isLoading.value)
          const Center(
            child: CircularProgressIndicator(),
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
