part of 'request_documents_controller.dart';

final class _RequestDocumentsModel {
  _RequestDocumentsModel({
    this.name = 'RequestDocuments',
    this.listTypeDocuments = const [],
  });

  factory _RequestDocumentsModel.empty() => _RequestDocumentsModel(
    name: '',
    listTypeDocuments: [],
  );

  _RequestDocumentsModel copyWith({
    String? name,
    List<TypeDocumentModel>? listTypeDocuments,
  }) => _RequestDocumentsModel(
    name: name ?? this.name,
    listTypeDocuments: listTypeDocuments ?? this.listTypeDocuments,
  );

  final String name;
  final List<TypeDocumentModel> listTypeDocuments;
}
