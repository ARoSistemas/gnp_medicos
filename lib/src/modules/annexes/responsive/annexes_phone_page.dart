part of '../annexes_page.dart';

class _AnnexesPhonePage extends StatelessWidget {
  _AnnexesPhonePage();

  final AnnexesController _c = Get.find<AnnexesController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhoneWdgt(
      title: msg.annexes.tr(),
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
            child: ListView.builder(
              padding: EdgeInsets.only(
                bottom: context.scale(10, axis: ScaleAxis.height),
                left: 16,
                right: 16,
              ),
              itemCount: state?.items.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8),
                child: CardFileDownload(
                  nombre: state!.items[index].description.split('.').first,
                  image: _c.getNameImage(state.items[index].fileName),
                  onDownload: () =>
                      _c.downloadAnexo(state.items[index].fileName),
                  jwt: _c.appState.user.token.jwt,
                ),
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
            args: [msg.annexes.tr().toLowerCase()],
          ),
          subtitle: '',
        ),
      ),
      onError: (_) => Center(
        child: LoadingGnp(
          isError: true,
          title: msg.errorOccurred.tr(),
          subtitle: msg.couldNotRetrieveAnnexes.tr(),
        ),
      ),
    ),
  );
}
