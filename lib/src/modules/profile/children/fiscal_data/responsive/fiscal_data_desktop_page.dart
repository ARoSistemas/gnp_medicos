part of '../fiscal_data_page.dart';

class DatosFiscalesDesktopPage extends StatelessWidget {
  DatosFiscalesDesktopPage({super.key});

  final DatosFiscalesController _c = Get.find<DatosFiscalesController>();

  Widget _field({
    required String label,
    required String hintText,
    required TextEditingController controller,
    bool enabled = false,
  }) => TextFormField(
    decoration: InputDecoration(
      labelText: label,
      hintText: hintText,
    ),
    controller: controller,
    validator: (value) => '',
    enabled: enabled,
  );

  List<Widget> get fields => [
    _field(
      label: 'RFC',
      hintText: 'RFC',
      controller: _c.rfcCtrler,
    ),
    _field(
      label: 'Domicilio Fiscal',
      hintText: 'Domicilio Fiscal',
      controller: _c.domicilioFiscalCtrler,
    ),
    _field(
      label: 'Método de Pago Preferido',
      hintText: 'Método de Pago Preferido',
      controller: _c.metodoPagoCtrler,
    ),
  ];

  Widget get _fieldsSection => LayoutBuilder(
    builder: (context, constraints) {
      final int crossAxisCount = constraints.maxWidth > 650 ? 2 : 1;
      final double childAspectRatio = crossAxisCount == 2
          ? constraints.maxWidth * 0.0058
          : constraints.maxWidth * 0.01;
      return GridView.count(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: 16,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: fields,
      );
    },
  );

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          SectionTitle(title: msg.generalData.tr().toUpperCase()),
          SizedBox(height: context.scale(16, axis: ScaleAxis.height)),
          _fieldsSection,
          SizedBox(height: context.scale(16, axis: ScaleAxis.height)),
          const SectionTitle(title: 'DATOS BANCARIOS PARA PAGO'),
          SizedBox(height: context.scale(16, axis: ScaleAxis.height)),
          CardDataBank(
            bank: _c.dataBank.bankDescription,
            name: _c.appState.user.nombreCompleto,
            clabe: _c.dataBank.clabe.padLeft(18, '*'),
            numberCount: _c.dataBank.account.padLeft(11, '*'),
            jwt: _c.jwt,
          ),
          SizedBox(height: context.scale(24, axis: ScaleAxis.height)),
          TextButton.icon(
                      onPressed: _c.goToSovos,
                      label: Text(
                        '¿Cómo subir mis pagos?',
                        style: Get.textTheme.titleMedium?.copyWith(
                          color: ColorPalette.primary,
                        ),
                      ),
                      iconAlignment: IconAlignment.end,
                      icon: ImageFromWeb(
                        imageName: 'icono_modulo_fiscales_pagos.png',
                        jwt: _c.user.token.jwt,
                      ),
                    ),
        ],
      ),
    ),
  );
}
