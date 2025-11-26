part of '../formats_page.dart';

class _FormatsPhonePage extends StatelessWidget {
  _FormatsPhonePage();

  final FormatsController _c = Get.find<FormatsController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhoneWdgt(
      title: msg.formats.value,
      name: _c.user.nombreCompleto,
      medicalIdentifier: _c.user.codigoFiliacion,
    ),
    body: _c.obx(
       (data) => Column(
        children: <Widget>[
          SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(
                bottom: context.scale(10, axis: ScaleAxis.height),
                left: 16,
                right: 16,
              ),
              itemCount: data?.formatsList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8),
                child: CardFileDownload(
                  nombre: data!.formatsList[index].description.split('.').first,
                  onDownload: () => 
                  _c.downloadFormato(data.formatsList[index].fileName),
                ),
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
