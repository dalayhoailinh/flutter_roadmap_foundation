import 'package:fake_async/fake_async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_roadmap_foundation/features/auth/data/providers/auth_notifier.dart';
import 'package:flutter_roadmap_foundation/features/auth/domain/entities/auth_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthNotifier', () {
    test('Initial state là unauthenticated', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(authProvider), AuthState.unauthenticated);
    });

    test('Login chuyển qua loading rồi authenticated', () {
      fakeAsync((fake) {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        container.read(authProvider.notifier).login();
        expect(container.read(authProvider), AuthState.loading);

        fake.elapse(const Duration(seconds: 2));
        expect(container.read(authProvider), AuthState.authenticated);
      });
    });
  });
}
