abstract class RouteParams {
  const RouteParams({
    required this.id,
    this.parentParams,
  });

  final String? id;

  final RouteParams? parentParams;

  String get keyId;

  Map<String, String> get pathsMap => {
    ...?parentParams?.pathsMap,
    keyId: ?id,
  };

  Map<String, String>? get queriesMap => null;
}
