import 'package:flutter/material.dart';

import '../../../../core/animations/animation_constants.dart';
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
            TweenAnimationBuilder<Color?>(
              key: ValueKey(update.price),
              tween: ColorTween(begin: color, end: AppColors.textPrimary),
              curve: AnimationConstants.flashEase,
              duration: AnimationConstants.priceFlash,
              builder: (context, value, _) {
                return Text(
                  '\$${update.price.toStringAsFixed(2)}',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: value ?? AppColors.textPrimary,
                  ),
                );
              },
            ),
            const SizedBox(width: 16),
            Container(
              height: 25,
              width: 50,
              alignment: Alignment.center,
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
