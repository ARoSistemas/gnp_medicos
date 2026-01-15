part of 'payments_controller.dart';

class PaymentsModel {
  
  const PaymentsModel({
    this.totalItems = 1, 
    this.totalPages = 1, 
    this.pageSize = 1, 
    this.name = 'Mis pagos',
    this.nextPageToken = '',
    this.isLastPage = false,
  });

  factory PaymentsModel.empty() => const PaymentsModel();

  PaymentsModel copyWith({
    String? name,
    String? nextPageToken,
    bool? isLastPage,
    int? totalItems,
    int? totalPages,
    int? pageSize, 
  }) => PaymentsModel(
    name: name ?? this.name,
    nextPageToken: nextPageToken ?? this.nextPageToken,
    isLastPage: isLastPage ?? this.isLastPage,
    totalItems: totalItems ?? this.totalItems,
    totalPages: totalPages ?? this.totalPages,
    pageSize: pageSize ?? this.pageSize,
  );

  final String name;
  final String nextPageToken;
  final bool isLastPage;
  final int totalItems;
  final int totalPages;
  final int pageSize;

}
