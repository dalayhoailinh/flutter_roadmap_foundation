import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../domain/entities/price_update.dart';

class PriceTickerCard extends StatelessWidget {
  final PriceUpdate update;

  const PriceTickerCard({super.key, required this.update});

  @override
  Widget build(BuildContext context) {
    final isUp = update.changePercent >= 0;
    final color = isUp ? AppColors.positiveGain : AppColors.negativeGain;
    final sign = isUp ? '+' : '';

    return Card(
      color: AppColors.surface,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              alignment: Alignment.centerLeft,
              child: Text(update.ticker, style: AppTextStyles.titleMedium),
            ),
            const Spacer(),
            Text(
              '\$${update.price.toStringAsFixed(2)}',
              style: AppTextStyles.titleMedium.copyWith(color: color),
            ),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '$sign${update.changePercent.toStringAsFixed(2)}%',
                style: AppTextStyles.bodySmall.copyWith(color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
