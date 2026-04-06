import 'package:go_router/go_router.dart';

import '../features/counter/data/repositories/in_memory_counter_repository.dart';
import '../features/counter/domain/usecases/counter_use_cases.dart';
import '../features/counter/presentation/counter_page.dart';
import '../features/portfolio/presentation/pages/portfolio_page.dart';
import '../features/watchlist/presentation/pages/watchlist_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const PortfolioPage()),
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
  ],
);
