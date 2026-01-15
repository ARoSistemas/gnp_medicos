part of '../request_documents_page.dart';

class _RequestDocumentsDesktopPage extends StatelessWidget {
  _RequestDocumentsDesktopPage();

  final RequestDocumentsController _c = Get.find<RequestDocumentsController>();

  Widget get _selectDocuments => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: _c.obx(
      (state) => Obx(
        () => DropdownButtonFormField<String>(
          focusColor: ColorPalette.white,
          initialValue: _c.selectedDocumentType.value,
          items: state!.listTypeDocuments
              .map(
                (document) => DropdownMenuItem<String>(
                  value: document.cveTipoDocumento,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      document.descripcion.value(),
                      style: Get.textTheme.titleMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: ColorPalette.textTertiary,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
          selectedItemBuilder: (context) => state.listTypeDocuments
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
            floatingLabelBehavior: FloatingLabelBehavior
            .auto,
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
  );

  Widget get _dragAndDrop => DropTarget(
    onDragEntered: (_) => _c.onDragEntered(),
    onDragExited: (_) => _c.onDragExited(),
    onDragDone: _c.onDragDone,
    child: Column(
      children: [
        Obx(
          () => DottedBorder(
            color: _c.isDragging.value
                ? ColorPalette.primary
                : ColorPalette.borderGrey,
            strokeWidth: 2,
            dashPattern: const [8, 4],
            borderType: BorderType.RRect,
            radius: const Radius.circular(4),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: double.infinity,
              padding: const EdgeInsets.all(60),
              decoration: BoxDecoration(
                color: _c.isDragging.value
                    ? ColorPalette.primary.withValues(alpha: 0.05)
                    : ColorPalette.backgroundCardBanner,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud_upload_outlined,
                    size: 60,
                    color: _c.isDragging.value
                        ? ColorPalette.primary
                        : ColorPalette.textSecondary.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    _c.isDragging.value
                        ? 'Suelta el archivo aquí'
                        : 'Arrastra o sube un archivo en formato,',
                    style: Get.textTheme.bodyMedium?.copyWith(
                      color: _c.isDragging.value
                          ? ColorPalette.primary
                          : ColorPalette.textSecondary,
                      fontWeight: _c.isDragging.value
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                  if (!_c.isDragging.value) ...[
                    Text(
                      'máximo 3 MB por archivo:',
                      style: Get.textTheme.bodyMedium?.copyWith(
                        color: ColorPalette.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      msg.formatsForUpload.tr(),
                      style: Get.textTheme.bodyMedium?.copyWith(
                        color: ColorPalette.textSecondary,
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  Obx(
                    () => ElevatedButton(
                      onPressed: _c.selectedDocumentType.value != null
                          ? _c.pickDocument
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorPalette.white,
                        foregroundColor: ColorPalette.primary,
                        side: BorderSide(
                          color: _c.selectedDocumentType.value != null
                              ? ColorPalette.primary
                              : Colors.transparent,
                        ),
                        elevation: 0,
                        minimumSize: const Size(200, 48),
                      ),
                      child: Text(msg.uploadFile.tr()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildRequiredDocumentItem(String title, bool isUploaded) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Get.textTheme.bodyMedium?.copyWith(
              color: isUploaded
                  ? ColorPalette.textPrimary
                  : ColorPalette.textSecondary,
              fontWeight: isUploaded ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ),
        Icon(
          isUploaded ? Icons.check_circle : Icons.info_outline,
          color: isUploaded ? ColorPalette.success : ColorPalette.iconBlue,
          size: 20,
        ),
      ],
    ),
  );

  Widget _requiredDocuments(BuildContext context) => Column(
    children: [
      SectionTitle(title: msg.requiredDocumentation.tr().toUpperCase()),
      SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
      _c.obx(
        (state) {
          if (state?.listTypeDocuments.isEmpty ?? true) {
            return const SizedBox.shrink();
          }
          return Column(
            children: state!.listTypeDocuments.map((doc) {
              final bool isUploaded = state.listUploadedDocuments.any(
                (uploadedDoc) => uploadedDoc.tipo == doc.cveTipoDocumento,
              );
              return _buildRequiredDocumentItem(
                doc.descripcion.value(),
                isUploaded,
              );
            }).toList(),
          );
        },
        onLoading: const SizedBox.shrink(),
        onEmpty: const SizedBox.shrink(),
        onError: (_) => const SizedBox.shrink(),
      ),
    ],
  );

  Widget _sectionRequired(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _selectDocuments,
      SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
      _dragAndDrop,
      SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
      _requiredDocuments(context),
      SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
      Obx(
        () => ElevatedButton(
          onPressed: _c.areAllDocumentsUploaded.value 
            ? ()=> _c.sendAgreement(isWeb: true) : null,
          style: Get.theme.elevatedButtonTheme.style?.copyWith(
            minimumSize: WidgetStateProperty.all(const Size(0, 48)),
          ),
          child: Text(msg.requestAgreement.tr()),
        ),
      ),
    ],
  );

  Widget _sectionUpload(BuildContext context) => Column(
    children: [
      SectionTitle(title: msg.documentsUploaded.tr().toUpperCase()),
      SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
      _c.obx(
        (state) {
          if (state?.listUploadedDocuments.isEmpty ?? true) {
            return const SizedBox.shrink();
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state!.listUploadedDocuments.length,
            itemBuilder: (context, index) {
              final TypeDocumentModel document =
                  state.listUploadedDocuments[index];
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
                args: [error?.toString() ?? msg.dataNotLoaded.tr()],
              ),
            ),
          ),
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: _sectionRequired(context)),
      SizedBox(width: context.scale(30, axis: ScaleAxis.height)),
      Expanded(child: _sectionUpload(context)),
    ],
  );
}
