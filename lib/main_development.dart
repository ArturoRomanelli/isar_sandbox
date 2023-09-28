import 'core/isar_sandbox.dart';
import 'core/isar_sandbox_flavors.dart';
import 'core/init.dart';

void main() => init(
  flavor: IsarSandboxFlavor.development,
  builder: () => const IsarSandbox(),
);
