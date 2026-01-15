import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    this.onFilterPressed,
    this.onSearchPressed,
    this.controller,
    this.isWeb = false,
  });

  final VoidCallback? onFilterPressed;
  final VoidCallback? onSearchPressed;
  final TextEditingController? controller;
  final bool isWeb;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(
      top: 10,
      bottom: 10,
    ),
    child: Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD4DBE6)),
      ),
      child: Row(
        children: [
          /// Filter button pressed
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onFilterPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                spacing: 8,
                children: [
                  const Icon(Icons.filter_list, color: ColorPalette.primary),
                  if (isWeb)
                    Text(
                      'Filtros',
                      style: Get.theme.primaryTextTheme.titleMedium!.copyWith(
                        color: ColorPalette.primary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ),

          /// Vertical divider
          Container(
            width: 1,
            height: 30,
            color: const Color(0xFFD4DBE6),
          ),

          /// Text field (no placeholder)
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: '',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 2,
                  vertical: isWeb ? 14 : 10,
                ),
              ),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),

          // /// Search button (orange)
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onSearchPressed,
            child: Container(
              height: double.infinity,
              width: isWeb ? 80 : 40,
              decoration: const BoxDecoration(
                color: ColorPalette.primary,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: isWeb
                  ? Center(
                      child: Text(
                        'Buscar',
                        style: Get.theme.primaryTextTheme.titleMedium,
                      ),
                    )
                  : const Icon(Icons.search, color: Colors.white, size: 26),
            ),
          ),
        ],
      ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        ObjectFlagProperty<VoidCallback?>.has(
          'onFilterPressed',
          onFilterPressed,
        ),
      )
      ..add(
        ObjectFlagProperty<VoidCallback?>.has(
          'onSearchPressed',
          onSearchPressed,
        ),
      )
      ..add(
        DiagnosticsProperty<TextEditingController?>('controller', controller),
      )
      ..add(DiagnosticsProperty<bool>('isWeb', isWeb));
  }
}
