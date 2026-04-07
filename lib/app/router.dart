import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/data/providers/router_notifier.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/counter/data/repositories/in_memory_counter_repository.dart';
import '../features/counter/domain/usecases/counter_use_cases.dart';
import '../features/counter/presentation/counter_page.dart';
import '../features/market/presentation/pages/market_page.dart';
import '../features/portfolio/presentation/pages/portfolio_page.dart';
import '../features/shell/presentation/pages/app_shell.dart';
import '../features/watchlist/presentation/pages/watchlist_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = ref.watch(routerNotifierProvider.notifier);

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    refreshListenable: notifier,
    redirect: (context, state) => notifier.redirect(state),
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),

      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const PortfolioPage(),
          ),
          GoRoute(
            path: '/watchlist',
            builder: (context, state) => const WatchlistPage(),
          ),
          GoRoute(
            path: '/counter',
            builder: (context, state) {
              final repo = InMemoryCounterRepository();
              final useCases = CounterUseCases(repo);

              return CounterPage(useCases: useCases);
            },
          ),
          GoRoute(
            path: '/market',
            builder: (context, state) => const MarketPage(),
          ),
        ],
      ),
    ],
  );
});
