part of '../formats_page.dart';

class _FormatsDesktopPage extends StatelessWidget {
  _FormatsDesktopPage();

  final FormatsController _c = Get.find<FormatsController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarWeb(title: msg.formats.value),
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
            ...(state?.formatsList ?? []).map(
              (item) => SizedBox(
                width: context.pWidth(37.5),
                child: CardFileDownload(
                  nombre: item.description.split('.').first,
                  onDownload: () => _c.downloadFormato(item.fileName),
                ),
              ),
            ),
          ],
        ),
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
