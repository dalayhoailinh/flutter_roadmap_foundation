import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class WebUnsupportedPanel extends StatelessWidget {
  final String featureName;
  final String reason;

  const WebUnsupportedPanel({
    super.key,
    required this.featureName,
    this.reason = 'This feature is not supported on web platforms.',
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(
              Icons.web_asset_off_rounded,
              color: AppColors.textSecondary,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(featureName, style: AppTextStyles.titleSmall),
                  const SizedBox(height: 4),
                  Text(reason, style: AppTextStyles.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
