part of '../registro_page.dart';

class _RegistroPhonePage extends StatelessWidget {
  _RegistroPhonePage();

  final RegistroController _c = Get.find<RegistroController>();
  final List<Widget> tabsView = [
    FormContactoPhone(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// Title
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Text(
              msg.createAccount.tr(),
              style: Get.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: ColorPalette.textPrimary,
              ),
            ),
          ),

          /// Body
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 15),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Obx(
                    () => Row(
                      children: List.generate(_c.tabs.length, (index) {
                        final bool isSelected = _c.selectedIndex.value == index;
                        return GestureDetector(
                          onTap: () {
                            _c.tabController.animateTo(index);
                          },
                          child: Row(
                            children: [
                              AnimatedContainer(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                width: isSelected
                                    ? context.scale(235)
                                    : context.scale(60),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: isSelected
                                          ? ColorPalette.primary
                                          : ColorPalette.textPrimary,
                                      width: context.scale(2),
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
                                        size: 20,
                                        color: ColorPalette.primary,
                                      )
                                    else
                                      const Icon(
                                        Icons.lock_outline,
                                        size: 20,
                                        color: ColorPalette.primary,
                                      ),
                                    SizedBox(
                                      width: isSelected
                                          ? context.scale(10)
                                          : context.scale(0),
                                    ),
                                    if (isSelected)
                                      Flexible(
                                        child: Text(
                                          _c.tabs[index],
                                          style: Get.textTheme.labelLarge,
                                        ),
                                      )
                                    else
                                      const SizedBox(),
                                  ],
                                ),
                              ),
                              SizedBox(width: context.scale(9)),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
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
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('tabs', _c.tabs));
  }
}
