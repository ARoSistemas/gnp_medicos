part of '../annexes_page.dart';

class _AnnexesDesktopPage extends StatelessWidget {
  _AnnexesDesktopPage();

  final AnnexesController _c = Get.find<AnnexesController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarWeb(title: msg.annexes.tr()),
    body: _c.obx(
      (state) => SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.pWidth(10),
              vertical: context.pHeight(5),
            ),
            child: Wrap(
              spacing: 24,
              runSpacing: 24,
              children: [
                ...(state?.items ?? []).map(
                  (item) => CardFileDownload(
                    nombre: item.description.split('.').first,
                    image: _c.getNameImage(item.fileName),
                    onDownload: () => _c.downloadAnexo(item.fileName),
                    jwt: _c.appState.user.token.jwt,
                  ),
                ),
              ],
            ),
          ),
        ),
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
