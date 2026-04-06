import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../domain/entities/asset.dart';

class AssetListItem extends StatelessWidget {
  final Asset asset;

  const AssetListItem({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider, width: 1)),
      ),
      child: Row(
        children: [
          _AssetLogo(label: asset.logoLabel, isPositive: asset.isPositive),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(asset.symbol, style: AppTextStyles.titleMedium),
                const SizedBox(height: 2),
                Text(asset.name, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(asset.formattedPrice, style: AppTextStyles.titleMedium),
              const SizedBox(height: 2),
              Text(
                asset.formattedChange,
                style: asset.isPositive
                    ? AppTextStyles.labelPositive
                    : AppTextStyles.labelNegative,
              ),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(asset.formattedValue, style: AppTextStyles.bodyMedium),
              const SizedBox(height: 2),
              Text('${asset.holdings} shares', style: AppTextStyles.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}

class _AssetLogo extends StatelessWidget {
  final String label;
  final bool isPositive;

  const _AssetLogo({required this.label, required this.isPositive});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(label, style: AppTextStyles.titleMedium),
        ),
        Positioned(
          bottom: -3,
          right: -3,
          child: Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: isPositive
                  ? AppColors.positiveGain
                  : AppColors.negativeGain,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.background, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
