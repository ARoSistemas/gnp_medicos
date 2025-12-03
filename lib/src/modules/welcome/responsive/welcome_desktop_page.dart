part of '../welcome_page.dart';

class _WelcomeDesktopPage extends StatelessWidget {
  _WelcomeDesktopPage();

  final WelcomeController _c = Get.find<WelcomeController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Get.theme.colorScheme.surface,
      title: Container(
        height: 130,
        width: double.infinity,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.blue,
              width: 4,
            ),
          ),
        ),

        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: context.scale(80),
                child: Image.asset(
                  'assets/logo-gnp.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    ),

    body: Obx(
      () => Row(
        children: [
          /// Construccion del menu completo: SideMenu + Pages
          SideMenu(
            controller: _c.sideMenuCtrler,
            style: SideMenuStyle(
              displayMode: _c.menuDisplayMode.value,
              showHamburger: true,
              compactSideMenuWidth: 200,
              openSideMenuWidth: 250,
              // hoverColor: ColorPalette.primary.withOpacity(0.1),
              selectedColor:
                  Colors.transparent, //ColorPalette.primary.withOpacity(0.2),
              selectedTitleTextStyle: const TextStyle(
                color: ColorPalette.primary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              selectedIconColor: ColorPalette.primary,
            ),

            // title: Row(
            //   children: [
            //     IconButton(
            //       icon: const Icon(Icons.menu, color: ColorPalette.primary),
            //       onPressed: _c.toggleMenu,
            //     ),
            //     const VerticalDivider(color: Colors.transparent),
            //     Column(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         const Divider(color: Colors.transparent),
            //         SizedBox(
            //           width: context.scale(80),
            //           child: Image.asset(
            //             'assets/logo-gnp.png',
            //             fit: BoxFit.cover,
            //           ),
            //         ),
            //         const Divider(),
            //       ],
            //     ),
            //   ],
            // ),
            items: _c.itemsMenu,
          ),
          const VerticalDivider(width: 0),

          /// Pages
          Expanded(
            child: PageView(
              controller: _c.pageCtrler,
              physics: const NeverScrollableScrollPhysics(),
              children: _c.itemsPages,
            ),
          ),
        ],
      ),
    ),
    // Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: <Widget>[
    //       Text(
    //         'Welcome module desktop page',
    //         style: Get.textTheme.headlineMedium,
    //       ),
    //     ],
    //   ),
    // ),
  );
}
