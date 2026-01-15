import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/src/modules/procedures/domain/entities/folio_mdl.dart';

class TableCustomWdgt extends StatelessWidget {
  const TableCustomWdgt({
    required this.data,
    required this.index,
    super.key,
  });

  final FolioSiniestro data;
  final int index;

  @override
  Widget build(BuildContext context) {
    final bool isEven = index.isEven;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: isEven ? Colors.white : const Color(0xFFFAFAFA),
        border: const Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: Row(
        children: [
          BodyCellWgdt(text: data.folio, flex: 2, isBold: true),
          BodyCellWgdt(text: data.nombreAsegurado, flex: 3),
          BodyCellWgdt(text: data.padecimiento, flex: 3),
          BodyCellWgdt(text: data.poliza, flex: 2),
          BodyCellWgdt(text: data.hospitalAtencion, flex: 3),
          BodyCellWgdt(text: data.estatus, flex: 2),
          BodyCellWgdt(text: data.fechaSiniestro, flex: 2),
          // color: getStatusColor(data.estatus),
        ],
      ),
    );
  }

  // Color getStatusColor(String status) {
  //   if (status.toLowerCase().contains('DICTAMINADO')) {
  //     return Colors.green;
  //   }
  //   if (status.toLowerCase().contains('CANCELADO')) {
  //     return Colors.red;
  //   }
  //   if (status.toLowerCase().contains('proceso')) {
  //     return Colors.orange;
  //   }
  //   return ColorPalette.textPrimary;
  // }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<FolioSiniestro>('data', data))
      ..add(IntProperty('index', index));
  }
}

class HeaderTableCustomWgdt extends StatelessWidget {
  const HeaderTableCustomWgdt({required this.headers, super.key});

  final List<HeaderCellWgdt> headers;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
      color: Color(0xFFF5F7FA),
    ),
    child: Row(
      children: [...headers],
    ),
  );
}

class HeaderCellWgdt extends StatelessWidget {
  const HeaderCellWgdt({
    required this.label,
    required this.columnId,
    required this.flex,
    this.onSort,
    this.sortColumn,
    super.key,
  });

  final String label;
  final String columnId;
  final int flex;
  final ValueChanged<String>? onSort;
  final String? sortColumn;

  @override
  Widget build(BuildContext context) => Expanded(
    flex: flex,
    child: Row(
      children: [
        Flexible(
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorPalette.textPrimary,
              fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 4),
        if (onSort != null)
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            splashRadius: 20,
            onPressed: () => onSort!(columnId),
            icon: Icon(
              Icons.filter_list,
              size: 16,
              color: sortColumn == columnId
                  ? ColorPalette.primary
                  : ColorPalette.contacto,
            ),
          ),
      ],
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('label', label))
      ..add(StringProperty('columnId', columnId))
      ..add(IntProperty('flex', flex))
      ..add(
        ObjectFlagProperty<ValueChanged<String>?>.has('onSort', onSort),
      )
      ..add(StringProperty('sortColumn', sortColumn));
  }
}

class BodyCellWgdt extends StatelessWidget {
  const BodyCellWgdt({
    required this.text,
    required this.flex,
    super.key,
    this.isBold = false,
    this.color,
  });

  final String text;
  final int flex;
  final bool isBold;
  final Color? color;

  @override
  Widget build(BuildContext context) => Expanded(
    flex: flex,
    child: Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
          color: color ?? ColorPalette.textPrimary,
        ),
      ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('text', text))
      ..add(IntProperty('flex', flex))
      ..add(DiagnosticsProperty<bool>('isBold', isBold))
      ..add(ColorProperty('color', color));
  }
}
