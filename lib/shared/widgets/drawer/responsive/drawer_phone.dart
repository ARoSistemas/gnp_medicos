import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/font_size_extension.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/drawer/widgets/item_drawer.dart';
import 'package:medicos/src/modules/anexos/anexos_page.dart';
import 'package:medicos/src/modules/beneficios/beneficios_page.dart';
import 'package:medicos/src/modules/contacto/contacto_page.dart';
import 'package:medicos/src/modules/convenio_medico/convenio_medico_page.dart';
import 'package:medicos/src/modules/directorio/directorio_page.dart';
import 'package:medicos/src/modules/evaluations/evaluations_page.dart';
import 'package:medicos/src/modules/formats/formats_page.dart';
import 'package:medicos/src/modules/payments/payments_page.dart';
import 'package:medicos/src/modules/procedures/procedures_page.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/solicitud_convenio_medico_page.dart';
import 'package:medicos/src/modules/tabuladores/tabuladores_page.dart';

class DrawerPhone extends StatelessWidget {
  const DrawerPhone({
    required this.jwt,
    required this.permisos,
    super.key,
  });

  final String jwt;
  final Map<String, dynamic> permisos;

  @override
  Widget build(BuildContext context) {
    
    final List<ItemForDrawer> items = [
      ItemForDrawer(
        iconName: 'icono_modulo_inicio.png',
        title: 'Inicio',
        route: '/welcome',
        visible: true,
      ),
      ItemForDrawer(
        iconName: 'icono_modulo_convenio_medico.png',
        title: 'Convenio Médico',
        route: ConvenioMedicoPage.page.name,
        visible: permisos[ConvenioMedicoPage.page.name] ?? false,
      ),
      ItemForDrawer(
        iconName: 'icono_modulo_tabuladores.png',
        title: 'Tabuladores',
        route: TabuladoresPage.page.name,
        visible: permisos[TabuladoresPage.page.name] ?? false,
      ),
      ItemForDrawer(
        iconName: 'icono_modulo_mis_pagos.png',
        title: 'Mis pagos',
        route: PaymentsPage.page.name,
        visible: permisos[PaymentsPage.page.name] ?? false,
      ),
      ItemForDrawer(
        iconName: 'icono_modulo_solicitud_convenio_medico.png',
        title: 'Solicitar convenio',
        route: SolicitudConvenioMedicoPage.page.name,
        visible: permisos[SolicitudConvenioMedicoPage.page.name] ?? false,
      ),
      ItemForDrawer(
        iconName: 'icono_modulo_mis_tramites.png',
        title: 'Mis tramites',
        route: ProceduresPage.page.name,
        visible: permisos[ProceduresPage.page.name] ?? false,
      ),
      ItemForDrawer(
        iconName: 'icono_modulo_beneficios.png',
        title: 'Beneficios',
        route: BeneficiosPage.page.name,
        visible: permisos[BeneficiosPage.page.name] ?? false,
      ),
      ItemForDrawer(
        iconName: 'icono_modulo_anexos.png',
        title: 'Anexos',
        route: AnexosPage.page.name,
        visible: permisos[AnexosPage.page.name] ?? false,
      ),
      ItemForDrawer(
        iconName: 'icono_modulo_formatos.png',
        title: 'Formatos',
        route: FormatsPage.page.name,
        visible: permisos[FormatsPage.page.name] ?? false,
      ),
      ItemForDrawer(
        iconName: 'icono_modulo_evaluacion.png',
        title: 'Evaluación',
        route: EvaluationsPage.page.name,
        visible: true,
      ),
      ItemForDrawer(
        iconName: 'icono_modulo_directorio_medico.png',
        title: 'Directorio médico',
        route: DirectorioPage.page.name,
        visible: permisos[DirectorioPage.page.name] ?? false,
      ),
      ItemForDrawer(
        iconName: 'icono_modulo_contacto.png',
        title: 'Contacto GNP',
        route: ContactoPage.page.name,
        visible: true,
      ),
    ];

    return Drawer(
      child: Column(
        children: [
          /// Body
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.92,
            width: double.infinity,
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
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Última sesión: 04/01/2025 12_18:11',
                        style: TextStyle(
                          fontSize: context.fontSize(12),
                          color: ColorPalette.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.transparent),
                  Row(
                    children: [
                      Text(
                        'Versión 7.8.55',
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
      ..add(DiagnosticsProperty<Map<String, dynamic>>('permisos', permisos));
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
