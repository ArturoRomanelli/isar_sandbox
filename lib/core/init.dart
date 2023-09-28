import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';



import '../logs/init_logging.dart';
import 'init_overrides.dart';
import 'isar_sandbox_flavors.dart';

Future<void> init({
  required ValueGetter<Widget> builder,
  required IsarSandboxFlavor flavor,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  initErrorReporting();
  final providerObserver = initProviderObserver();
  final overrides = await initOverridesWith(flavor: flavor);

  // add more configurations here
  runApp(ProviderScope(
    overrides: overrides,
    observers: [providerObserver],
    child: await builder(),
  ));
}
