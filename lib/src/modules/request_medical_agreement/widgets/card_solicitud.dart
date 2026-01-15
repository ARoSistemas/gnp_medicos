import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/null_extensions.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';

class CardSolicitud extends StatelessWidget {
  const CardSolicitud({
    required this.nameDoctor,
    required this.status,
    required this.dateRequest,
    required this.folio,
    required this.descriptionStatus,
    this.onTapButton,
    this.titleButton,
    super.key,
    this.onTapUpload,
    this.onTapUploadIncompleted,
  });

  final String nameDoctor;
  final String dateRequest;
  final StatusSolicitud status;
  final String descriptionStatus;
  final String folio;
  final Function()? onTapButton;
  final Function()? onTapUpload;
  final Function()? onTapUploadIncompleted;
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
          padding: const EdgeInsets.only(
            left: 15, right: 10, top: 10, bottom: 10
          ),
          margin: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
            color: colorCard(status),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      status == StatusSolicitud.success
                          ? Icons.check_circle_outline
                          : Icons.info_outline,
                      color: colorIcon(status),
                      size: 17,
                    ),
                  ),
                  Text(
                    descriptionStatus,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Get.textTheme.bodyMedium,
                  ),
                ],
              ),
              SizedBox(height: context.scale(16, axis: ScaleAxis.height)),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () async {
                        await Clipboard.setData(
                          ClipboardData(text: folio.value()),
                        );
                      },
                      child: Icon(
                        Icons.copy,
                        color: colorIcon(status),
                        size: 17,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, ),
                    child: Text(
                      '${msg.applicationSheet.tr()}:',
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
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    msg.doctorsName.tr().toUpperCase(),
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
                    msg.dateRequest.tr().toUpperCase(),
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
                      onPressed: onTapUpload,
                      child: Text(msg.uploadInformation.tr()),
                    ),
                  ],
                ),
              if (status == StatusSolicitud.incompleted)
                Column(
                  children: [
                    SizedBox(height: context.scale(16, axis: ScaleAxis.height)),
                    Row(
                      children: [
                        Flexible(
                          flex: 4,
                          child: ElevatedButton(
                            onPressed: onTapUpload,
                            child: Text(msg.uploadInformation.tr()),
                          ),
                        ),
                        SizedBox(
                          width: context.scale(10, axis: ScaleAxis.height),
                        ),
                        IconButton(
                          padding: const EdgeInsets.all(8),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: ColorPalette.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: onTapUploadIncompleted,
                          icon: const Icon(
                            Icons.help_outline_rounded,
                            size: 30,
                            color: ColorPalette.primary,
                            weight: 1.30,
                          ),
                        ),
                      ],
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
      ..add(ObjectFlagProperty<Function()?>.has('onTapUpload', onTapUpload))
      ..add(EnumProperty<StatusSolicitud>('status', status))
      ..add(StringProperty('nameDoctor', nameDoctor))
      ..add(StringProperty('dateRequest', dateRequest))
      ..add(StringProperty('folio', folio))
      ..add(StringProperty('descriptionStatus', descriptionStatus))
      ..add(
        ObjectFlagProperty<Function()?>.has(
          'onTapUploadIncompleted',
          onTapUploadIncompleted,
        ),
      );
  }

  Color colorCard(StatusSolicitud statusSolicitud) => switch (status) {
    StatusSolicitud.inProgress => ColorPalette.backgroundCard,
    StatusSolicitud.error => ColorPalette.bannerCardRed,
    StatusSolicitud.incompleted => ColorPalette.bannerCardRed,
    StatusSolicitud.success => ColorPalette.bannerCardGreen,
  };

  Color colorIcon(StatusSolicitud statusSolicitud) => switch (status) {
    StatusSolicitud.inProgress => ColorPalette.iconBlue,
    StatusSolicitud.error => ColorPalette.errorText,
    StatusSolicitud.incompleted => ColorPalette.errorText,
    StatusSolicitud.success => ColorPalette.success,
  };
}

enum StatusSolicitud { inProgress, success, error, incompleted }
