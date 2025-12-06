part of '../benefits_page.dart';

class _BeneficiosPhonePage extends StatelessWidget {
  _BeneficiosPhonePage();

  final BeneficiosController _c = Get.find<BeneficiosController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhoneWdgt(
      title: msg.benefits.value,
      name: _c.user.nombreCompleto,
      medicalIdentifier: _c.user.codigoFiliacion,
    ),
    body: _c.obx(
      (data) => Column(
        children: <Widget>[
          SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: (data?.benefitsList.length).value(),
              itemBuilder: (context, index) => CardBenefit(
                title: data?.benefitsList[index].nombre,
                description: data?.benefitsList[index].leyenda,
                image: data?.benefitsList[index].imagen,
                onTap: () => _c.downloadBeneficio(data!.benefitsList[index]),
                jwt: _c.appState.user.token.jwt
              ),
            ),
          ),
        ],
      ),
      onEmpty: const Center(
        child: LoadingGnp(
          icon: Icon(
            Icons.error,
            size: 70,
            color: ColorPalette.primary,
          ),
          title: 'Sin beneficios disponibles',
          subtitle: '',
        ),
      ),
      onError: (_) => const Center(
        child: LoadingGnp(
          icon: Icon(
            Icons.error,
            size: 70,
            color: ColorPalette.primary,
          ),
          title: 'Ocurrió un error',
          subtitle: 'No fue posible recuperar los beneficios',
        ),
      ),
      onLoading: const Center(child: LoadingGnp()),
    ),
  );
}
