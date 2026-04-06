import 'package:flutter/material.dart';

import '../features/counter/data/repositories/in_memory_counter_repository.dart';
import '../features/counter/domain/usecases/counter_use_cases.dart';
import '../features/counter/presentation/counter_page.dart';

class AppRouter {
  static const String counterRoute = '/';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case counterRoute:
        final repository = InMemoryCounterRepository();
        final useCases = CounterUseCases(repository);
        return MaterialPageRoute<void>(
          builder: (_) => CounterPage(useCases: useCases),
          settings: settings,
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
