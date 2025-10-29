part of '{{module_name.snakeCase()}}_page.dart';

// If you don't use it, you can remove this file
class {{module_name.pascalCase()}}RouteParams extends RouteParams {
  {{module_name.pascalCase()}}RouteParams({
    required super.id,
  });

  @override
  String get keyId => '{{module_name.camelCase()}}Id';
}