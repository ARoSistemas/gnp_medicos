part of '../benefits_page.dart';

class _BeneficiosPhonePage extends StatelessWidget {
  _BeneficiosPhonePage();

  final BeneficiosController _c = Get.find<BeneficiosController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhoneWdgt(
      title: msg.benefits.tr(),
      name: _c.user.nombreCompleto,
      lastname: _c.user.apePaterno,
      rfc: _c.user.rfc,
      jwt: _c.user.token.jwt,
      medicalIdentifier: _c.user.codigoFiliacion,
    ),
    body: _c.obx(
      (state) => Column(
        children: <Widget>[
          SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: (state?.benefitsList.length).value(),
              itemBuilder: (context, index) => CardBenefit(
                title: state?.benefitsList[index].nombre,
                description: state?.benefitsList[index].leyenda,
                image: state?.benefitsList[index].imagen,
                onTap: () => _c.downloadBeneficio(state!.benefitsList[index]),
                jwt: _c.appState.user.token.jwt,
              ),
            ),
          ),
        ],
      ),
      onLoading: const Center(child: LoadingGnp()),
      onEmpty: Center(
        child: LoadingGnp(
          icon: const Icon(
            Icons.error,
            size: 70,
            color: ColorPalette.primary,
          ),
          title: msg.noDataAvailable.tr(
            args: [msg.benefits.tr().toLowerCase()],
          ),
          subtitle: '',
        ),
      ),
      onError: (_) => Center(
        child: LoadingGnp(
          isError: true,
          title: msg.errorOccurred.tr(),
          subtitle: msg.couldNotRetrieveBenefits.tr(),
        ),
      ),
    ),
  );
}
