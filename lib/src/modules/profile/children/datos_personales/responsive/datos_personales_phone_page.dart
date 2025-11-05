part of '../datos_personales_page.dart';

class _DatosPersonalesPhonePage extends StatelessWidget {
  _DatosPersonalesPhonePage();

  final DatosPersonalesController _c = Get.find<DatosPersonalesController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhone(title: esMessages.mx.personalData.value),
    body: Column(
      children: [
        SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
        BannerMedico(
          name: _c.user.nombreCompleto,
          medicalIdentifier: _c.user.codigoFiliacion,
        ),
        SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SectionTitle(title: esMessages.mx.myData.value),
                SizedBox(height: context.scale(15, axis: ScaleAxis.height)),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: esMessages.mx.name.value,
                    hintText: esMessages.mx.name.value,
                  ),
                  controller: _c.nameController,
                  validator: (value) => '',
                ),
                SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: esMessages.mx.birthdate.value,
                    hintText: esMessages.mx.birthdate.value,
                  ),
                  controller: _c.birthdateController,
                  validator: (value) => '',
                ),
                SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: esMessages.mx.gender.value,
                    hintText: esMessages.mx.gender.value,
                  ),
                  controller: _c.genderController,
                  validator: (value) => '',
                ),
                SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: esMessages.mx.phoneNumber.value,
                    hintText: esMessages.mx.phoneNumber.value,
                  ),
                  controller: _c.phoneNumberController,
                  validator: (value) => '',
                ),
                SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: esMessages.mx.email.value,
                    hintText: esMessages.mx.email.value,
                  ),
                  controller: _c.emailController,
                  validator: (value) => '',
                ),
                SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                TextFormField(
                  decoration: InputDecoration(
                    labelText:  esMessages.mx.medicalOffice.value,
                    hintText: esMessages.mx.medicalOffice.value,
                  ),
                  controller: _c.addresController,
                  validator: (value) => '',
                ),
                SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: esMessages.mx.nationality.value,
                    hintText:  esMessages.mx.nationality.value,
                  ),
                  controller: _c.nationalityController,
                  validator: (value) => '',
                ),
                SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
