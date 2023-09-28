

import 'package:riverpod_annotation/riverpod_annotation.dart';




part 'isar_sandbox_flavors.g.dart';
@riverpod
IsarSandboxFlavor flavor(FlavorRef ref) {


  throw UnimplementedError('This provider is meant to be overridden');

}



enum IsarSandboxFlavor {
  development(title: '[DEV] Isar Sandbox'),
  staging(title: '[STG] Isar Sandbox'),
  production(title: 'Isar Sandbox');

  const IsarSandboxFlavor({required this.title});
  final String title;

  // add flavor-related configurations getters and methods, if needed
  // example:
  String obtainAppId(String fullPackageName) {
    if (this == production) return fullPackageName;

    final split = fullPackageName.split('.');
    final splitWithoutFlavor = split.sublist(0, split.length - 1);
    final actualPackageName = splitWithoutFlavor.join('.');
    return actualPackageName;
  }
}
