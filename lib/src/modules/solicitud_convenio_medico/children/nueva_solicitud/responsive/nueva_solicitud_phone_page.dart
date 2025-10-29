part of '../nueva_solicitud_page.dart';

class _NuevaSolicitudPhonePage extends StatelessWidget {
  _NuevaSolicitudPhonePage();

  final NuevaSolicitudController _c = Get.find<NuevaSolicitudController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const AppBarPhone(title: 'Nueva solcitud'),
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 30),
                    child: TextFormField(
                      controller: _c.nameController,
                      decoration: InputDecoration(
                        hintText: 'Nombre(s)',
                        labelText: 'Nombre(s)',
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
                      validator: (v) => null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: TextFormField(
                      controller: _c.firstNameController,
                      decoration: InputDecoration(
                        hintText: 'Primer apellido',
                        labelText: 'Primer apellido',
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
                      validator: (v) => null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: TextFormField(
                      controller: _c.lastNameController,
                      decoration: InputDecoration(
                        hintText: 'Segundo apellido',
                        labelText: 'Segundo apellido',
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
                      validator: (v) => null,
                    ),
                  ),
                  TextFormField(
                    controller: _c.rfcController,
                    decoration: InputDecoration(
                      hintText: 'RFC',
                      labelText: 'RFC',
                      floatingLabelStyle: Get.textTheme.titleMedium?.copyWith(
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
                      'Con homoclave',
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
                        hintText: 'Correo electrónico',
                        labelText: 'Correo electrónico',
                        floatingLabelStyle: Get.textTheme.titleMedium?.copyWith(
                          color: ColorPalette.labelText,
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorPalette.backgroundCard,
                          ),
                        ),
                      ),
                      validator: Validators.validateEmail,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: TextFormField(
                      controller: _c.phoneNumberController,
                      decoration: InputDecoration(
                        hintText: 'Número celular',
                        labelText: 'Número celular',
                        floatingLabelStyle: Get.textTheme.titleMedium?.copyWith(
                          color: ColorPalette.labelText,
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorPalette.backgroundCard,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: Validators.validatePhone,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: DropdownButtonFormField(
                      // validator: Validators.validateOption,
                      hint: Text(
                        'Especialidad',
                        style: context.textTheme.titleMedium?.copyWith(
                          color: ColorPalette.labelText,
                        ),
                      ),
                      isExpanded: true,
                      onChanged: (value) {}, //_c.selectTypeAssistant,
                      items: const [] /* _c.typeAssistants
                              .map(
                                (type) => DropdownMenuItem(
                                  value: type.idTipoAsistente,
                                  child: Text(
                                    type.nombre,
                                    style: context.textTheme.titleMedium
                                        ?.copyWith(
                                          color: ColorPalette.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ),
                              )
                              .toList(), */,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: DropdownButtonFormField(
                      // validator: Validators.validateOption,
                      hint: Text(
                        'Subespecialidad',
                        style: context.textTheme.titleMedium?.copyWith(
                          color: ColorPalette.labelText,
                        ),
                      ),
                      isExpanded: true,
                      onChanged: (value) {}, //_c.selectTypeAssistant,
                      items: const [] /* _c.typeAssistants
                              .map(
                                (type) => DropdownMenuItem(
                                  value: type.idTipoAsistente,
                                  child: Text(
                                    type.nombre,
                                    style: context.textTheme.titleMedium
                                        ?.copyWith(
                                          color: ColorPalette.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ),
                              )
                              .toList(), */,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: DropdownButtonFormField(
                      // validator: Validators.validateOption,
                      hint: Text(
                        'Estado',
                        style: context.textTheme.titleMedium?.copyWith(
                          color: ColorPalette.labelText,
                        ),
                      ),
                      isExpanded: true,
                      onChanged: (value) {}, //_c.selectTypeAssistant,
                      items: const [] /* _c.typeAssistants
                              .map(
                                (type) => DropdownMenuItem(
                                  value: type.idTipoAsistente,
                                  child: Text(
                                    type.nombre,
                                    style: context.textTheme.titleMedium
                                        ?.copyWith(
                                          color: ColorPalette.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ),
                              )
                              .toList(), */,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: DropdownButtonFormField(
                      // validator: Validators.validateOption,
                      hint: Text(
                        'Hospitales de atención',
                        style: context.textTheme.titleMedium?.copyWith(
                          color: ColorPalette.labelText,
                        ),
                      ),
                      isExpanded: true,
                      onChanged: (value) {}, //_c.selectTypeAssistant,
                      items: const [] /* _c.typeAssistants
                              .map(
                                (type) => DropdownMenuItem(
                                  value: type.idTipoAsistente,
                                  child: Text(
                                    type.nombre,
                                    style: context.textTheme.titleMedium
                                        ?.copyWith(
                                          color: ColorPalette.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ),
                              )
                              .toList(), */,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: TextFormField(
                      controller: _c.officeAddressController,
                      decoration: InputDecoration(
                        hintText: 'Dirección de consultorio médico',
                        labelText: 'Dirección de consultorio médico',
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
                      validator: (v) => null,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
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
      ],
    ),
  );
}
