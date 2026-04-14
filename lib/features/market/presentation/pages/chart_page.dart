import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../data/providers/candle_proviers.dart';
import '../../data/providers/market_providers.dart';
import '../widgets/candlestick_chart.dart';
import '../widgets/pulse_indicator.dart';

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
              Row(
                children: [
                  const PulseIndicator(),
                  const SizedBox(width: 6),
                  Text('30 ngày gần nhất', style: AppTextStyles.titleSmall),
                  const Spacer(),
                  Text('${candles.length} nến', style: AppTextStyles.bodySmall),
                ],
              ),
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
              Row(
                children: [
                  _LegendItem(
                    color: AppColors.positiveGain,
                    label: 'Tăng (close > open)',
                  ),
                  const SizedBox(width: 20),
                  _LegendItem(
                    color: AppColors.negativeGain,
                    label: 'Giảm (close < open)',
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Mỗi nến biểu diễn 1 ngày giao dịch.\n'
                'Body = khoảng giá giữa Open và Close.\n'
                'Wick = đỉnh (High) và đáy (Low) của phiên.',
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: AppTextStyles.bodySmall),
      ],
    );
  }
}
