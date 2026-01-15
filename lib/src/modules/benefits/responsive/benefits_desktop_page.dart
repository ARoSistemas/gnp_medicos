part of '../benefits_page.dart';

class _BeneficiosDesktopPage extends StatelessWidget {
  _BeneficiosDesktopPage();

  final BeneficiosController _c = Get.find<BeneficiosController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarWeb(title: msg.benefits.tr()),
    body: _c.obx(
      (state) => DecoratedBox(
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.pWidth(5),
            vertical: context.pHeight(5),
          ),
          child: SizedBox(
            height: 324,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: ListView.separated(
                    controller: _c.scrollCtrl,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 24),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: (state?.benefitsList.length).value(),
                    itemBuilder: (context, index) => CardBenefit(
                      web: true,
                      title: state?.benefitsList[index].nombre,
                      description: state?.benefitsList[index].leyenda,
                      image: state?.benefitsList[index].imagen,
                      onTap: () =>
                          _c.downloadBeneficio(state!.benefitsList[index]),
                      jwt: _c.appState.user.token.jwt,
                    ),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Material(
                        elevation: 4,
                        shadowColor: Colors.black26,
                        shape: const CircleBorder(),
                        child: IconButton.filled(
                          onPressed: _c.moveLeft,
                          icon: const Icon(Icons.keyboard_arrow_left),
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.resolveWith(
                              (states) => Colors.white,
                            ),
                            iconColor: WidgetStateProperty.resolveWith(
                              (states) => ColorPalette.primary,
                            ),
                          ),
                        ),
                      ),
        
                      Material(
                        elevation: 4,
                        shadowColor: Colors.black26,
                        shape: const CircleBorder(),
                        child: IconButton.filled(
                          onPressed: _c.moveRight,
                          icon: const Icon(Icons.keyboard_arrow_right),
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.resolveWith(
                              (states) => Colors.white,
                            ),
                            iconColor: WidgetStateProperty.resolveWith(
                              (states) => ColorPalette.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
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
            args: [msg.benefits.tr().toLowerCase()],
          ),
          subtitle: '',
        ),
      ),
      onError: (_) => Center(
        child: LoadingGnp(
          isError: true,
          title: msg.errorOccurred.tr(),
          subtitle: msg.couldNotRetrieveBenefits.tr(),
        ),
      ),
    ),
  );
}
