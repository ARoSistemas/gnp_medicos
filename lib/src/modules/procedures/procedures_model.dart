part of 'procedures_controller.dart';

final class _ProceduresModel {
  const _ProceduresModel({
    this.name = 'Mis Trámites',
    this.nextPageToken = '',
    this.isLastPage = false,
    this.queryPageSize = 0,
    this.totalItems = 0,
    this.totalPages = 0,
  });

  factory _ProceduresModel.empty() => const _ProceduresModel();

  _ProceduresModel copyWith({
    String? name,
    int? queryPageSize,
    int? totalItems,
    int? totalPages,
    String? nextPageToken,
    bool? isLastPage,
  }) => _ProceduresModel(
    name: name ?? this.name,
    queryPageSize: queryPageSize ?? this.queryPageSize,
    totalItems: totalItems ?? this.totalItems,
    totalPages: totalPages ?? this.totalPages,
    nextPageToken: nextPageToken ?? this.nextPageToken,
    isLastPage: isLastPage ?? this.isLastPage,
  );

  final String name;
  final int totalItems;
  final int totalPages;
  final int queryPageSize;
  final String nextPageToken;
  final bool isLastPage;
}
