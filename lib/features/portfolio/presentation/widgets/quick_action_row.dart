import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const QuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MaterialButton(
          onPressed: onTap,
          clipBehavior: Clip.antiAlias,
          height: 52,
          minWidth: 52,
          color: AppColors.surfaceLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: AppColors.divider),
          ),
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        const SizedBox(height: 6),
        Text(label, style: AppTextStyles.bodySmall),
      ],
    );
  }
}

class QuickActionRow extends StatelessWidget {
  const QuickActionRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          QuickActionButton(
            icon: Icons.add_rounded,
            label: 'Deposit',
            onTap: () {},
          ),
          QuickActionButton(
            icon: Icons.remove_rounded,
            label: 'Withdraw',
            onTap: () {},
          ),
          QuickActionButton(
            icon: Icons.swap_horiz_rounded,
            label: 'Trade',
            onTap: () {},
          ),
          QuickActionButton(
            icon: Icons.bar_chart_rounded,
            label: 'Analysis',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
