import 'package:flutter/material.dart';

import '../../features/market/presentation/widgets/trading_spinner.dart';
import '../constants/app_colors.dart';

class LoadingOverlay extends StatelessWidget {
  final String? message;
  final double spinnerSize;

  const LoadingOverlay({super.key, this.message, this.spinnerSize = 56});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TradingSpinner(size: spinnerSize),
          if (message != null)
            Text(
              message!,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
        ],
      ),
    );
  }
}
