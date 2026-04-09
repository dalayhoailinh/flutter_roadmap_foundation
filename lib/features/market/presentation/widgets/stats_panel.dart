import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../domain/entities/portfolio_stat.dart';

class StatsPanel extends StatelessWidget {
  final List<PortfolioStat> stats;

  const StatsPanel({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Portfolio Stats (via compute())',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              'Tính toán trên isolate riêng - UI thread không bị block',
              style: AppTextStyles.bodySmall,
            ),
            const Divider(height: 24),
            ...stats.map(
              (s) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(s.label, style: AppTextStyles.bodyMedium),
                    Text(
                      '${s.value >= 0 ? '+' : ''}${s.value.toStringAsFixed(2)}%',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: s.value >= 0
                            ? AppColors.positiveGain
                            : AppColors.negativeGain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
