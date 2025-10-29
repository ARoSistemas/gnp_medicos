enum Flavors {
  qa('QA'),
  uat('UAT'),
  pro('PRO');

  const Flavors(this.value);

  final String value;

  static Flavors fromString(final String val) => Flavors.values.firstWhere(
    (final e) => e.value == val.toUpperCase(),
  );
}

class FlavorConfig {
  FlavorConfig._();

  static const String _flavor = String.fromEnvironment('flavor');
  static final Flavors flavor = Flavors.fromString(_flavor);
  static const String appName = String.fromEnvironment(
    'appName',
    defaultValue: 'Medicos',
  );
}
