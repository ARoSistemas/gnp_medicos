part of '../filter_results_page.dart';

class _FilterResultsPhonePage extends StatelessWidget {
  _FilterResultsPhonePage();

  final FilterResultsController _c = Get.find<FilterResultsController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      title: Obx(
        () => Text(_c.itemToSearch.value.itemSelected.subtitle),
      ),
    ),
    body: _c.obx(
      (state) => SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// header
              const Text(
                'Se encontraron 00 resultados para:',
              ),

              /// body
              SizedBox(
                width: double.infinity,
                height: context.pHeight(83),
                child: ListView.builder(
                  itemCount: _c.items.length,
                  itemBuilder: (context, i) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: InkWell(
                      onTap: () async {
                        await Get.toNamed(
                          ItemMapPage.page.name,
                          arguments: {
                            'item': _c.items[i],
                            'titleAppBar':
                                _c.itemToSearch.value.itemSelected.subtitle,
                          },
                        );
                      },
                      child: CardItemsResults(
                        item: _c.items[i],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onLoading: const Center(child: LoadingGnp()),
      onEmpty: Center(
        child: LoadingGnp(
          isPositionUp: false,
          icon: Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: context.pHeight(60),
              child: const Placeholder(),
            ),
          ),
          title: esMessages.mx.noResultsFound.value,
          subtitle: esMessages.mx.selectBtnToContinue.value,
        ),
      ),
      onError: (_) => Center(
        child: LoadingGnp(
          icon: const Icon(
            Icons.error,
            size: 70,
            color: ColorPalette.primary,
          ),
          title: esMessages.mx.errorLoadingInfo.value,
          subtitle: esMessages.mx.pleaseTryAgainLater.value,
        ),
      ),
    ),
  );
}
