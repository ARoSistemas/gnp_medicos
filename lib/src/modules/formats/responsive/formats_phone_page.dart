part of '../formats_page.dart';

class _FormatsPhonePage extends StatelessWidget {
  _FormatsPhonePage();

  final FormatsController _c = Get.find<FormatsController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhoneWdgt(
      title: msg.formats.tr(),
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
              itemCount: state?.formatsList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8),
                child: CardFileDownload(
                  nombre: state!.formatsList[index].description
                      .split('.')
                      .first,
                  image: _c.getNameImage(state.formatsList[index].fileName),
                  onDownload: () =>
                      _c.downloadFormato(state.formatsList[index].fileName),
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
            args: [msg.formats.tr().toLowerCase()],
          ),
          subtitle: '',
        ),
      ),
      onError: (_) => Center(
        child: LoadingGnp(
          isError: true,
          title: msg.errorOccurred.tr(),
          subtitle: msg.couldNotRetrieveFormats.tr(),
        ),
      ),
    ),
  );
}
