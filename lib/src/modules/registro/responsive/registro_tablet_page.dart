part of '../registro_page.dart';

class _RegistroTabletPage extends StatelessWidget {
  _RegistroTabletPage();

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
            /// Background image
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/home_medicos_banner.png',
                    ),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black54,
                      BlendMode.dstATop,
                    ),
                  ),
                ),
              ),
            ),

            /// Registration Card
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 24,
                ),
                width: width * 0.5,
                height: height * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /// Title
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Text(
                        esMessages.mx.createAccount.value,
                        style: Get.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: ColorPalette.textPrimary,
                        ),
                      ),
                    ),

                    /// Tabs
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Obx(
                        () => Row(
                          children: List.generate(
                            _c.tabs.length,
                            (index) {
                              final bool isSelected = 
                                  _c.selectedIndex.value == index;
                              return GestureDetector(
                                onTap: () {
                                  _c.tabController.animateTo(index);
                                },
                                child: Row(
                                  children: [
                                    AnimatedContainer(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 18,
                                      ),
                                      duration: 
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                      width: isSelected
                                          ? context.scale(300)
                                          : context.scale(80),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: isSelected
                                                ? ColorPalette.primary
                                                : ColorPalette.textPrimary,
                                            width: context.scale(3),
                                          ),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment: isSelected
                                            ? MainAxisAlignment.start
                                            : MainAxisAlignment.center,
                                        children: [
                                          if (index == 0)
                                            const Icon(
                                              Icons.person_outline,
                                              size: 24,
                                              color: ColorPalette.primary,
                                            )
                                          else
                                            const Icon(
                                              Icons.lock_outline,
                                              size: 24,
                                              color: ColorPalette.primary,
                                            ),
                                          SizedBox(
                                            width: isSelected
                                                ? context.scale(12)
                                                : context.scale(0),
                                          ),
                                          if (isSelected)
                                            Flexible(
                                              child: Text(
                                                _c.tabs[index],
                                                style: Get.textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            )
                                          else
                                            const SizedBox(),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: context.scale(12)),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
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
