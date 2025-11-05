class ItemsResultsMdl {
  ItemsResultsMdl({
    required this.title,
    required this.subtitle,
    required this.desc,
    required this.gps,
  });

  factory ItemsResultsMdl.empty() => ItemsResultsMdl(
    title: '',
    subtitle: '',
    desc: '',
    gps: '',
  );

  /// The title of the directory item to be displayed in the UI.
  final String title;

  /// The subtitle of the directory item to be displayed in the UI.
  final String subtitle;

  /// The image associated with the directory item.
  final String desc;

  /// The GPS coordinates associated with the directory item.
  final String gps;
}
