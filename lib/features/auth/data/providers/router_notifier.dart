import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/auth_state.dart';
import 'auth_notifier.dart';

class RouterNotifier extends AsyncNotifier<void> implements Listenable {
  VoidCallback? _routerListener;

  @override
  Future<void> build() async {
    ref.listen<AuthState>(authProvider, (_, _) => notifyListeners());
  }

  @override
  void addListener(VoidCallback listener) {
    _routerListener = listener;
  }

  @override
  void removeListener(VoidCallback listener) {
    _routerListener = null;
  }

  void notifyListeners() => _routerListener?.call();

  String? redirect(GoRouterState state) {
    final authState = ref.read(authProvider);
    final isLoggingIn = state.matchedLocation == '/login';

    if (authState == AuthState.unauthenticated && !isLoggingIn) {
      return '/login';
    }
    if (authState == AuthState.authenticated && isLoggingIn) {
      return '/';
    }
    return null;
  }
}

final routerNotifierProvider =
    AsyncNotifierProvider.autoDispose<RouterNotifier, void>(RouterNotifier.new);
