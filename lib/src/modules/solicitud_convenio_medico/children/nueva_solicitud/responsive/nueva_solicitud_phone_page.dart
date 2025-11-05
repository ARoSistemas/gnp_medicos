part of '../nueva_solicitud_page.dart';

class _NuevaSolicitudPhonePage extends StatelessWidget {
  _NuevaSolicitudPhonePage();

  final NuevaSolicitudController _c = Get.find<NuevaSolicitudController>();

  @override
  Widget build(BuildContext context) {
    const colorTextReadOnly = TextStyle(color: ColorPalette.black);
    return Scaffold(
      appBar: const AppBarPhone(title: 'Nueva solicitud'),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 30),
                        child: TextFormField(
                          style: colorTextReadOnly,
                          controller: _c.nameController,
                          decoration: InputDecoration(
                            hintText: esMessages.mx.name.value,
                            labelText: '${esMessages.mx.name.value}(s)',
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
                            hintText: 'Primer apellido',
                            labelText: 'Primer apellido',
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
                            hintText: 'Segundo apellido',
                            labelText: 'Segundo apellido',
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
                          enabled: false,
                          readOnly: true,
                          validator: (v) => null,
                        ),
                      ),
                      TextFormField(
                        controller: _c.rfcController,
                        decoration: InputDecoration(
                          hintText: esMessages.mx.rfc.value,
                          labelText: esMessages.mx.rfc.value,
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
                        validator: _c.validaRfc,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 4,
                          left: 10,
                          bottom: 30,
                        ),
                        child: Text(
                          esMessages.mx.withHomoclave.value,
                          style: Get.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: TextFormField(
                          controller: _c.emailController,
                          decoration: InputDecoration(
                            hintText: esMessages.mx.email.value,
                            labelText: esMessages.mx.email.value,
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
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: TextFormField(
                          controller: _c.phoneNumberController,
                          decoration: InputDecoration(
                            hintText: esMessages.mx.phoneNumber.value,
                            labelText: esMessages.mx.phoneNumber.value,
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
                          validator: Validators.phone,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Obx(
                          () => DropdownButtonFormField<String>(
                            initialValue: _c.selectedSpecialty.value,
                            focusColor: ColorPalette.white,
                            hint: Text(
                              esMessages.mx.specialty.value,
                              style: context.textTheme.titleMedium?.copyWith(
                                color: ColorPalette.labelText,
                              ),
                            ),
                            isExpanded: true,
                            onChanged: _c.onSpecialtyChanged,
                            items: state!.specialties
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
                            initialValue: _c.selectedSubSpecialty.value,
                            focusColor: ColorPalette.white,
                            hint: Text(
                              esMessages.mx.subSpecialty.value,
                              style: context.textTheme.titleMedium?.copyWith(
                                color: ColorPalette.labelText,
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
                              'Estado',
                              style: context.textTheme.titleMedium?.copyWith(
                                color: ColorPalette.labelText,
                                fontWeight: FontWeight.w400,
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
                                  ? 'Hospitales de atención'
                                  : _c.selectedHospitalNames,
                              style: context.textTheme.titleMedium?.copyWith(
                                color: ColorPalette.labelText,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            onChanged: (value) {},
                            items: state?.hospitalAttention
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
                                                selected: value!,
                                              );
                                              menuSetState(() {});
                                            },
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
                        child: TextFormField(
                          controller: _c.officeAddressController,
                          decoration: InputDecoration(
                            hintText: 'Dirección de consultorio médico',
                            labelText: 'Dirección de consultorio médico',
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
                          validator: (v) => null,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _c.newRequestAgreegament,
                        child: const Text('Enviar solicitud'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 30),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('Cancelar'),
                        ),
                      ),
                    ],
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
