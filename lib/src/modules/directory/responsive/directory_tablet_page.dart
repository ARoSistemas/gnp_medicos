part of '../directory_page.dart';

class _DirectoryTabletPage extends StatelessWidget {
  _DirectoryTabletPage();

  final DirectoryController _c = Get.find<DirectoryController>();

  @override
  Widget build(BuildContext context) {
    /// Mark this as tablet view
    _c.isTablet.value = true;

    /// Synchronize showMenuTablet based on whether an item is selected
    /// If there's active content (filter page or results), hide menu
    if (_c.currentWebPage.value != null ||
        _c.currentWebResultPage.value != null) {
      _c.showMenuTablet.value = false;
    }

    return Scaffold(
      appBar: AppBarWeb(title: msg.directory.tr()),
      body: _c.obx(
        (state) => Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            spacing: 10,
            children: [
              /// Menu Directorio - Show/Hide based on showMenuTablet
              Obx(
                () => _c.showMenuTablet.value
                    ? Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          border: const Border(
                            right: BorderSide(color: Color(0xffCED8E8)),
                          ),
                        ),
                        height: context.pHeight(99),
                        width: context.pWidth(30),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _c.items.length,
                          itemBuilder: (context, i) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: InkWell(
                              onHover: (isHovering) {
                                _c.hoveredIndex = isHovering ? i : null;
                                _c.update();
                              },
                              onTap: () async {
                                _c.selectedIndex = i;
                                await _c.gotoWeb(_c.items[i]);
                              },
                              child: ItemsMenuDirectory(
                                title: _c.items[i].title,
                                img: _c.items[i].img,
                                jwt: _c.jwt,
                                isWeb: true,
                                width: context.pWidth(25),
                                isHovered: _c.hoveredIndex == i,
                                isSelected: _c.selectedIndex == i,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),

              /// Pagina de filtros y resultados
              Expanded(
                flex: _c.showMenuTablet.value ? 35 : 40,
                child: Obx(
                  () => _c.showFilterPage.value
                      ? Center(
                          child:
                              _c.currentWebPage.value ??
                              SizedBox(
                                height: context.pHeight(40),
                                width: context.pWidth(30),
                                child: ImageFromWeb(
                                  imageName: 'imagen_directorio_principal.png',
                                  jwt: _c.jwt,
                                  fit: BoxFit.contain,
                                ),
                              ),
                        )
                      : (_c.currentWebResultPage.value ??
                            const SizedBox.shrink()),
                ),
              ),

              /// Pagina del mapa - Only show when menu is hidden
              Obx(
                () => !_c.showMenuTablet.value
                    ? Expanded(
                        flex: 60,
                        child:
                            _c.currentWebMapPage.value ??
                            const SizedBox.shrink(),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
        onLoading: const Center(child: LoadingGnp()),
        onEmpty: Center(
          child: LoadingGnp(
            icon: const Icon(
              Icons.warning,
              size: 70,
              color: ColorPalette.primary,
            ),
            title: msg.noInformationToShow.tr(),
            subtitle: '',
          ),
        ),
        onError: (_) => Center(
          child: LoadingGnp(
            isError: true,
            title: msg.errorLoadingInfo.tr(),
            subtitle: msg.pleaseTryAgainLater.tr(),
          ),
        ),
      ),
    );
  }
}
