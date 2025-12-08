part of '../registro_page.dart';

class _RegistroDesktopPage extends StatelessWidget {
  _RegistroDesktopPage();

  final RegistroController _c = Get.find<RegistroController>();
  final List<Widget> tabsView = [
    FormContactoPhone(),
  ];

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final double height = constraints.maxHeight;
      final double width = constraints.maxWidth;
      return Scaffold(
        body: Stack(
          children: [
            /// Header: Logo GNP
            Container(
              height: 64,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: ColorPalette.textPrimary
                  )
                )
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
                    child: LogoGnp(width: context.scale(85)),
                  ),
                ],
              ),
            ),

            /// Background image
            Positioned(
              top: height * 0.1,
              child: Container(
                width: width,
                height: height * 0.8,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage(
                      'assets/home_medicos_banner.png',
                    ),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withValues(alpha: 0.85),
                      BlendMode.dstATop,
                    ),
                  ),
                ),
              ),
            ),

            /// Registration Card
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 24,
                  ),
                  width: 450,
                  height: height * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /// Title
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          esMessages.mx.createAccount.value,
                          style: Get.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: ColorPalette.textPrimary,
                          ),
                        ),
                      ),

                      /// Tabs
                      Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: Row(
                          children: List.generate(
                            _c.tabs.length,
                            (index) => GestureDetector(
                                onTap: () {
                                  _c.tabController.animateTo(index);
                                },
                                child: SizedBox(width: context.scale(8)),
                              ),
                          ),
                        )
                      ),

                      /// Tab Controller
                      Expanded(
                        child: TabBarView(
                          controller: _c.tabController,
                          children: tabsView.map((e) => e).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('tabs', _c.tabs));
  }
}
