import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/wdgt_loading.dart';

/// Clase para definir los headers de la tabla
class TableHeader {
  const TableHeader({
    required this.title,
    required this.columnKey,
    this.sortable = true,
    this.flex = 2,
  });

  final String title;
  final String columnKey;
  final bool sortable;
  final int flex;
}

/// Widget stateless para cada celda del header con funcionalidad de sorting
class TableWebHeaderCell extends StatelessWidget {
  const TableWebHeaderCell({
    required this.title,
    required this.columnKey,
    required this.sortable,
    required this.isCurrentColumn,
    required this.isAscending,
    this.onSort,
    super.key,
  });

  final String title;
  final String columnKey;
  final bool sortable;
  final bool isCurrentColumn;
  final bool isAscending;
  final Function(String)? onSort;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: sortable && onSort != null ? () => onSort!(columnKey) : null,
    child: Row(
      children: [
        Flexible(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Visibility(
          visible: sortable,
          child: Icon(
            sortable
                ? (isCurrentColumn
                      ? (isAscending ? Icons.arrow_upward 
                      : Icons.arrow_downward)
                      : Icons.filter_list_outlined)
                : Icons.filter_list_outlined,
            size: 16,
            color: isCurrentColumn && sortable
                ? ColorPalette.primary
                : ColorPalette.textPrimary,
          ),
        )
      ],
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties
      ..add(StringProperty('title', title))
      ..add(StringProperty('columnKey', columnKey))
      ..add(DiagnosticsProperty<bool>('sortable', sortable))
      ..add(
        DiagnosticsProperty<bool>('isCurrentColumn', isCurrentColumn),
      )
      ..add(DiagnosticsProperty<bool>('isAscending', isAscending))
      ..add(
        ObjectFlagProperty<Function(String p1)?>.has('onSort', onSort),
      );
  }
}

/// Widget stateless para el header completo de la tabla
class TableWebHeader extends StatelessWidget {
  const TableWebHeader({
    required this.headers,
    required this.sortColumn,
    required this.isAscending,
    this.onSort,
    super.key,
  });

  final List<TableHeader> headers;
  final String? sortColumn;
  final bool isAscending;
  final Function(String)? onSort;

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: ColorPalette.backgroundCardBanner,
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(4),
        topRight: Radius.circular(4),
      ),
    ),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    child: IntrinsicHeight(
      child: Row(
        children: headers
            .map(
              (header) => Expanded(
                flex: header.flex,
                child: TableWebHeaderCell(
                  title: header.title,
                  columnKey: header.columnKey,
                  sortable: header.sortable,
                  isCurrentColumn: sortColumn == header.columnKey,
                  isAscending: isAscending,
                  onSort: onSort,
                ),
              ),
            )
            .toList(),
      ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<TableHeader>('headers', headers))
      ..add(StringProperty('sortColumn', sortColumn))
      ..add(DiagnosticsProperty<bool>('isAscending', isAscending))
      ..add(
        ObjectFlagProperty<Function(String p1)?>.has('onSort', onSort),
      );
  }
}

/// Widget stateless para cada fila de la tabla
class TableWebRow extends StatelessWidget {
  const TableWebRow({
    required this.rowCells,
    required this.headers,
    super.key,
  });

  final List<Widget> rowCells;
  final List<TableHeader> headers;

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      border: Border(
        left: BorderSide(color: Colors.grey.shade300),
        right: BorderSide(color: Colors.grey.shade300),
        bottom: BorderSide(color: Colors.grey.shade300),
      ),
    ),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    child: IntrinsicHeight(
      child: Row(
        spacing: 16,
        children: List.generate(
          rowCells.length,
          (index) => Expanded(
            flex: index < headers.length ? headers[index].flex : 2,
            child: rowCells[index],
          ),
        ),
      ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<TableHeader>('headers', headers));
  }
}

/// Widget stateless para los controles de paginación
class TableWebPagination extends StatelessWidget {
  const TableWebPagination({
    required this.currentPage,
    required this.totalPages,
    this.onNextPage,
    this.onPreviousPage,
    super.key,
  });

  final int currentPage;
  final int totalPages;
  final VoidCallback? onNextPage;
  final VoidCallback? onPreviousPage;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: currentPage > 1 ? onPreviousPage : null,
          color: ColorPalette.primary,
        ),
        Text(
          '$currentPage de $totalPages',
          style: const TextStyle(fontSize: 14),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: totalPages > currentPage ? onNextPage : null,
          color: ColorPalette.primary,
        ),
      ],
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('currentPage', currentPage))
      ..add(IntProperty('totalPages', totalPages))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onNextPage', onNextPage))
      ..add(
        ObjectFlagProperty<VoidCallback?>.has('onPreviousPage', onPreviousPage),
      );
  }
}

/// Widget stateless para mostrar estado vacío
class TableWebEmptyState extends StatelessWidget {
  const TableWebEmptyState({
    this.message,
    super.key,
  });

  final String? message;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Padding(
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Text(
          message ?? msg.notPayments.tr(),
          style: Get.textTheme.bodyLarge?.copyWith(
            color: ColorPalette.textSecondary,
          ),
        ),
      ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('message', message));
  }
}

/// 
/// Widget stateful principal para la tabla web
/// 
class TableWeb extends StatefulWidget {
  const TableWeb({
    required this.headers,
    required this.rows,
    required this.isFetchingMore,
    this.minWidth = 1000,
    this.isLoading = false,
    this.emptyMessage,
    this.showPagination = false,
    this.currentPage,
    this.totalPages,
    this.onNextPage,
    this.onPreviousPage,
    this.pageSize,
    this.onSort,
    this.sortColumn,
    this.isAscending,
    super.key,
  });

  final List<TableHeader> headers;
  final List<List<Widget>> rows;
  final double minWidth;
  final bool isFetchingMore;
  final bool isLoading;
  final String? emptyMessage;
  final bool showPagination;
  final int? pageSize;
  final int? currentPage;
  final int? totalPages;
  final VoidCallback? onNextPage;
  final VoidCallback? onPreviousPage;
  final Function(String)? onSort;
  final String? sortColumn;
  final bool? isAscending;

  @override
  State<TableWeb> createState() => _TableWebState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<TableHeader>('headers', headers))
      ..add(DoubleProperty('minWidth', minWidth))
      ..add(DiagnosticsProperty<bool>('isFetchingMore', isFetchingMore))
      ..add(DiagnosticsProperty<bool>('isLoading', isLoading))
      ..add(StringProperty('emptyMessage', emptyMessage))
      ..add(DiagnosticsProperty<bool>('showPagination', showPagination))
      ..add(IntProperty('pageSize', pageSize))
      ..add(IntProperty('currentPage', currentPage))
      ..add(IntProperty('totalPages', totalPages))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onNextPage', onNextPage))
      ..add(
        ObjectFlagProperty<VoidCallback?>.has('onPreviousPage', onPreviousPage),
      )
      ..add(ObjectFlagProperty<Function(String p1)?>.has('onSort', onSort))
      ..add(StringProperty('sortColumn', sortColumn))
      ..add(DiagnosticsProperty<bool?>('isAscending', isAscending));
  }
}

/// Estado del widget TableWeb
class _TableWebState extends State<TableWeb> {
  ScrollController scrollCtrlerHorizontal = ScrollController();
  ScrollController scrollCtrlerVertical = ScrollController();
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    scrollCtrlerHorizontal = ScrollController();
    scrollCtrlerVertical = ScrollController();
  }

  @override
  void dispose() {
    scrollCtrlerHorizontal.dispose();
    scrollCtrlerVertical.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const Center(child: LoadingGnp());
    }
    return Column(
      children: [
        /// Principal table area
        Flexible(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double tableWidth = constraints.maxWidth > widget.minWidth
                  ? constraints.maxWidth
                  : widget.minWidth;
              return Scrollbar(
                controller: scrollCtrlerHorizontal,
                trackVisibility: true,
                interactive: true,
                child: SingleChildScrollView(
                  controller: scrollCtrlerHorizontal,
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: tableWidth,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// Table header
                        TableWebHeader(
                          headers: widget.headers,
                          sortColumn: widget.sortColumn,
                          isAscending: widget.isAscending ?? true,
                          onSort: widget.onSort,
                        ),

                        /// Table rows or empty state
                        if (widget.rows.isEmpty)
                          TableWebEmptyState(
                            message: widget.emptyMessage,
                          )
                        else
                        
                        /// Table rows list
                          Flexible(
                            child: Scrollbar(
                              controller: scrollCtrlerVertical,
                              trackVisibility: true,
                              interactive: true,
                              child: ListView.builder(
                                controller: scrollCtrlerVertical,
                                shrinkWrap: true,
                                itemCount:
                                    widget.rows.length +
                                    (widget.isFetchingMore ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (index >= widget.rows.length) {
                                    return const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(16),
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                  return TableWebRow(
                                    rowCells: widget.rows[index],
                                    headers: widget.headers,
                                  );
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        /// show pagination controls if is required
        if (widget.showPagination)
          TableWebPagination(
            currentPage: widget.currentPage ?? 1,
            totalPages: widget.totalPages ?? 1,
            onNextPage: widget.onNextPage,
            onPreviousPage: widget.onPreviousPage,
          ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<TableHeader>('headers', widget.headers))
      ..add(DiagnosticsProperty<bool>('isLoading', widget.isLoading))
      ..add(DiagnosticsProperty<bool>('isFetchingMore', widget.isFetchingMore))
      ..add(StringProperty('emptyMessage', widget.emptyMessage))
      ..add(DiagnosticsProperty<bool>('showPagination', widget.showPagination))
      ..add(IntProperty('currentPage', widget.currentPage))
      ..add(IntProperty('totalPages', widget.totalPages))
      ..add(
        ObjectFlagProperty<VoidCallback?>.has('onNextPage', widget.onNextPage),
      )
      ..add(
        ObjectFlagProperty<VoidCallback?>.has(
          'onPreviousPage',
          widget.onPreviousPage,
        ),
      )
      ..add(IntProperty('pageSize', widget.pageSize))
      ..add(
        ObjectFlagProperty<Function(String)?>.has('onSort', widget.onSort),
      )
      ..add(StringProperty('sortColumn', widget.sortColumn))
      ..add(DiagnosticsProperty<bool?>('isAscending', widget.isAscending))
      ..add(DoubleProperty('minWidth', widget.minWidth))
      ..add(
        DiagnosticsProperty<ScrollController>(
          'scrollCtrlerHorizontal',
          scrollCtrlerHorizontal,
        ),
      )
      ..add(
        DiagnosticsProperty<ScrollController>(
          'scrollCtrlerVertical',
          scrollCtrlerVertical,
        ),
      )..add(DiagnosticsProperty<bool>('isLoadingMore', isLoadingMore));
  }
}
