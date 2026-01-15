part of '../personal_data_page.dart';

class DatosPersonalesDesktopPage extends StatelessWidget {
  DatosPersonalesDesktopPage({super.key});

  final DatosPersonalesController _c = Get.find<DatosPersonalesController>();

  Widget _field({
    required String label,
    required String hintText,
    required TextEditingController controller,
  }) => TextFormField(
    readOnly: true,
    enabled: false,
    decoration: InputDecoration(
      labelText: label,
      hintText: hintText,
    ),
    controller: controller,
    validator: (value) => '',
  );

  List<Widget> get fields => [
    _field(
      label: msg.name.tr(),
      hintText: msg.name.tr(),
      controller: _c.nameController,
    ),
    _field(
      label: msg.birthdate.tr(),
      hintText: msg.birthdate.tr(),
      controller: _c.birthdateController,
    ),
    _field(
      label: msg.gender.tr(),
      hintText: msg.gender.tr(),
      controller: _c.genderController,
    ),
    _field(
      label: msg.phoneNumber.tr(),
      hintText: msg.phoneNumber.tr(),
      controller: _c.phoneNumberController,
    ),
    _field(
      label: msg.email.tr(),
      hintText: msg.email.tr(),
      controller: _c.emailController,
    ),
    _field(
      label: msg.medicalOffice.tr(),
      hintText: msg.medicalOffice.tr(),
      controller: _c.addresController,
    ),
    _field(
      label: msg.nationality.tr(),
      hintText: msg.nationality.tr(),
      controller: _c.nationalityController,
    ),
  ];

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final int crossAxisCount = constraints.maxWidth > 650 ? 2 : 1;
          final double childAspectRatio = crossAxisCount == 2
              ? constraints.maxWidth * 0.0058
              : constraints.maxWidth * 0.01;
          return GridView.count(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: fields,
          );
        },
      ),
    ),
  );
}
