part of '../item_map_page.dart';

class _ItemMapPhonePage extends StatelessWidget {
  _ItemMapPhonePage();

  final ItemMapController _c = Get.find<ItemMapController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(backgroundColor: Colors.white, title: Text(_c.state!.name)),
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
              child: Stack(
                children: [
                  /// Mapa
                  Obx(
                    () => SizedBox(
                      height: context.pHeight(50),
                      child: GoogleMap(
                        key: _c.mapKey.value,
                        scrollGesturesEnabled: false,
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: false,
                        rotateGesturesEnabled: false,
                        initialCameraPosition: _c.state!.gps,
                        onMapCreated: _c.mapCtrler.complete,
                        markers: _c.markers,
                        polylines: _c.polylines,
                        compassEnabled: false,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                      ),
                    ),
                  ),

                  /// Marker en el centro
                  Obx(
                    () => _c.showCentralPin.value
                        ? const Center(
                            child: Icon(
                              Icons.location_on,
                              color: ColorPalette.primary,
                              size: 40,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),

                  /// Botones de modo de transporte
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: context.pWidth(40),
                      height: context.pHeight(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// Icon gps
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
                          if (state!.lat.isNotEmpty && state.lng.isNotEmpty)
                            InkWell(
                              onTap: () async {
                                await _c.getRouteTransportMode(
                                  isModeDriving: true,
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

                  /// UI loagding
                  Obx(
                    () => _c.isLoadingRoute.value
                        ? Container(
                            height: context.pHeight(50),
                            color: Colors.grey.shade50,
                          )
                        : const SizedBox.shrink(),
                  ),
                  Obx(
                    () => _c.isLoadingRoute.value
                        ? const Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(
                                  color: ColorPalette.primary,
                                ),
                                Divider(color: Colors.transparent),
                                Text(
                                  'Calculando, por favor espere un momento...',
                                  style: TextStyle(
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
            const SizedBox(height: 30),

            /// Title
            Text(
              _c.state!.title,
              style: Get.textTheme.titleMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            /// SubTitle
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                _c.state!.subtitle,
                style: Get.textTheme.bodySmall,
              ),
            ),

            /// Description
            Text(
              _c.state!.desc,
              style: Get.textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            /// Telefono
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                onTap: _c.launchPhone,
                child: Text(
                  _c.state!.tel,
                  style: Get.textTheme.bodyMedium!.copyWith(
                    color: ColorPalette.primary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
      onLoading: const Center(child: LoadingGnp()),
    ),
  );
}
