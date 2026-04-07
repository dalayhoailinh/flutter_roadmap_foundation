import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';

class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  static const _tabs = ['/', '/watchlist', '/counter', '/market'];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final currentIndex = _tabs.indexWhere(
      (tab) => location == tab || location.startsWith('$tab/'),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        onTap: (index) => context.go(_tabs[index]),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.pie_chart_rounded),
            label: 'Portfolio',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bookmark_rounded),
            label: 'Watchlist',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.add_circle_outline_rounded),
            label: 'Counter',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.show_chart),
            label: 'Market',
          ),
        ],
      ),
    );
  }
}
