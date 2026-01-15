import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/font_size_extension.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/drawer/widgets/item_drawer.dart';
import 'package:medicos/src/modules/annexes/annexes_page.dart';
import 'package:medicos/src/modules/benefits/benefits_page.dart';
import 'package:medicos/src/modules/contact/contact_page.dart';
import 'package:medicos/src/modules/convenio_medico/convenio_medico_page.dart';
import 'package:medicos/src/modules/directory/directory_page.dart';
import 'package:medicos/src/modules/formats/formats_page.dart';
import 'package:medicos/src/modules/payments/payments_page.dart';
import 'package:medicos/src/modules/procedures/procedures_page.dart';
import 'package:medicos/src/modules/request_medical_agreement/request_medical_agreement_page.dart';
import 'package:medicos/src/modules/tabulators/tabulators_page.dart';

class DrawerPhone extends StatelessWidget {
  const DrawerPhone({
    required this.jwt,
    required this.permisos,
    required this.banConvenio,
    required this.version,
    super.key,
  });

  final String jwt;
  final Map<String, dynamic> permisos;
  final bool banConvenio;
  final String version;

  @override
  Widget build(BuildContext context) {
    final String request = msg.requestAgreement.tr().replaceAll('de ', '');

    final List<ItemForDrawer> items = [
      ItemForDrawer(
        iconName: 'icono_modulo_convenio_medico.png',
        title: '${msg.agreement.tr()} ${msg.doctor.tr().toLowerCase()}',
        route: ConvenioMedicoPage.page.name,
        visible:
            (permisos[ConvenioMedicoPage.page.name] ?? false) && banConvenio,
      ),
      ItemForDrawer(
        iconName: 'icono_modulo_tabuladores.png',
        title: msg.tabulators.tr(),
        route: TabuladoresPage.page.name,
        visible: (permisos[TabuladoresPage.page.name] ?? false) && banConvenio,
      ),
      ItemForDrawer(
        iconName: 'icono_modulo_mis_pagos.png',
        title: msg.myPayments.tr(),
        route: PaymentsPage.page.name,
        visible: permisos[PaymentsPage.page.name] ?? false,
      ),
      ItemForDrawer(
        iconName: 'icono_modulo_solicitud_convenio_medico.png',
        title: '$request ${msg.doctor.tr().toLowerCase()}',
        route: RequestMedicalAgreementPage.page.name,
        visible: permisos[RequestMedicalAgreementPage.page.name] ?? false,
      ),
      ItemForDrawer(
        iconName: 'icono_modulo_mis_tramites.png',
        title: msg.myProcedures.tr(),
        route: ProceduresPage.page.name,
        visible: (permisos[ProceduresPage.page.name] ?? false) && banConvenio,
      ),
      ItemForDrawer(
        iconName: 'icono_modulo_beneficios.png',
        title: msg.benefits.tr(),
        route: BeneficiosPage.page.name,
        visible: (permisos[BeneficiosPage.page.name] ?? false) && banConvenio,
      ),
      ItemForDrawer(
        iconName: 'icono_modulo_anexos.png',
        title: msg.annexes.tr(),
        route: AnnexesPage.page.name,
        visible: permisos[AnnexesPage.page.name] ?? false,
      ),
      ItemForDrawer(
        iconName: 'icono_modulo_formatos.png',
        title: msg.formats.tr(),
        route: FormatsPage.page.name,
        visible: permisos[FormatsPage.page.name] ?? false,
      ),
      // ItemForDrawer(
      //   iconName: 'icono_modulo_evaluacion.png',
      //   title: 'Evaluación',
      //   route: EvaluationsPage.page.name,
      //   visible: true,
      // ),
      ItemForDrawer(
        iconName: 'icono_modulo_directorio_medico.png',
        title: '${msg.directory.tr()} ${msg.doctor.tr().toLowerCase()}',
        route: DirectoryPage.page.name,
        visible: permisos[DirectoryPage.page.name] ?? false,
      ),
      ItemForDrawer(
        iconName: 'icono_modulo_contacto.png',
        title: msg.contactGnp.tr(),
        route: ContactPage.page.name,
        visible: true,
      ),
    ];

    return Drawer(
      child: Column(
        children: [
          /// Body
          Flexible(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, i) => Visibility(
                visible: items[i].visible,
                child: ItemDrawer(
                  jwt: jwt,
                  icon: items[i].iconName,
                  title: items[i].title,
                  onTap: items[i].route.isNotEmpty
                      ? () => Get.toNamed(items[i].route)
                      : null,
                ),
              ),
            ),
          ),

          /// Footer
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 16),
              child: Column(
                children: [
                  // Row(
                  //   children: [
                  //     Text(
                  //       'Última sesión: 04/01/2025 12_18:11',
                  //       style: TextStyle(
                  //         fontSize: context.fontSize(12),
                  //         color: ColorPalette.textPrimary,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const Divider(color: Colors.transparent),
                  Row(
                    children: [
                      Text(
                        'Versión $version',
                        style: TextStyle(
                          fontSize: context.fontSize(12),
                          color: ColorPalette.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('jwt', jwt))
      ..add(DiagnosticsProperty<Map<String, dynamic>>('permisos', permisos))
      ..add(DiagnosticsProperty<bool>('banConvenio', banConvenio))
      ..add(StringProperty('version', version));
  }
}

class ItemForDrawer {
  ItemForDrawer({
    required this.iconName,
    required this.title,
    required this.route,
    this.visible = false,
  });
  final String iconName;
  final String title;
  final String route;
  final bool visible;
}
