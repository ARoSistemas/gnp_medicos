part of '../benefits_page.dart';

class _BeneficiosPhonePage extends StatelessWidget {
  _BeneficiosPhonePage();

  final BeneficiosController _c = Get.find<BeneficiosController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhone(title: esMessages.mx.benefits.value),
    body: _c.obx(
      (data) => Column(
        children: <Widget>[
          BannerMedico(
            name: _c.user.nombreCompleto,
            medicalIdentifier: _c.user.codigoFiliacion,
          ),
          SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: data?.benefitsList.length,
              itemBuilder: (context, index) => CardFileDownload(
                  nombre: data!.benefitsList[index].fileName,
                  onDownload: () => 
                  _c.downloadBeneficio(data.benefitsList[index]),
                )
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
