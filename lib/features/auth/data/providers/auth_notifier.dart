import 'package:flutter_riverpod/legacy.dart';

import '../../domain/entities/auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState.unauthenticated);

  Future<void> login() async {
    state = AuthState.loading;
    await Future.delayed(const Duration(milliseconds: 1500));
    state = AuthState.authenticated;
  }

  Future<void> logout() async {
    state = AuthState.unauthenticated;
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);
