part of 'item_map_controller.dart';

final class _ItemMapModel {
  _ItemMapModel({
    required this.title,
    required this.subtitle,
    required this.desc,
    required this.tel,
    required this.lat,
    required this.lng,
    required this.name,
    required this.gps,
  });

  /// Factory for creating an empty model with default Mexico City coordinates
  factory _ItemMapModel.empty() => _ItemMapModel(
    title: '',
    subtitle: '',
    desc: '',
    tel: '',
    lat: '',
    lng: '',
    name: '',
    gps: const CameraPosition(target: LatLng(19.432608, -99.133209), zoom: 12),
  );

  _ItemMapModel copyWith({
    String? name,
    String? title,
    String? subtitle,
    String? desc,
    String? tel,
    String? lat,
    String? lng,
    CameraPosition? gps,
  }) => _ItemMapModel(
    name: name ?? this.name,
    title: title ?? this.title,
    subtitle: subtitle ?? this.subtitle,
    desc: desc ?? this.desc,
    tel: tel ?? this.tel,
    lat: lat ?? this.lat,
    lng: lng ?? this.lng,
    gps: gps ?? this.gps,
  );

  final String name;
  final String title;
  final String subtitle;
  final String desc;
  final String tel;
  final String lat;
  final String lng;
  final CameraPosition gps;
}
