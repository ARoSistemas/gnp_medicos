part of '../academic_data_page.dart';

class _DatosAcademicosPhonePage extends StatelessWidget {
  _DatosAcademicosPhonePage();

  final DatosAcademicosController _c = Get.find<DatosAcademicosController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhone(title: msg.academicData.tr()),
    body: _c.obx(
      (state) => Column(
        children: [
          SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
          BannerMedico(
            name: _c.user.nombreCompleto,
            lastname: _c.user.apePaterno,
            rfc: _c.user.rfc,
            jwt: _c.user.token.jwt,
            medicalIdentifier: _c.user.codigoFiliacion,
          ),
          SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SectionTitle(title: msg.myData.tr().toUpperCase()),
                  SizedBox(height: context.scale(15, axis: ScaleAxis.height)),
                  TextFormField(
                    readOnly: true,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Titulo Profesional',
                      hintText: 'Titulo Profesional',
                    ),
                    controller: _c.titleCtrler,
                    validator: (value) => '',
                  ),
                  SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                  TextFormField(
                    readOnly: true,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Número de cédula profesional',
                      hintText: 'Número de cédula profesional',
                    ),
                    controller: _c.cedulaCtrler,
                    validator: (value) => '',
                  ),
                  SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                  TextFormField(
                    readOnly: true,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Especialidad',
                      hintText: 'Especialidad',
                    ),
                    controller: _c.specialtyCtrler,
                    validator: (value) => '',
                  ),
                  SizedBox(height:
                    context.scale(20, axis: ScaleAxis.height)),
                  TextFormField(
                    readOnly: true,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Subespecialidad',
                      hintText: 'Subespecialidad',
                    ),
                    controller: _c.subSpecialtyCtrler,
                    validator: (value) => '',
                  ),
                  SizedBox(height:
                   context.scale(20, axis: ScaleAxis.height)),
                  TextFormField(
                    readOnly: true,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Hospital de principal atención',
                      hintText: 'Hospital de principal atención',
                    ),
                    controller: _c.mainHospitalCtrler,
                    validator: (value) => '',
                  ),
                  SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                ],
              ),
            ),
          ),
        ],
      ),
      onLoading: const Center(child: LoadingGnp()),
      onEmpty: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Text(
              msg.notProcedures.tr(),
              textAlign: TextAlign.start,
              style: Get.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: ColorPalette.textPrimary,
              ),
            ),
          ),
        ],
      ),
      onError: (_) => Center(
        child: LoadingGnp(
          isError: true,
          title: msg.errorLoadingInfo.tr(),
          subtitle: msg.pleaseTryAgainLater.tr(),
        ),
      ),
    ),
  );
}
