class StorageProperty<T> {
  StorageProperty({
    required this.value,
    required this.key,
    required this.defaultValue,
    bool encrypt = false,
    this.enumLoad,
  }) : _encrypt = (value is String) && encrypt;
  T value;
  final String key;
  final T defaultValue;
  final bool _encrypt;
  final T Function(int)? enumLoad;

  bool get encrypt => _encrypt;
}

extension Data<T> on T {
  StorageProperty<T> st({
    required String key,
    bool encrypt = false,
    T Function(int)? enumLoad,
  }) => StorageProperty(
    value: this,
    key: key,
    defaultValue: this,
    encrypt: encrypt,
    enumLoad: enumLoad,
  );
}
