part of '../anexos_page.dart';

class _AnexosDesktopPage extends StatelessWidget {
  _AnexosDesktopPage();

  final AnexosController _c = Get.find<AnexosController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarWeb(title: msg.annexes.value),
    body: _c.obx(
      (state) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.pWidth(10),
          vertical: context.pHeight(5),
        ),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ...(state?.items ?? []).map(
              (item) => SizedBox(
                width: context.pWidth(37.5),
                child: CardFileDownload(
                  nombre: item.description.split('.').first,
                  onDownload: () => _c.downloadAnexo(item.fileName),
                ),
              ),
            )
          ],
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
