part of '../nueva_solicitud_page.dart';

class _NuevaSolicitudPhonePage extends StatelessWidget {
  _NuevaSolicitudPhonePage();

  final NuevaSolicitudController _c = Get.find<NuevaSolicitudController>();
  @override
  Widget build(BuildContext context) {
    const colorTextReadOnly = TextStyle(color: ColorPalette.black);
    return Scaffold(
      appBar: AppBarPhone(title: msg.newRequest.value),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: BannerMedico(
              name: _c.user.nombreCompleto,
              medicalIdentifier: _c.user.codigoFiliacion,
            ),
          ),
          Expanded(
            child: _c.obx(
              (state) => SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Form(
                    key: _c.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 30),
                          child: TextFormField(
                            style: colorTextReadOnly,
                            controller: _c.nameController,
                            decoration: InputDecoration(
                              hintText: msg.name.value,
                              labelText: '${msg.name.value}(s)',
                              enabled: false,
                              floatingLabelStyle: Get.textTheme.titleMedium
                                  ?.copyWith(
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
                            validator: (v) => null,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: TextFormField(
                            style: colorTextReadOnly,
                            controller: _c.lastNameController,
                            decoration: InputDecoration(
                              hintText: msg.notLastName.value,
                              labelText: msg.notLastName.value,
                              floatingLabelStyle: Get.textTheme.titleMedium
                                  ?.copyWith(
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
                            enabled: false,
                            readOnly: true,
                            validator: (v) => null,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: TextFormField(
                            style: colorTextReadOnly,
                            controller: _c.lastNameController,
                            decoration: InputDecoration(
                              hintText: msg.notSecondLastName.value,
                              labelText: msg.notSecondLastName.value,
                              floatingLabelStyle: Get.textTheme.titleMedium
                                  ?.copyWith(
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
                            enabled: false,
                            readOnly: true,
                            validator: (v) => null,
                          ),
                        ),
                        TextFormField(
                          controller: _c.rfcController,
                          decoration: InputDecoration(
                            hintText: msg.rfc.value,
                            labelText: msg.rfc.value,
                            floatingLabelStyle: Get.textTheme.titleMedium
                                ?.copyWith(
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: _c.validaRfc,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 4,
                            left: 10,
                            bottom: 30,
                          ),
                          child: Text(
                            msg.withHomoclave.value,
                            style: Get.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: TextFormField(
                            controller: _c.emailController,
                            maxLength: 100,
                            decoration: InputDecoration(
                              counterText: '',
                              hintText: msg.email.value,
                              labelText: msg.email.value,
                              floatingLabelStyle: Get.textTheme.titleMedium
                                  ?.copyWith(
                                    color: ColorPalette.labelText,
                                  ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorPalette.backgroundCard,
                                ),
                              ),
                            ),
                            validator: Validators.email,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                RegExp(regexFilterEmail),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: TextFormField(
                            controller: _c.phoneNumberController,
                            maxLength: 10,
                            decoration: InputDecoration(
                              counterText: '',
                              hintText: msg.phoneNumber.value,
                              labelText: msg.phoneNumber.value,
                              floatingLabelStyle: Get.textTheme.titleMedium
                                  ?.copyWith(
                                    color: ColorPalette.labelText,
                                  ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorPalette.backgroundCard,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: Validators.phone,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Obx(
                            () => DropdownButtonFormField<String>(
                              initialValue: _c.selectedSpecialty.value,
                              focusColor: ColorPalette.white,
                              hint: Text(
                                msg.specialty.value,
                                style: context.textTheme.bodyLarge?.copyWith(
                                  color: ColorPalette.black,
                                ),
                              ),
                              isExpanded: true,
                              onChanged: _c.onSpecialtyChanged,
                              items: _c.state?.specialties
                                  .map(
                                    (type) => DropdownMenuItem(
                                      value: type.clave,
                                      child: Text(
                                        type.descripcion,
                                        style: context.textTheme.titleMedium
                                            ?.copyWith(
                                              color: ColorPalette.black,
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              validator: (value) {
                                if (value == null || value == '0') {
                                  return msg.pleaseSelectASpecialty.value;
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Obx(
                            () => DropdownButtonFormField<String>(
                              initialValue: _c.selectedSubSpecialty.value,
                              focusColor: ColorPalette.white,
                              hint: Text(
                                msg.subSpecialty.value,
                                style: context.textTheme.bodyLarge?.copyWith(
                                  color: ColorPalette.black,
                                ),
                              ),
                              isExpanded: true,
                              onChanged: _c.onSubSpecialtyChanged,
                              items: _c.state?.subSpecialties
                                  .map(
                                    (type) => DropdownMenuItem(
                                      value: type.clave,
                                      child: Text(
                                        type.descripcion,
                                        style: context.textTheme.titleMedium
                                            ?.copyWith(
                                              color: ColorPalette.labelText,
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              validator: (value) {
                                if (value == null || value == '0') {
                                  return msg.pleaseSelectASubspecialty.value;
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Obx(
                            () => DropdownButtonFormField<String>(
                              initialValue: _c.selectedState.value,
                              focusColor: ColorPalette.white,
                              hint: Text(
                                msg.state.value,
                                style: context.textTheme.bodyLarge?.copyWith(
                                  color: ColorPalette.black,
                                ),
                              ),
                              isExpanded: true,
                              onChanged: _c.onStateChanged,
                              items: _c.state?.states
                                  .map(
                                    (type) => DropdownMenuItem(
                                      value: type.cveEstado,
                                      child: Text(
                                        type.descripcion,
                                        style: context.textTheme.titleMedium
                                            ?.copyWith(
                                              color: ColorPalette.labelText,
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              validator: (value) {
                                if (value == null || value == '0') {
                                  return msg.pleaseSelectAState.value;
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Obx(
                            () => DropdownButtonFormField<String>(
                              isExpanded: true,
                              focusColor: Colors.white,
                              hint: Text(
                                _c.selectedHospitalNames.isEmpty
                                    ? msg.careHospitals.value
                                    : _c.selectedHospitalNames,
                                style: context.textTheme.bodyLarge?.copyWith(
                                  color: ColorPalette.black,
                                ),
                              ),
                              onChanged: (value) {},
                              items: _c.state?.hospitalAttention
                                  .map(
                                    (hospital) => DropdownMenuItem<String>(
                                      value: hospital.clave,
                                      enabled: false,
                                      child: StatefulBuilder(
                                        builder: (context, menuSetState) =>
                                            TitleSections(
                                              id: hospital.clave,
                                              title: hospital.descripcion,
                                              value: _c.selectedHospitals
                                                  .contains(
                                                    hospital.clave,
                                                  ),
                                              onChanged: (value) {
                                                _c.onHospitalSelectionChanged(
                                                  hospital.clave,
                                                  selected: value.value(),
                                                );
                                                menuSetState(() {});
                                              },
                                            ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              validator: (value) {
                                if (_c.selectedHospitals.isEmpty) {
                                  return msg
                                      .pleaseSelectAtLeastOneHospital
                                      .value;
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: TextFormField(
                            maxLength: 100,
                            controller: _c.officeAddressController,
                            decoration: InputDecoration(
                              counterText: '',
                              hintText: msg.medicalOfficeAddress.value,
                              labelText: msg.medicalOfficeAddress.value,
                              floatingLabelStyle: Get.textTheme.titleMedium
                                  ?.copyWith(
                                    color: ColorPalette.labelText,
                                  ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorPalette.backgroundCard,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return msg.pleaseEnterYourOfficeAddress.value;
                              }
                              return null;
                            },
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _c.newRequestAgreegament,
                          child: Text(msg.sendRequest.value),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 30),
                          child: TextButton(
                            onPressed: Get.back,
                            child: Text(msg.cancel.value),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
