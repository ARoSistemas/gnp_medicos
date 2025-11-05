/// A data model that represents an item in the directory menu.
///
/// This class is used to encapsulate the information for each option
/// displayed in the directory list, such as in `_DirectorioPhonePage`.
/// It contains a title for the item and the name of the associated image.
class ItemsDirectoryMdl {
  /// Creates an instance of [ItemsDirectoryMdl].
  ItemsDirectoryMdl({
    required this.title,
    required this.subtitle,
    required this.idPage,
    this.img = '',
  });

  /// Creates an empty instance of [ItemsDirectoryMdl].
  factory ItemsDirectoryMdl.empty() => ItemsDirectoryMdl(
    title: '',
    subtitle: '',
    idPage: '',
  );

  /// The title of the directory item to be displayed in the UI.
  final String title;

  /// The subtitle of the directory item to be displayed in the UI.
  final String subtitle;

  /// The route name associated with the directory item.
  final String idPage;

  /// The name or path of the image file for the directory item.
  final String img;
}
