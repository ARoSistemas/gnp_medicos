part of '../item_map_page.dart';

class _ItemMapDesktopPage extends StatelessWidget {
  _ItemMapDesktopPage();

  final ItemMapController _c = Get.find<ItemMapController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    body: _c.obx(
      (state) {
        /// Detect if there's a specific item selected
        final bool hasItemData = state!.title.isNotEmpty;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Map
            Expanded(
              child: Stack(
                children: [
                  /// Map
                  Obx(
                    () => SizedBox(
                      height: hasItemData
                          ? context.pHeight(50)
                          : double.infinity,
                      child: GoogleMap(
                        key: _c.mapKey.value,
                        scrollGesturesEnabled: false,
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: false,
                        rotateGesturesEnabled: false,
                        initialCameraPosition: _c.state!.gps,
                      onMapCreated: _c.onMapCreated,
                        markers: _c.markers,
                        polylines: _c.polylines,
                        compassEnabled: false,
                        myLocationButtonEnabled: false,
                      ),
                    ),
                  ),

                  /// Center marker
                  Obx(
                    () => _c.showCentralPin.value
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 40),
                              child: Icon(
                                Icons.location_on,
                                color: ColorPalette.primary,
                                size: 40,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),

                  /// Transport mode buttons
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: context.pWidth(40),
                      height: context.pHeight(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// Icon gps
                          if (hasItemData)
                          GestureDetector(
                            onTap: () =>
                                _c.goToCurrentLocation(moveCamera: true),
                            child: const DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.my_location,
                                color: Color(0xFF59677D),
                                size: 35,
                              ),
                            ),
                          ),

                          /// Icon car
                          if (state.lat.isNotEmpty && state.lng.isNotEmpty)
                            InkWell(
                              onTap: () async {
                                await _c.getRouteTransportMode(
                                  isModeDriving: true,
                                  isWeb: true,
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(left: 4, right: 4),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Icon(
                                    Icons.directions_car,
                                    color: Color(0xFF59677D),
                                    size: 35,
                                  ),
                                ),
                              ),
                            ),

                          /// Icon walking
                          if (state.lat.isNotEmpty && state.lng.isNotEmpty)
                            InkWell(
                              onTap: () async {
                                await _c.getRouteTransportMode(
                                  isModeDriving: false,
                                  isWeb: true,
                                );
                              },
                              child: const DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Icon(
                                  Icons.directions_walk,
                                  color: Color(0xFF59677D),
                                  size: 35,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  /// UI loading
                  Obx(
                    () => _c.isLoadingRoute.value
                        ? Container(
                            height: hasItemData
                                ? context.pHeight(50)
                                : double.infinity,
                            color: Colors.grey.shade50,
                          )
                        : const SizedBox.shrink(),
                  ),
                  Obx(
                    () => _c.isLoadingRoute.value
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const CircularProgressIndicator(
                                  color: ColorPalette.primary,
                                ),
                                const Divider(color: Colors.transparent),
                                Text(
                                  msg.calculatingPleaseWait.tr(),
                                  style: const TextStyle(
                                    color: ColorPalette.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),

            /// Item information section - 
            /// only show when there's a selected item
            if (hasItemData) const SizedBox(height: 30),

            /// Title
            if (hasItemData)
              Text(
                state.title,
                style: Get.textTheme.titleMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

            /// SubTitle
            if (hasItemData)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  state.subtitle,
                  style: Get.textTheme.bodySmall,
                ),
              ),

            /// Description
            if (hasItemData)
              Text(
                state.desc,
                style: Get.textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

            /// Telefono
            if (hasItemData)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  onTap: _c.launchPhone,
                  child: Text(
                    state.tel,
                    style: Get.textTheme.bodyMedium!.copyWith(
                      color: ColorPalette.primary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
          ],
        );
      },
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
