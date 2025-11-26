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
              itemBuilder: (context, index) => GestureDetector(
                child: GestureDetector(
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (data?.benefitsList[index].nombre).value(), 
                                style: Get.textTheme.titleMedium
                              ),
                               Text(
                                (data?.benefitsList[index].leyenda).value(), 
                                style: Get.textTheme.bodyMedium
                              ),
                            ],
                          ),
                        ),
                        ImageFromWeb(
                          height: 200,
                          imageName: (data?.benefitsList[index].imagen).value(),
                          jwt: _c.appState.user.token.jwt,
                          path: '/beneficios/archivos',
                          width: double.infinity,
                        )
                      ],
                    ),
                  ),
                  onTap: () => _c.downloadBeneficio(data!.benefitsList[index]),
                ),
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
