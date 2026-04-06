import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import 'router.dart';

class RoadmapApp extends StatelessWidget {
  const RoadmapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Roadmap Foundation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.background,
        textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: AppColors.textPrimary,
          displayColor: AppColors.textPrimary,
        ),
      ),
      routerConfig: appRouter,
    );
  }
}
