part of '../anexos_page.dart';

class _AnexosPhonePage extends StatelessWidget {
  _AnexosPhonePage();

  final AnexosController _c = Get.find<AnexosController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhoneWdgt(
      title: msg.annexes.value,
      name: _c.user.nombreCompleto,
      medicalIdentifier: _c.user.codigoFiliacion,
    ),
    body: _c.obx(
      (state) => Column(
        children: [
          SizedBox(height: context.scale(20, axis: ScaleAxis.height)),

          /// Annexes List
          ...state!.items.map(
            (item) => Padding(
              padding: EdgeInsets.only(
                bottom: context.scale(10, axis: ScaleAxis.height),
                left: 16,
                right: 16,
              ),
              child: CardFileDownload(
                nombre: item.description.split('.').first,
                onDownload: () => _c.downloadAnexo(item.fileName),
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
          title: msg.noAnnexesAvailable.value,
          subtitle: '',
        ),
      ),
      onError: (_) => Center(
        child: LoadingGnp(
          icon: const Icon(
            Icons.error,
            size: 70,
            color: ColorPalette.primary,
          ),
          title: msg.errorOccurred.value,
          subtitle: msg.couldNotRetrieveAnnexes.value,
        ),
      ),
    ),
  );
}
