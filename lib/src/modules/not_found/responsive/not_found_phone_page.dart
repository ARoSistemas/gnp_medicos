part of '../not_found_page.dart';

class _NotFoundPhonePage extends StatelessWidget {
  const _NotFoundPhonePage();

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: context.pHeight(50),
            child: Image.asset(
              'assets/404.png'
            ),
          ),
          Text(
            'Oops...\n${msg.pageNotFound.tr()}',
            textAlign: TextAlign.center,
            style: Get.textTheme.headlineMedium?.copyWith(
              color: Get.theme.colorScheme.tertiary,
            ),
          ),
        ],
      ),
    ),
  );
}
