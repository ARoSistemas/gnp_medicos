part of '../fiscal_data_page.dart';

class _DatosFiscalesPhonePage extends StatelessWidget {
  _DatosFiscalesPhonePage();

  final DatosFiscalesController _c = Get.find<DatosFiscalesController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const AppBarPhone(title: 'Datos fiscales'),
    body: _c.obx(
      (state) => Column(
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
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SectionTitle(title: 'DATOS FISCALES'),
                    SizedBox(height: context.scale(15, axis: ScaleAxis.height)),
                    TextFormField(
                      readOnly: true,
                      enabled: false,
                      decoration: const InputDecoration(
                        labelText: 'RFC',
                        hintText: 'RFC',
                      ),
                      controller: _c.rfcCtrler,
                      validator: (value) => '',
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
                      readOnly: true,
                      enabled: false,
                      decoration: const InputDecoration(
                        labelText: 'Domicilio Fiscal',
                        hintText: 'Domicilio Fiscal',
                      ),
                      controller: _c.domicilioFiscalCtrler,
                      validator: (value) => '',
                    ),
                    SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                    TextFormField(
                      readOnly: true,
                      enabled: false,
                      decoration: const InputDecoration(
                        labelText: 'Método de Pago Preferido',
                        hintText: 'Método de Pago Preferido',
                      ),
                      controller: _c.metodoPagoCtrler,
                    ),
                    SizedBox(height: context.scale(30, axis: ScaleAxis.height)),
                  
                    const SectionTitle(title: 'DATOS BANCARIOS PARA PAGO'),
                    SizedBox(height:
                    context.scale(20, axis: ScaleAxis.height)),
                    CardDataBank(
                      bank: _c.dataBank.bankDescription,
                      name: _c.appState.user.nombreCompleto,
                      clabe: _c.dataBank.clabe.padLeft(18, '*'),
                      numberCount: 
                      _c.dataBank.account.padLeft(11, '*'),
                      jwt: _c.jwt,
                    ),
                    SizedBox(height:
                    context.scale(20, axis: ScaleAxis.height)),
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
            ),
          ),
        ],
      ),
      onLoading: const Center(child: LoadingGnp()),
      onEmpty: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Text(
              msg.notProcedures.tr(),
              textAlign: TextAlign.start,
              style: Get.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: ColorPalette.textPrimary,
              ),
            ),
          ),
        ],
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
