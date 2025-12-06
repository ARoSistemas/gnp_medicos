part of '../benefits_page.dart';

class _BeneficiosDesktopPage extends StatelessWidget {
  _BeneficiosDesktopPage();

  final BeneficiosController _c = Get.find<BeneficiosController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarWeb(title: msg.benefits.value),
    body: _c.obx(
      (data) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.pWidth(10),
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
                  itemCount: (data?.benefitsList.length).value(),
                  itemBuilder: (context, index) => CardBenefit(
                    web: true,
                    title: data?.benefitsList[index].nombre,
                    description: data?.benefitsList[index].leyenda,
                    image: data?.benefitsList[index].imagen,
                    onTap: () =>
                        _c.downloadBeneficio(data!.benefitsList[index]),
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
      onEmpty: const Center(
        child: LoadingGnp(
          icon: Icon(
            Icons.error,
            size: 70,
            color: ColorPalette.primary,
          ),
          title: 'Sin beneficios disponibles',
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
          subtitle: 'No fue posible recuperar los beneficios',
        ),
      ),
      onLoading: const Center(child: LoadingGnp()),
    ),
  );
}
