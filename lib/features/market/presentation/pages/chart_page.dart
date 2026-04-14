import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../data/providers/candle_proviers.dart';
import '../../data/providers/market_providers.dart';
import '../widgets/candlestick_chart.dart';

class ChartPage extends ConsumerWidget {
  final String ticker;
  const ChartPage({super.key, required this.ticker});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final candles = ref.watch(candleDataProvider(ticker));
    final allPrices = ref.watch(marketStateProvider);

    final currentPrice =
        allPrices.maybeWhen(
          data: (map) => map[ticker]?.price,
          orElse: () => null,
        ) ??
        candles.lastOrNull?.close;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.textPrimary,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ticker, style: AppTextStyles.titleMedium),
            Text('30 ngày gần nhất', style: AppTextStyles.bodySmall),
          ],
        ),
        actions: [
          if (currentPrice != null)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${currentPrice.toStringAsFixed(2)}',
                    style: AppTextStyles.titleMedium,
                  ),
                ],
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Candlestick Chart', style: AppTextStyles.titleSmall),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: CandlestickChart(candles: candles),
              ),
              const SizedBox(height: 16),
              Text(
                'Mỗi nến = 1 ngày giao dịch.\n'
                'Xanh (bullish): close > open. Đỏ (bearish): close < open.',
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
