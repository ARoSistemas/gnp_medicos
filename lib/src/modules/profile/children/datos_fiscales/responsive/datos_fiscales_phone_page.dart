part of '../datos_fiscales_page.dart';

class _DatosFiscalesPhonePage extends StatelessWidget {
  _DatosFiscalesPhonePage();

  final DatosFiscalesController _c = Get.find<DatosFiscalesController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const AppBarPhone(title: 'Datos fiscales'),
    body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
          BannerMedico(
            name: _c.user.nombreCompleto,
            medicalIdentifier: _c.user.codigoFiliacion,
          ),
          SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SectionTitle(title: 'DATOS FISCALES'),
                  SizedBox(height: context.scale(15, axis: ScaleAxis.height)),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'RFC',
                      hintText: 'RFC',
                    ),
                    controller: _c.birthdateController,
                    validator: (value) => '',
                    enabled: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 10),
                    child: Text(
                      'Con homoclave',
                      style: Get.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Domicilio Fiscal',
                      hintText: 'Domicilio Fiscal',
                    ),
                    controller: _c.phoneNumberController,
                    validator: (value) => '',
                    enabled: false,
                  ),
                  SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Método de Pago Preferido',
                      hintText: 'Método de Pago Preferido',
                    ),
                    controller: _c.emailController,
                    validator: (value) => '',
                    enabled: false,
                  ),
                  SizedBox(height: context.scale(30, axis: ScaleAxis.height)),
                  const SectionTitle(title: 'DATOS BANCARIOS PARA PAGO'),
                  SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                  /* CardDataBank(
                    bank: 'BBA',
                    name: 'Juan Perez',
                    clabe: '{3456278923}',
                    numberCount: '{123456789123456789}',
                    jwt: _c.jwt,
                  ), */
                  SizedBox(height: context.scale(40, axis: ScaleAxis.height)),
                  TextButton.icon(
                    onPressed: () {},
                    label: Text(
                      '¿Cómo subir mis pagos?',
                      style: Get.textTheme.titleMedium?.copyWith(
                        color: ColorPalette.primary,
                      ),
                    ),
                    iconAlignment: IconAlignment.end,
                    icon: ImageFromWeb(
                      imageName: 'icono_modulo_fiscales_pagos.png',
                      jwt: _c.user.token.jwt
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
