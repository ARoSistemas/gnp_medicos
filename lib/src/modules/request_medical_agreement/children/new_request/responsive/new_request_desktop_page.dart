part of '../new_request_page.dart';

class _NewRequestDesktopPage extends StatelessWidget {
  _NewRequestDesktopPage();

  final NewRequestController _c = Get.find<NewRequestController>();

  Widget _inputField({
    required TextEditingController controller,
    required String labelText,
    String? hintText,
    bool enabled = false,
  }) => TextFormField(
    style: const TextStyle(color: ColorPalette.black),
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText ?? labelText,
      labelText: labelText,
      enabled: enabled,
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
    readOnly: !enabled,
    validator: (v) => null,
  );
  
  Widget _buildFormGrid({
    required List<Widget> children,
    int crossAxisCount = 3,
    double crossAxisSpacing = 24,
    double mainAxisSpacing = 32,
  }) => LayoutBuilder(
    builder: (context, constraints) {
      final double itemWidth =
          (constraints.maxWidth - (crossAxisSpacing * (crossAxisCount - 1))) /
          crossAxisCount;

      return Wrap(
        spacing: crossAxisSpacing,
        runSpacing: mainAxisSpacing,
        children: children
            .map(
              (child) => SizedBox(
                width: itemWidth,
                child: child,
              ),
            )
            .toList(),
      );
    },
  );

  @override
  Widget build(BuildContext context)=> Scaffold(
      appBar: AppBarWeb(
        title: msg.newRequest.tr(),
        onBack: () => Get.back(result: false),
      ),
      body: _c.obx(
        (state) => SingleChildScrollView(
          padding: const EdgeInsets.all(40),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: ColorPalette.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Form(
                  key: _c.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Grid 1: Nombre, Primer apellido, Segundo apellido
                      _buildFormGrid(
                        children: [
                          _inputField(
                            controller: _c.nameController, 
                            labelText: '${msg.name.tr()}(s)',
                            hintText: msg.name.tr()
                          ),
                          _inputField(
                            controller: _c.lastNameController,
                            labelText: msg.notLastName.tr()
                          ),
                          _inputField(
                            controller: _c.secondLastNameController,
                            labelText: msg.notSecondLastName.tr()
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                autovalidateMode: 
                                  AutovalidateMode.onUserInteraction,
                                validator: _c.validaRfc,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 4,
                                  left: 10,
                                ),
                                child: Text(
                                  msg.withHomoclave.tr(),
                                  style: Get.textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TextFormField(
                            controller: _c.emailController,
                            maxLength: 100,
                            decoration: InputDecoration(
                              counterText: '',
                              hintText: msg.email.tr(),
                              labelText: msg.email.tr()
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
                          TextFormField(
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
                          Obx(
                            () => DropdownButtonFormField<String>(
                              initialValue: _c.selectedSpecialty.value,
                              focusColor: ColorPalette.white,
                              decoration: InputDecoration(
                                labelText: msg.specialty.tr(),
                                floatingLabelBehavior: FloatingLabelBehavior
                                .auto,
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
                          Obx(
                            () => DropdownButtonFormField<String>(
                              initialValue: _c.selectedSubSpecialty.value,
                              focusColor: ColorPalette.white,
                              decoration: InputDecoration(
                                labelText: msg.subSpecialty.tr(),
                                floatingLabelBehavior: FloatingLabelBehavior
                                .auto,
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
                          Obx(
                            () => DropdownButtonFormField<String>(
                              initialValue: _c.selectedState.value,
                              focusColor: ColorPalette.white,
                              decoration: InputDecoration(
                                labelText: msg.state.tr(),
                                floatingLabelBehavior: FloatingLabelBehavior
                                .auto,
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
                          Obx(
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
                                  return msg.pleaseSelectAtLeastOneHospital
                                      .tr();
                                }
                                return null;
                              },
                            ),
                          ),
                          TextFormField(
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
                        ],
                      ),
                      const SizedBox(height: 48),

                      // Button
                      ElevatedButton(
                        onPressed: _c.newRequestAgreegament,
                        style: Get.theme.elevatedButtonTheme.style?.copyWith(
                          minimumSize: WidgetStateProperty.all(
                            const Size(0, 48),
                          ),
                        ),
                        child: Text(msg.sendRequest.tr()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        onLoading: const Center(child: LoadingGnp()),
        onEmpty: Center(
          child: LoadingGnp(
            icon: const Icon(
              Icons.error,
              size: 70,
              color: ColorPalette.primary,
            ),
            title: msg.noDataAvailable.tr(
              args: [msg.annexes.tr().toLowerCase()],
            ),
            subtitle: '',
          ),
        ),
      ),
    );
}
