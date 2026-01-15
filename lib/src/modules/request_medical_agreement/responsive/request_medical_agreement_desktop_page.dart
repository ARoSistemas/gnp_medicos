part of '../request_medical_agreement_page.dart';

class _RequestMedicalAgreementDesktopPage extends StatelessWidget {
  _RequestMedicalAgreementDesktopPage();

 final RequestMedicalAgreementController _c =
      Get.find<RequestMedicalAgreementController>();

  

  Color _getStatusColor(StatusSolicitud status) => switch (status) {
    StatusSolicitud.success => ColorPalette.success,
    StatusSolicitud.inProgress => ColorPalette.iconBlue,
    StatusSolicitud.error => ColorPalette.errorText,
    StatusSolicitud.incompleted => ColorPalette.errorText,
  };

  StatusSolicitud _mapStatus(String cveEstatus) => switch (cveEstatus) {
    '01' => StatusSolicitud.inProgress,
    '02' => StatusSolicitud.incompleted,
    '08' => StatusSolicitud.incompleted,
    _ => StatusSolicitud.success,
  };

  Widget _buildStatusIndicator(
    StatusSolicitud status,
    String description,
  ) => Row(
    children: [
      Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: _getStatusColor(status),
          shape: BoxShape.circle,
        ),
      ),
      const SizedBox(width: 8),
      Flexible(
        child: Text(
          description,
          style: Get.textTheme.bodyMedium?.copyWith(
            color: ColorPalette.textPrimary,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );

  // Convierte la lista de SolicitudModel en filas de widgets
  List<List<Widget>> _buildRows(List<SolicitudModel> requests) =>
    requests.map((request) {
      final StatusSolicitud status = _mapStatus(request.cveEstatus);

      return [
        // Nombre del médico
        Text(
          request.nombreMedico,
          style: Get.textTheme.bodyMedium?.copyWith(
            color: ColorPalette.textPrimary,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        // Folio (con funcionalidad de copiar)
        InkWell(
          onHover: (value) {},
          onTap: () async {
            await Clipboard.setData(
              ClipboardData(text: request.cveSolicitud),
            );
            AppService.i.alert.show(
              type: AlertType.info,
              title: 'Copiado',
              message: 'Folio copiado al portapapeles',
            );
          },
          child: Text(
            request.cveSolicitud,
            style: Get.textTheme.bodyMedium?.copyWith(
              color: ColorPalette.textPrimary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        // Fecha
        Text(
          request.fechaSolicitud,
          style: Get.textTheme.bodyMedium?.copyWith(
            color: ColorPalette.textPrimary,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        // Estatus
        _buildStatusIndicator(status, request.descripcionEstatus),
        // Acciones
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (status == StatusSolicitud.error ||
                  status == StatusSolicitud.incompleted) ...[
                const SizedBox(width: 8),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorPalette.borderGrey),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.cloud_upload_outlined,
                      color: ColorPalette.black,
                      size: 24,
                    ),
                    onPressed: () async {
                      await Get.toNamed(
                        UploadDocumentsPage.page.name,
                        arguments: request.cveSolicitud,
                      );
                      await _c.getRequestsAgreement();
                    },
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorPalette.borderGrey),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.help_outline,
                      color: ColorPalette.black,
                      size: 24,
                    ),
                    onPressed: () async {
                      await _c.getComment(request.cveSolicitud);
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ];
    }).toList();

  Widget _addedBitacora(BuildContext context) => TextButton.icon(
    style: ButtonStyle(
      minimumSize: WidgetStateProperty.all<Size>(Size.zero),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(horizontal: 4),
      ),
      visualDensity: VisualDensity.compact,
    ),
    icon: const Icon(
      Icons.add,
      color: ColorPalette.primary,
      size: 20,
    ),
    label: Text(
      msg.newRequest.tr(),
      style: Get.textTheme.titleMedium?.copyWith(
        color: ColorPalette.primary,
        fontWeight: FontWeight.w500,
      ),
    ),
    onPressed: _c.goToNewRequest,
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarWeb(
      title: msg.requestLog.tr(),
      widget: _addedBitacora(context),
    ),
    body: _c.obx(
      (state) => Obx(
        () => Padding(
          padding: const EdgeInsets.all(24),
          child: TableWeb(
            headers: _c.tableHeaders,
            rows: _buildRows(_c.requestsAgreementWeb),
            isFetchingMore: false,
            isLoading: _c.isLoading.value,
            emptyMessage: msg.noInformationToShow.tr(),
            onNextPage: () => _c.onChangePage(_c.currentPage.value + 1),
            onPreviousPage: () => _c.onChangePage(_c.currentPage.value - 1),
            currentPage: _c.currentPage.value,
            totalPages: _c.totalPage,
            showPagination: true,
            onSort: _c.onSort,
            sortColumn: _c.sortColumn.value,
            isAscending: _c.sortAscending.value,
          ),
        ),
      ),
      onLoading: const Center(child: LoadingGnp()),
      onEmpty: Center(
        child: LoadingGnp(
          icon: const Icon(
            Icons.warning,
            size: 70,
            color: ColorPalette.primary,
          ),
          title: msg.noInformationToShow.tr(),
          subtitle: '',
        ),
      ),
      onError: (_) => Center(
        child: LoadingGnp(
          isError: true,
          title: msg.errorLoadingInfo.tr(),
          subtitle: msg.pleaseTryAgainLater.tr(),
        ),
      ),
    ),
  );
}
