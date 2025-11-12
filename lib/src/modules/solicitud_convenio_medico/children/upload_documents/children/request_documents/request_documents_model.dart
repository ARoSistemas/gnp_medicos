part of 'request_documents_controller.dart';

final class _RequestDocumentsModel {
  _RequestDocumentsModel({
    this.name = 'RequestDocuments',
    this.listTypeDocuments = const [],
    this.listUploadedDocuments = const [],
  });

  factory _RequestDocumentsModel.empty() => _RequestDocumentsModel(
    name: '',
    listTypeDocuments: [],
    listUploadedDocuments: [],
  );

  _RequestDocumentsModel copyWith({
    String? name,
    List<TypeDocumentModel>? listTypeDocuments,
    List<TypeDocumentModel>? listUploadedDocuments,
  }) => _RequestDocumentsModel(
    name: name ?? this.name,
    listTypeDocuments: listTypeDocuments ?? this.listTypeDocuments,
    listUploadedDocuments: listUploadedDocuments ?? this.listUploadedDocuments,
  );

  final String name;
  final List<TypeDocumentModel> listTypeDocuments;
  final List<TypeDocumentModel> listUploadedDocuments;
}
