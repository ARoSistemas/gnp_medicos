part of '../formats_page.dart';

class _FormatsPhonePage extends StatelessWidget {
  _FormatsPhonePage();

  final FormatsController _c = Get.find<FormatsController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhone(
      title: esMessages.mx.formats.value,
    ),
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
              itemCount: data?.formatsList.length,
              itemBuilder: (context, index) => CardFileDownload(
                nombre: data!.formatsList[index].fileName,
                onDownload: () => 
                _c.downloadFormato(data.formatsList[index].fileName),
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
          title: 'Sin formatos disponibles',
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
          subtitle: 'No fue posible recuperar los formatos',
        ),
      ),
      onLoading: const Center(child: LoadingGnp()),
    ),
  );
}
