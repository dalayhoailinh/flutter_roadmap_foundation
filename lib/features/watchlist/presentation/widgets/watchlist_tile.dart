import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../domain/entities/watchlist_item.dart';

class WatchlistTile extends StatelessWidget {
  final WatchlistItem item;
  final VoidCallback onRemove;

  const WatchlistTile({super.key, required this.item, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider, width: 1)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(item.symbol[0], style: AppTextStyles.titleMedium),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.symbol, style: AppTextStyles.titleMedium),
                const SizedBox(height: 2),
                Text(item.name, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          IconButton(
            onPressed: onRemove,
            icon: const Icon(
              Icons.bookmark_remove_rounded,
              color: AppColors.negativeGain,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}
