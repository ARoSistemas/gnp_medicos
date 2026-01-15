class ItemResultsMdl {
  ItemResultsMdl({
    required this.title,
    required this.subtitle,
    required this.desc,
    required this.tel,
    required this.lat,
    required this.lng,
  });

  factory ItemResultsMdl.empty() => ItemResultsMdl(
    title: '',
    subtitle: '',
    desc: '',
    tel: '',
    lat: '',
    lng: '',
  );

  /// The title of the directory item to be displayed in the UI.
  final String title;

  /// The subtitle of the directory item to be displayed in the UI.
  final String subtitle;

  /// The image associated with the directory item.
  final String desc;

  /// The telephone number associated with the directory item.
  final String tel;

  /// The GPS coordinates of the directory item.
  final String lat;
  final String lng;
}
