import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/null_extensions.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/src/modules/solicitud_documentacion/solicitud_documentacion_page.dart';

class CardSolicitud extends StatelessWidget {
  const CardSolicitud({
    required this.nameDoctor,
    required this.status,
    required this.dateRequest,
    required this.folio,
    this.onTapButton,
    this.titleButton,
    super.key,
  });

  final String nameDoctor;
  final String dateRequest;
  final StatusSolicitud status;
  final String folio;
  final Function()? onTapButton;
  final String? titleButton;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      border: Border.all(color: ColorPalette.borderGrey),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
            color: colorCard(status),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.info_outline,
                      color: colorIcon(status),
                      size: 17,
                    ),
                  ),
                  Text(
                    esMessages.mx.status.value,
                    style: Get.textTheme.bodyMedium,
                  ),
                ],
              ),
              Flexible(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10, left: 50),
                      child: Text(
                        '${esMessages.mx.applicationSheet.value}:',
                        style: Get.textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                      child: Tooltip(
                        message: folio.value(),
                        child: GestureDetector(
                          onTap: () async {
                            await Clipboard.setData(
                              ClipboardData(text: folio.value()),
                            );
                          },
                          child: Text(
                            folio.value(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Get.textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    esMessages.mx.doctorsName.value.toUpperCase(),
                    style: Get.textTheme.labelSmall,
                  ),
                  Text(
                    nameDoctor.value(),
                    style: Get.textTheme.titleMedium?.copyWith(
                      color: ColorPalette.textTertiary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.scale(16, axis: ScaleAxis.height)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    esMessages.mx.dateRequest.value.toUpperCase(),
                    style: Get.textTheme.labelSmall,
                  ),
                  Text(
                    dateRequest.value(),
                    style: Get.textTheme.titleMedium?.copyWith(
                      color: ColorPalette.textTertiary,
                    ),
                  ),
                ],
              ),
              if (status == StatusSolicitud.error)
                Column(
                  children: [
                    SizedBox(height: context.scale(16, axis: ScaleAxis.height)),
                    ElevatedButton(
                      onPressed: () =>
                          Get.toNamed(SolicitudDocumentacionPage.page.name),
                      child: Text(esMessages.mx.uploadInformation.value),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<Function()?>.has('onTapButton', onTapButton))
      ..add(StringProperty('titleButton', titleButton))
      ..add(EnumProperty<StatusSolicitud>('status', status))
      ..add(StringProperty('nameDoctor', nameDoctor))
      ..add(StringProperty('dateRequest', dateRequest))
      ..add(StringProperty('folio', folio));
  }

  Color colorCard(StatusSolicitud statusSolicitud) => switch (status) {
    StatusSolicitud.inProgress => ColorPalette.backgroundCard,
    StatusSolicitud.error => ColorPalette.bannerCardRed,
    StatusSolicitud.success => ColorPalette.bannerCardGreen,
  };

  Color colorIcon(StatusSolicitud statusSolicitud) => switch (status) {
    StatusSolicitud.inProgress => ColorPalette.iconBlue,
    StatusSolicitud.error => ColorPalette.errorText,
    StatusSolicitud.success => ColorPalette.success,
  };
}

enum StatusSolicitud {
  inProgress,
  success,
  error,
}
