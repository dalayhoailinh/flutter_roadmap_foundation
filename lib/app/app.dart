import 'package:flutter/material.dart';

import 'router.dart';

class RoadmapApp extends StatelessWidget {
  const RoadmapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Roadmap Foundation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: AppRouter.counterRoute,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
