part of '../personal_data_page.dart';

class _DatosPersonalesPhonePage extends StatelessWidget {
  _DatosPersonalesPhonePage();

  final DatosPersonalesController _c = Get.find<DatosPersonalesController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhone(title: msg.personalData.tr()),
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
                    decoration: InputDecoration(
                      labelText: msg.name.tr(),
                      hintText: msg.name.tr(),
                    ),
                    controller: _c.nameController,
                    validator: (value) => '',
                  ),
                  SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                  TextFormField(
                    readOnly: true,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: msg.birthdate.tr(),
                      hintText: msg.birthdate.tr(),
                    ),
                    controller: _c.birthdateController,
                    validator: (value) => '',
                  ),
                  SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                  TextFormField(
                    readOnly: true,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: msg.gender.tr(),
                      hintText: msg.gender.tr(),
                    ),
                    controller: _c.genderController,
                    validator: (value) => '',
                  ),
                  SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                  TextFormField(
                    enabled: false,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: msg.phoneNumber.tr(),
                      hintText: msg.phoneNumber.tr(),
                    ),
                    controller: _c.phoneNumberController,
                    validator: (value) => '',
                  ),
                  SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                  TextFormField(
                    readOnly: true,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: msg.email.tr(),
                      hintText: msg.email.tr(),
                    ),
                    controller: _c.emailController,
                    validator: (value) => '',
                  ),
                  SizedBox(height: context.scale(20, axis: ScaleAxis.height)),

                  TextFormField(
                    readOnly: true,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: msg.medicalOffice.tr(),
                      hintText: msg.medicalOffice.tr(),
                    ),
                    controller: _c.addresController,
                    validator: (value) => '',
                  ),
                  SizedBox(height: context.scale(20, axis: ScaleAxis.height)),

                  TextFormField(
                    readOnly: true,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: msg.nationality.tr(),
                      hintText: msg.nationality.tr(),
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
