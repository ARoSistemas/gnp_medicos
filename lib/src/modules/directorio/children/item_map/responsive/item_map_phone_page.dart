part of '../item_map_page.dart';

class _ItemMapPhonePage extends StatelessWidget {
  _ItemMapPhonePage();

  final ItemMapController _c = Get.find<ItemMapController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      title: Obx(() => Text(_c.titleAppBar.value)),
    ),
    body: _c.obx(
      (state) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Map
            SizedBox(
              width: double.infinity,
              height: context.pHeight(50),
              child: const Placeholder(),
            ),
            const SizedBox(height: 30),

            /// Title
            Text(
              _c.itemToShow.value.title,
              style: Get.textTheme.titleMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            /// SubTitle
            Text(
              _c.itemToShow.value.subtitle,
              style: Get.textTheme.bodySmall,
            ),

            /// Description
            Text(
              _c.itemToShow.value.desc,
              style: Get.textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      onLoading: const Center(child: LoadingGnp()),
    ),
  );
}
