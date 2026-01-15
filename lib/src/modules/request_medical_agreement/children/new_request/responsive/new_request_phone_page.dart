part of '../new_request_page.dart';

class _NewRequestPhonePage extends StatelessWidget {
  _NewRequestPhonePage();

  final NewRequestController _c = Get.find<NewRequestController>();
  @override
  Widget build(BuildContext context) {
    const colorTextReadOnly = TextStyle(color: ColorPalette.black);
    return Scaffold(
      appBar: AppBarPhone(title: msg.newRequest.tr()),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: BannerMedico(
              name: _c.user.nombreCompleto,
              lastname: _c.user.apePaterno,
              rfc: _c.user.rfc,
              jwt: _c.user.token.jwt,
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
                              hintText: msg.name.tr(),
                              labelText: '${msg.name.tr()}(s)',
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
                              hintText: msg.notLastName.tr(),
                              labelText: msg.notLastName.tr(),
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
                            controller: _c.secondLastNameController,
                            decoration: InputDecoration(
                              hintText: msg.notSecondLastName.tr(),
                              labelText: msg.notSecondLastName.tr(),
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
                            hintText: msg.rfc.tr(),
                            labelText: msg.rfc.tr(),
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
                            msg.withHomoclave.tr(),
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
                              hintText: msg.email.tr(),
                              labelText: msg.email.tr(),
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
                              hintText: msg.phoneNumber.tr(),
                              labelText: msg.phoneNumber.tr(),
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
                              decoration: InputDecoration(
                                labelText: msg.specialty.tr(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
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
                                  return msg.pleaseSelectASpecialty.tr();
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
                              decoration: InputDecoration(
                                labelText: msg.subSpecialty.tr(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
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
                                              color: ColorPalette.black,
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Obx(
                            () => DropdownButtonFormField<String>(
                              initialValue: _c.selectedState.value,
                              focusColor: ColorPalette.white,
                              decoration: InputDecoration(
                                labelText: msg.state.tr(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
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
                                              color: ColorPalette.black,
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              validator: (value) {
                                if (value == null || value == '0') {
                                  return msg.pleaseSelectAState.tr();
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
                              decoration: InputDecoration(
                                labelText: msg.careHospitals.tr(),
                                floatingLabelBehavior: FloatingLabelBehavior
                                .auto,
                              ),
                              hint: _c.selectedHospitalNames.isEmpty ? null : 
                              Text(
                                _c.selectedHospitalNames,
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
                              hintText: msg.medicalOfficeAddress.tr(),
                              labelText: msg.medicalOfficeAddress.tr(),
                            ),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                RegExp(regexDirectionChar, unicode: true),
                              ),
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return msg.pleaseEnterYourOfficeAddress.tr();
                              }
                              return null;
                            },
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _c.newRequestAgreegament,
                          child: Text(msg.sendRequest.tr()),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 30),
                          child: TextButton(
                            onPressed: Get.back,
                            child: Text(msg.cancel.tr()),
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
