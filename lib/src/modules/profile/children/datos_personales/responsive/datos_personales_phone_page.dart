part of '../datos_personales_page.dart';

class _DatosPersonalesPhonePage extends StatelessWidget {
  _DatosPersonalesPhonePage();

  final DatosPersonalesController _c = Get.find<DatosPersonalesController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const AppBarPhone(title: 'Datos personales'),
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
                const SectionTitle(title: 'MIS DATOS'),
                SizedBox(height: context.scale(15, axis: ScaleAxis.height)),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    hintText: 'Nombre',
                  ),
                  controller: _c.nameController,
                  validator: (value) => '',
                ),
                SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Fecha de nacimiento',
                    hintText: 'Fecha de nacimiento',
                  ),
                  controller: _c.birthdateController,
                  validator: (value) => '',
                ),
                SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Género',
                    hintText: 'Género',
                  ),
                  controller: _c.genderController,
                  validator: (value) => '',
                ),
                SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Número de teléfono',
                    hintText: 'Número de teléfono',
                  ),
                  controller: _c.phoneNumberController,
                  validator: (value) => '',
                ),
                SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    hintText: 'Correo electrónico',
                  ),
                  controller: _c.emailController,
                  validator: (value) => '',
                ),
                SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Dirección de Consultorio',
                    hintText: 'Dirección de Consultorio',
                  ),
                  controller: _c.addresController,
                  validator: (value) => '',
                ),
                SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nacionalidad',
                    hintText: 'Nacionalidad',
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
