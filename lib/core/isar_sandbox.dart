import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../l10n/l10n.dart';
import '../router/router_notifier.dart';
import '../router/routes_configuration.dart';
import '../theme/dark_theme.dart';
import '../theme/light_theme.dart';

class IsarSandbox extends HookConsumerWidget {
  const IsarSandbox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(routerNotifierProvider.notifier);

    final key = useRef(GlobalKey<NavigatorState>(debugLabel: 'routerKey'));
    final router = useMemoized(
      () => GoRouter(
        navigatorKey: key.value,
        debugLogDiagnostics: kDebugMode,
        initialLocation: '/',
        refreshListenable: notifier,
        // TODO handle when non-codegen
        routes: $appRoutes,
      ),
    );
    useEffect(() => router.dispose, [router]);

    return MaterialApp.router(
      routerConfig: router,
      theme: lightTheme,
      darkTheme: darkTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
