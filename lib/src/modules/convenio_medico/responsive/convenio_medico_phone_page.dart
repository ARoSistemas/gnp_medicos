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
      appBar: AppBarPhone(title: esMessages.mx.agreement.value),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BannerMedico(
              name: _c.user.nombreCompleto,
              medicalIdentifier: _c.user.codigoFiliacion,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  SectionTitle(
                    title: esMessages.mx.agreement.value.toUpperCase(),
                    widget: GestureDetector(
                      onTap: () => _c.onView(FileTypesAgree.agreement),
                      child: Row(
                        children: [
                          Text(
                            esMessages.mx.view.value,
                            style: Get.textTheme.titleMedium?.copyWith(
                              color: ColorPalette.primary,
                              letterSpacing: 1.25,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.remove_red_eye_outlined,
                            color: ColorPalette.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: context.scale(15, axis: ScaleAxis.height)),
                  TextFormField(
                    controller: _c.emailController,
                    readOnly: true,
                    enabled: false,
                    style: styleInput,
                    decoration: InputDecoration(
                      labelText: esMessages.mx.email.value,
                      hintText: esMessages.mx.email.value,
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
                      hintText: esMessages.mx.rfc.value,
                      labelText: esMessages.mx.rfc.value,
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
                      esMessages.mx.withHomoclave.value,
                      style: Get.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: ColorPalette.labelText,
                      ),
                    ),
                  ),
                  SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
                  TextFormField(
                    controller: _c.doctorsNameController,
                    decoration: InputDecoration(
                      hintText: esMessages.mx.doctorsName.value,
                      labelText: esMessages.mx.doctorsName.value,
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
                      hintText: esMessages.mx.specialty.value,
                      labelText: esMessages.mx.specialty.value,
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
                      hintText: esMessages.mx.state.value,
                      labelText: esMessages.mx.state.value,
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
                      hintText: esMessages.mx.medicalCircle.value,
                      labelText: esMessages.mx.medicalCircle.value,
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
                      hintText: esMessages.mx.medicalTabulator.value,
                      labelText: esMessages.mx.medicalTabulator.value,
                      floatingLabelStyle: Get.textTheme.bodySmall?.copyWith(
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
                      hintText: esMessages.mx.status.value,
                      labelText: esMessages.mx.status.value,
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
                      esMessages.mx.consultGuidelines.value,
                    ),
                  ),
                  SizedBox(height: context.scale(15, axis: ScaleAxis.height)),
                  OutlinedButton(
                    onPressed: _c.updateAgreement,
                    child: Text(esMessages.mx.updateInformation.value),
                  ),
                  SizedBox(height: context.scale(15, axis: ScaleAxis.height)),
                  TextButton(
                    onPressed: _c.launcLowAgreement,
                    style: ButtonStyle(
                      textStyle: WidgetStateProperty.all(
                        Get.textTheme.titleMedium,
                      ),
                    ),
                    child: Text(esMessages.mx.terminationAgreement.value),
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
