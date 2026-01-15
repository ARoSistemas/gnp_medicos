part of '../directory_page.dart';

class _DirectoryDesktopPage extends StatelessWidget {
  _DirectoryDesktopPage();

  final DirectoryController _c = Get.find<DirectoryController>();

  @override
  Widget build(BuildContext context) {
    /// Mark this as desktop view
    _c.isTablet.value = false;

    /// Reset showMenuTablet for desktop (desktop always shows menu)
    _c.showMenuTablet.value = true;

    return Scaffold(
      appBar: AppBarWeb(title: msg.directory.tr()),
      body: _c.obx(
        (state) => Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            spacing: 10,
            children: [
              /// Menu Directorio
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  border: const Border(
                    right: BorderSide(color: Color(0xffCED8E8)),
                  ),
                ),
                height: context.pHeight(99),
                width: context.pWidth(20),
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
                        width: context.pWidth(18),
                        isHovered: _c.hoveredIndex == i,
                        isSelected: _c.selectedIndex == i,
                      ),
                    ),
                  ),
                ),
              ),

              /// Pagina de filtros y resultados
              SizedBox(
                height: context.pHeight(75),
                width: context.pWidth(35),
                child: Obx(
                  () => _c.showFilterPage.value
                      ? Center(
                          child:
                              _c.currentWebPage.value ??
                              SizedBox(
                                height: context.pHeight(40),
                                width: context.pWidth(25),
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

              /// Pagina del mapa
              Expanded(
                child: Obx(
                  () => _c.currentWebMapPage.value ?? const SizedBox.shrink(),
                ),
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
