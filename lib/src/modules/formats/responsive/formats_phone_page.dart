part of '../formats_page.dart';

class _FormatsPhonePage extends StatelessWidget {
  _FormatsPhonePage();

  final FormatsController _c = Get.find<FormatsController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhone(
      title: esMessages.mx.formats.value,
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
              CardFormats(title: esMessages.mx.medicalReport.value),
              SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
              CardFormats(
                title: esMessages.mx.transplantOrthopedicsFormat.value,
              ),
              SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
              CardFormats(title: esMessages.mx.transferFormat.value),
              SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
              CardFormats(title: esMessages.mx.accessionLetter.value),
            ],
          ),
        ),
      ],
    ),
  );
}

class CardFormats extends StatelessWidget {
  const CardFormats({required this.title, super.key});
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
