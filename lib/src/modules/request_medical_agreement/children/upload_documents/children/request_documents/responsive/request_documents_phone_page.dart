part of '../request_documents_page.dart';

class _RequestDocumentsPhonePage extends StatelessWidget {
  _RequestDocumentsPhonePage();

  final RequestDocumentsController _c = Get.find<RequestDocumentsController>();

  @override
  Widget build(BuildContext context) => Obx(
    () => Scaffold(
      appBar: AppBarPhone(title: msg.documentationRequest.tr()),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
            BannerMedico(
              name: _c.user.nombreCompleto,
              lastname: _c.user.apePaterno,
              rfc: _c.user.rfc,
              jwt: _c.user.token.jwt,
              medicalIdentifier: _c.user.codigoFiliacion,
            ),
            SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
            if (_c.isLoading.value)
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: CircularProgressIndicator()),
                ],
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      msg.selectDocumentUpload.tr(),
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
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
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
                                  ),
                                )
                                .toList(),
                            selectedItemBuilder: (context) => data
                                .listTypeDocuments
                                .map(
                                  (document) => Text(
                                    document.descripcion.value(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.textTheme.titleMedium?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: ColorPalette.textTertiary,
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: _c.onDocumentTypeChanged,
                            decoration: InputDecoration(
                              labelText: msg.documents.tr(),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                            ),
                            isExpanded: true,
                          ),
                        ),
                        onLoading: const SizedBox.shrink(),
                        onEmpty: const SizedBox.shrink(),
                        onError: (_) => Center(
                          child: LoadingGnp(
                            isError: true,
                            title: msg.dataNotLoaded.tr(),
                            subtitle: '',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: context.scale(30, axis: ScaleAxis.height),
                    ),
                    Obx(
                      () => OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: _c.selectedDocumentType.value != null
                                ? ColorPalette.primary
                                : ColorPalette.marginCard,
                          ),
                        ),
                        label: Text(msg.uploadFile.tr()),
                        icon: const Icon(Icons.cloud_upload_outlined),
                        onPressed: _c.selectedDocumentType.value != null
                            ? _c.pickDocument
                            : null,
                      ),
                    ),
                    SizedBox(
                      height: context.scale(10, axis: ScaleAxis.height),
                    ),
                    RichText(
                      text: TextSpan(
                        style: Get.textTheme.bodySmall,
                        children: <TextSpan>[
                          TextSpan(text: msg.fileMaximum.tr()),
                          TextSpan(
                            text: msg.threeMB.tr(),
                            style: Get.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(text: msg.format.tr()),
                        ],
                      ),
                    ),
                    Text(
                      msg.formatsForUpload.tr(),
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
                              onTapView: () => _c.viewDocument(
                                document.id.value(),
                                document.nombre.value(),
                              ),
                            );
                          },
                        );
                      },
                      onLoading: const SizedBox.shrink(),
                      onEmpty: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(msg.noDocumentsUploadedYet.tr()),
                        ),
                      ),
                      onError: (error) => Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            msg.errorLoadingData.tr(
                              args: [
                                error?.toString() ?? msg.dataNotLoaded.tr(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: context.scale(30, axis: ScaleAxis.height),
                    ),
                    ElevatedButton(
                      onPressed: _c.areAllDocumentsUploaded.value
                          ? _c.sendAgreement
                          : null,
                      child: Text(
                        msg.requestAgreement.tr(),
                      ),
                    ),
                    SizedBox(
                      height: context.scale(20, axis: ScaleAxis.height),
                    ),
                    OutlinedButton(
                      child: Text(msg.requiredDocumentation.tr()),
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
                                    msg.requiredDocumentation.tr(),
                                    style: Get.textTheme.titleMedium?.copyWith(
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
            msg.requiredDocumentation.tr(),
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
