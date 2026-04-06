import 'package:flutter/material.dart';

import '../features/counter/data/repositories/in_memory_counter_repository.dart';
import '../features/counter/domain/usecases/counter_use_cases.dart';
import '../features/counter/presentation/counter_page.dart';
import '../features/portfolio/presentation/pages/portfolio_page.dart';

class AppRouter {
  static const String home = '/';
  static const String counter = '/counter';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const PortfolioPage());
      case counter:
        final repo = InMemoryCounterRepository();
        final useCases = CounterUseCases(repo);
        return MaterialPageRoute(
          builder: (_) => CounterPage(useCases: useCases),
        );
      default:
        return MaterialPageRoute<void>(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
          settings: settings,
        );
    }
  }
}
