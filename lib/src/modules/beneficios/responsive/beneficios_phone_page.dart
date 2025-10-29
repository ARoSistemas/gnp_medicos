part of '../beneficios_page.dart';

class _BeneficiosPhonePage extends StatelessWidget {
  _BeneficiosPhonePage();

  final BeneficiosController _c = Get.find<BeneficiosController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhone(title: esMessages.mx.benefits.value),
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
              const CardBeneficios(
                image: 'assets/beneficio1.png',
                title: '{Beneficio}',
                description: '''
Lorem ipsum dolor sit amet consectetur. 
                    Vitae a quis elementum neque sodales aliquet amet.''',
              ),
              SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
              const CardBeneficios(
                image: 'assets/beneficio2.png',
                title: '{Beneficio}',
                description: '''
Lorem ipsum dolor sit amet consectetur. 
                    Vitae a quis elementum neque sodales aliquet amet.''',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class CardBeneficios extends StatelessWidget {
  const CardBeneficios({
    required this.image,
    required this.title,
    required this.description,
    super.key,
  });

  final String image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) => Card(
    color: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Get.textTheme.titleMedium),
              SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
              Text(
                description,
                style: Get.textTheme.titleMedium?.copyWith(
                  color: ColorPalette.textTertiary,
                ),
              ),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          child: Image.asset(
            image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
      ],
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('image', image))
      ..add(StringProperty('title', title))
      ..add(StringProperty('description', description));
  }
}
