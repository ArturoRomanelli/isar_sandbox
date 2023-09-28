import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../src/cards/presentation/pages/cards_page.dart';

part 'routes_configuration.g.dart';

@TypedGoRoute<CardsRoute>(path: '/')
class CardsRoute extends GoRouteData {
  const CardsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CardsPage();
  }
}
