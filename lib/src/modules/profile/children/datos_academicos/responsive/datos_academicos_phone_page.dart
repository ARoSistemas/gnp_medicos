part of '../datos_academicos_page.dart';

class _DatosAcademicosPhonePage extends StatelessWidget {
  _DatosAcademicosPhonePage();

  final DatosAcademicosController _c = Get.find<DatosAcademicosController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhone(title: esMessages.mx.academicData.value),
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
                  decoration: const InputDecoration(
                    labelText: 'Titulo Profesional',
                    hintText: 'Titulo Profesional',
                  ),
                  controller: _c.titleController,
                  validator: (value) => '',
                ),
                SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Número de cédula profesional',
                    hintText: 'Número de cédula profesional',
                  ),
                  controller: _c.idController,
                  validator: (value) => '',
                ),
                SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Especialidad',
                    hintText: 'Especialidad',
                  ),
                  controller: _c.specialtyController,
                  validator: (value) => '',
                ),
                SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Subespecialidad',
                    hintText: 'Subespecialidad',
                  ),
                  controller: _c.subSpecialtyController,
                  validator: (value) => '',
                ),
                SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Hospital de principal atención',
                    hintText: 'Hospital de principal atención',
                  ),
                  controller: _c.mainHospitalController,
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
