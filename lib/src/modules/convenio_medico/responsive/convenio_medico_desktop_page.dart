part of '../convenio_medico_page.dart';

class _ConvenioMedicoDesktopPage extends StatelessWidget {
  _ConvenioMedicoDesktopPage();

  final ConvenioMedicoController _c = Get.find<ConvenioMedicoController>();

  @override
  Widget build(BuildContext context) {
    const styleInput = TextStyle(
      color: Color.fromARGB(255, 19, 17, 17),
    );

    return Scaffold(
      appBar: AppBarWeb(title: esMessages.mx.agreement.value),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.pWidth(10),
          vertical: context.pHeight(5)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SectionTitle(
              title: 'mis datos'.toUpperCase(),
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
            GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              childAspectRatio: 5,
              physics: const NeverScrollableScrollPhysics(),
              children: [
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                  ],
                ),
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
              ],
            ),
            SizedBox(height: context.scale(15, axis: ScaleAxis.height)),
            Row(
              spacing: 16,
              children: [
                ElevatedButton(
                  onPressed: () => _c.onView(FileTypesAgree.guidelines),
                  style: Get.theme.elevatedButtonTheme.style?.copyWith(
                    minimumSize: WidgetStateProperty.all(const Size(0, 48)),
                  ),
                  child: Text(
                    esMessages.mx.consultGuidelines.value,
                  ),
                ),
                OutlinedButton(
                  onPressed: _c.updateAgreement,
                  style: Get.theme.outlinedButtonTheme.style?.copyWith(
                    minimumSize: WidgetStateProperty.all(const Size(0, 48)),
                  ),
                  child: Text(esMessages.mx.updateInformation.value),
                ),
                TextButton(
                  onPressed: _c.launcLowAgreement,
                  style: Get.theme.textButtonTheme.style?.copyWith(
                    minimumSize:WidgetStateProperty.all(const Size(0, 48)),
                  ),
                  child: Text(esMessages.mx.terminationAgreement.value),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
