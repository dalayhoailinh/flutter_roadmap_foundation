import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text('Market', style: AppTextStyles.titleLarge),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.show_chart, size: 64, color: AppColors.primary),
            const SizedBox(height: 16),
            Text('Stream & Isolate', style: AppTextStyles.titleMedium),
            const SizedBox(height: 8),
            Text('Tuần 5 - Dart Concurrency', style: AppTextStyles.bodySmall),
          ],
        ),
      ),
    );
  }
}
