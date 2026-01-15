part of '../academic_data_page.dart';

class DatosAcademicosDesktopPage extends StatelessWidget {
  DatosAcademicosDesktopPage({super.key});

  final DatosAcademicosController _c = Get.find<DatosAcademicosController>();

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
      label: 'Titulo Profesional',
      hintText: 'Titulo Profesional',
      controller: _c.titleCtrler,
    ),
    _field(
      label: 'Número de cédula profesional',
      hintText: 'Número de cédula profesional',
      controller: _c.cedulaCtrler,
    ),
    _field(
      label: 'Especialidad',
      hintText: 'Especialidad',
      controller: _c.specialtyCtrler,
    ),
    _field(
      label: 'Subespecialidad',
      hintText: 'Subespecialidad',
      controller: _c.subSpecialtyCtrler
    ),
    _field(
      label: 'Hospital de principal atención',
      hintText: 'Hospital de principal atención',
      controller: _c.mainHospitalCtrler
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
