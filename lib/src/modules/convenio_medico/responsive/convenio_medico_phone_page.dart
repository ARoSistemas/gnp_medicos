part of '../convenio_medico_page.dart';

class _ConvenioMedicoPhonePage extends StatelessWidget {
  _ConvenioMedicoPhonePage();

  final ConvenioMedicoController _c = Get.find<ConvenioMedicoController>();

  @override
  Widget build(BuildContext context) {
    const styleInput = TextStyle(
      color: Color.fromARGB(255, 19, 17, 17),
    );

    return Scaffold(
      appBar: AppBarPhone(title: msg.agreement.tr()),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BannerMedico(
              name: _c.user.nombreCompleto,
              lastname: _c.user.apePaterno,
              rfc: _c.user.rfc,
              jwt: _c.user.token.jwt,
              medicalIdentifier: _c.user.codigoFiliacion,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  SectionTitle(
                    title: msg.agreement.tr().toUpperCase(),
                    widget: TextButton(
                      style: Get.theme.textButtonTheme.style?.copyWith(
                        minimumSize: WidgetStateProperty.all(const Size(0, 48)),
                      ),
                      child: Row(
                        spacing: 8,
                        children: [
                          Text(
                            msg.view.tr(),
                            style: Get.textTheme.titleMedium?.copyWith(
                              color: ColorPalette.primary,
                              letterSpacing: 1.25,
                            ),
                          ),
                          const Icon(
                            Icons.remove_red_eye_outlined,
                            color: ColorPalette.primary,
                          ),
                        ],
                      ),
                      onPressed: () => _c.onView(FileTypesAgree.agreement),
                    ),
                  ),
                  SizedBox(height: context.scale(15, axis: ScaleAxis.height)),
                  TextFormField(
                    controller: _c.emailController,
                    readOnly: true,
                    enabled: false,
                    style: styleInput,
                    decoration: InputDecoration(
                      labelText: msg.email.tr(),
                      hintText: msg.email.tr(),
                      floatingLabelStyle: Get.textTheme.titleMedium?.copyWith(
                        color: ColorPalette.labelText,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorPalette.backgroundCard,
                        ),
                      ),
                    ),
                    validator: (v) => null,
                  ),
                  SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
                  TextFormField(
                    controller: _c.rfcController,
                    decoration: InputDecoration(
                      hintText: msg.rfc.tr(),
                      labelText: msg.rfc.tr(),
                      floatingLabelStyle: Get.textTheme.titleMedium?.copyWith(
                        color: ColorPalette.labelText,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorPalette.backgroundCard,
                        ),
                      ),
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                        RegExp(regexAlphanumeric, unicode: true),
                      ),
                    ],
                    readOnly: true,
                    enabled: false,
                    style: styleInput,
                    validator: (v) => null,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 10),
                    child: Text(
                      msg.withHomoclave.tr(),
                      style: Get.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: ColorPalette.textSecondary,
                      ),
                    ),
                  ),
                  SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
                  TextFormField(
                    controller: _c.doctorsNameController,
                    decoration: InputDecoration(
                      hintText: msg.doctorsName.tr(),
                      labelText: msg.doctorsName.tr(),
                      floatingLabelStyle: Get.textTheme.titleMedium?.copyWith(
                        color: ColorPalette.labelText,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorPalette.backgroundCard,
                        ),
                      ),
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                        RegExp(regexNamesChar, unicode: true),
                      ),
                    ],
                    readOnly: true,
                    enabled: false,
                    style: styleInput,
                    validator: (v) => null,
                  ),
                  SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
                  TextFormField(
                    controller: _c.specialtyController,
                    decoration: InputDecoration(
                      hintText: msg.specialty.tr(),
                      labelText: msg.specialty.tr(),
                      floatingLabelStyle: Get.textTheme.titleMedium?.copyWith(
                        color: ColorPalette.labelText,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorPalette.backgroundCard,
                        ),
                      ),
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                        RegExp(regexNamesChar, unicode: true),
                      ),
                    ],
                    readOnly: true,
                    enabled: false,
                    style: styleInput,
                    validator: (v) => null,
                  ),
                  SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
                  TextFormField(
                    controller: _c.stateController,
                    decoration: InputDecoration(
                      hintText: msg.state.tr(),
                      labelText: msg.state.tr(),
                      floatingLabelStyle: Get.textTheme.titleMedium?.copyWith(
                        color: ColorPalette.labelText,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorPalette.backgroundCard,
                        ),
                      ),
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                        RegExp(regexNamesChar, unicode: true),
                      ),
                    ],
                    readOnly: true,
                    enabled: false,
                    style: styleInput,
                    validator: (v) => null,
                  ),
                  SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
                  TextFormField(
                    controller: _c.medicalCircleController,
                    decoration: InputDecoration(
                      hintText: msg.medicalCircle.tr(),
                      labelText: msg.medicalCircle.tr(),
                      floatingLabelStyle: Get.textTheme.titleMedium?.copyWith(
                        color: ColorPalette.labelText,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorPalette.backgroundCard,
                        ),
                      ),
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                        RegExp(regexNamesChar, unicode: true),
                      ),
                    ],
                    readOnly: true,
                    enabled: false,
                    style: styleInput,
                    validator: (v) => null,
                  ),
                  SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
                  TextFormField(
                    controller: _c.medicalChartController,
                    decoration: InputDecoration(
                      hintText: msg.medicalTabulator.tr(),
                      labelText: msg.medicalTabulator.tr(),
                      floatingLabelStyle: Get.textTheme.titleMedium?.copyWith(
                        color: ColorPalette.labelText,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorPalette.backgroundCard,
                        ),
                      ),
                    ),
                    readOnly: true,
                    enabled: false,
                    style: styleInput,
                    validator: (v) => null,
                  ),
                  SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
                  TextFormField(
                    controller: _c.statusController,
                    decoration: InputDecoration(
                      hintText: msg.status.tr(),
                      labelText: msg.status.tr(),
                      floatingLabelStyle: Get.textTheme.titleMedium?.copyWith(
                        color: ColorPalette.labelText,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorPalette.backgroundCard,
                        ),
                      ),
                    ),
                    readOnly: true,
                    enabled: false,
                    style: styleInput,
                    validator: (v) => null,
                  ),
                  SizedBox(height: context.scale(30, axis: ScaleAxis.height)),
                  ElevatedButton(
                    onPressed: () => _c.onView(FileTypesAgree.guidelines),
                    child: Text(
                      msg.consultGuidelines.tr(),
                    ),
                  ),
                  SizedBox(height: context.scale(15, axis: ScaleAxis.height)),
                  OutlinedButton(
                    onPressed: _c.updateAgreement,
                    child: Text(msg.updateInformation.tr()),
                  ),
                  SizedBox(height: context.scale(15, axis: ScaleAxis.height)),
                  TextButton(
                    onPressed: _c.launcLowAgreement,
                    style: ButtonStyle(
                      textStyle: WidgetStateProperty.all(
                        Get.textTheme.titleMedium,
                      ),
                    ),
                    child: Text(msg.terminationAgreement.tr()),
                  ),
                  SizedBox(height: context.scale(30, axis: ScaleAxis.height)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
