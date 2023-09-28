import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';





part 'router_notifier.g.dart';
@riverpod
class RouterNotifier extends _$RouterNotifier implements Listenable {


  VoidCallback? _routerListener;

  /// Initializes this Notifier
  /// TODO: link this state to authentication or other state change
  /// TODO: customize the return type of this Notifier
  @override
  int build() {
    /// it's important to notify listeners when auth state changes
    /// so that [redirect] gets called
    ref.listenSelf((_, __) => _routerListener?.call());

    return 0;
  }

  /// TODO: write custom redirect logic on state change
  String? redirect(BuildContext context, GoRouterState state) {
    return null;
  }

  /// [Listenable] implementation part
  @override
  void addListener(VoidCallback listener) => _routerListener = listener;
  @override
  void removeListener(VoidCallback listener) => _routerListener = null;
}


