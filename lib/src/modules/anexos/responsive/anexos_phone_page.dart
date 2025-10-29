part of '../anexos_page.dart';

class _AnexosPhonePage extends StatelessWidget {
  _AnexosPhonePage();

  final AnexosController _c = Get.find<AnexosController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhone(
      title: esMessages.mx.annexes.value,
    ),
    body: Column(
      children: <Widget>[
        BannerMedico(
          name: _c.user.nombreCompleto,
          medicalIdentifier: _c.user.codigoFiliacion,
        ),
        SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              CardAnexo(title: esMessages.mx.medicalReport.value),
              SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
              CardAnexo(title: esMessages.mx.paymentManual.value),
              SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
              CardAnexo(title: esMessages.mx.glossaryTerms.value),
              SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
              CardAnexo(title: esMessages.mx.levelsAndTabs.value),
            ],
          ),
        ),
      ],
    ),
  );
}

class CardAnexo extends StatelessWidget {
  const CardAnexo({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: ColorPalette.borderCardFormat),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Get.textTheme.titleMedium),
        const Icon(
          Icons.download_outlined,
          color: ColorPalette.primary,
        ),
      ],
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('title', title));
  }
}
