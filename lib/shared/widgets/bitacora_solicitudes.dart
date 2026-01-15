import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/models/incoming/solicitudes_model.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/custom_alert.dart';
import 'package:medicos/src/modules/request_medical_agreement/widgets/card_solicitud.dart';

class LogRequests extends StatelessWidget {
  const LogRequests({
    required this.requests,
    this.onActionTap,
    this.onCommentTap,
    this.isLoading = false,
    this.emptyMessage,
    this.headerDoctorName,
    this.headerFolio,
    this.headerDate,
    this.headerStatus,
    this.headerActions,
    super.key,
  });

  final List<SolicitudModel> requests;
  final Future<void> Function(SolicitudModel)? onActionTap;
  final Future<void> Function(SolicitudModel)? onCommentTap;
  final bool isLoading;
  final String? emptyMessage;
  final String? headerDoctorName;
  final String? headerFolio;
  final String? headerDate;
  final String? headerStatus;
  final String? headerActions;

  Widget get _header => DecoratedBox(
    decoration: const BoxDecoration(
      color: ColorPalette.backgroundCardBanner,
    ),
    child: IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: _buildTableHeader(
              headerDoctorName ?? msg.doctorsName.tr(),
            ),
          ),
          Expanded(
            flex: 3,
            child: _buildTableHeader(
              headerFolio ?? msg.applicationSheet.tr(),
            ),
          ),
          Expanded(
            flex: 2,
            child: _buildTableHeader(
              headerDate ?? msg.dateRequest.tr(),
            ),
          ),
          Expanded(
            flex: 2,
            child: _buildTableHeader(
              headerStatus ?? 'Estatus',
            ),
          ),
          Expanded(
            flex: 2,
            child: _buildTableHeader(
              headerActions ?? 'Acciones',
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildTableHeader(String title) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(
      children: [
        Text(
          title,
          style: Get.textTheme.titleSmall?.copyWith(
            color: ColorPalette.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        const Icon(
          Icons.filter_list_outlined,
          size: 16,
          color: ColorPalette.textPrimary,
        ),
      ],
    ),
  );

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

  Widget _item({
    required int index,
    required SolicitudModel request,
    required StatusSolicitud status,
  }) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: ColorPalette.borderGrey,
              ),
            ),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                // Doctor Name
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Text(
                      request.nombreMedico,
                      style: Get.textTheme.bodyMedium?.copyWith(
                        color: ColorPalette.textPrimary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                // Folio
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: InkWell(
                      onHover: (value) {},
                      onTap: () async {
                        await Clipboard.setData(
                          ClipboardData(text: request.cveSolicitud),
                        );
                        appService.alert.show(
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
                  ),
                ),
                // Date
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Text(
                      request.fechaSolicitud,
                      style: Get.textTheme.bodyMedium?.copyWith(
                        color: ColorPalette.textPrimary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                // Status
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: _buildStatusIndicator(
                      status,
                      request.descripcionEstatus,
                    ),
                  ),
                ),
                // Actions
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Upload icon (conditional)
                        if (status == StatusSolicitud.error ||
                            status == StatusSolicitud.incompleted) ...[
                    
                          const SizedBox(width: 8),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all
                                (color: ColorPalette.borderGrey),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.cloud_upload_outlined,
                                color: ColorPalette.black,
                                size: 24,
                              ),
                              onPressed: onActionTap != null
                                  ? () async {
                                      await onActionTap!(request);
                                    }
                                  : null,
                            ),
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all
                                (color: ColorPalette.borderGrey),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.help_outline,
                                color: ColorPalette.black,
                                size: 24,
                              ),
                              onPressed: onCommentTap != null
                                  ? () async {
                                      await onCommentTap!(request);
                                    }
                                  : null,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: ColorPalette.primary,
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final double tableWidth = constraints.maxWidth > 1250
          ? constraints.maxWidth
          : 1250;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: tableWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: ColorPalette.borderGrey,
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 1),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Column(
                children: [
                  // Table Header
                  _header,
                  // Table Rows
                  if (requests.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: Text(
                        emptyMessage ?? 'No hay solicitudes registradas',
                        style: Get.textTheme.bodyLarge?.copyWith(
                          color: ColorPalette.textSecondary,
                        ),
                      ),
                    )
                  else
                    ...requests.asMap().entries.map((entry) {
                      final int index = entry.key;
                      final SolicitudModel request = entry.value;
                      final StatusSolicitud status = _mapStatus(
                        request.cveEstatus,
                      );

                      return _item(
                        index: index,
                        request: request,
                        status: status,
                      );
                    }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<SolicitudModel>('requests', requests))
      ..add(DiagnosticsProperty<bool>('isLoading', isLoading))
      ..add(
        ObjectFlagProperty<Future<void> Function(SolicitudModel)?>.has(
          'onActionTap',
          onActionTap,
        ),
      )
      ..add(
        ObjectFlagProperty<Future<void> Function(SolicitudModel)?>.has(
          'onCommentTap',
          onCommentTap,
        ),
      )
      ..add(StringProperty('emptyMessage', emptyMessage))
      ..add(StringProperty('headerDoctorName', headerDoctorName))
      ..add(StringProperty('headerFolio', headerFolio))
      ..add(StringProperty('headerDate', headerDate))
      ..add(StringProperty('headerStatus', headerStatus))
      ..add(StringProperty('headerActions', headerActions));
  }
}
