import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../data/providers/market_providers.dart';
import '../../data/providers/realtime_candle_provider.dart';
import '../../domain/entities/candle_interval.dart';
import '../widgets/candlestick_chart.dart';
import '../widgets/pulse_indicator.dart';

class ChartPage extends ConsumerStatefulWidget {
  final String ticker;
  const ChartPage({super.key, required this.ticker});

  @override
  ConsumerState<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends ConsumerState<ChartPage> {
  CandleInterval _selectedInterval = CandleInterval.oneMin;

  @override
  Widget build(BuildContext context) {
    final candles = ref.watch(
      realtimeCandleProvider((
        ticker: widget.ticker,
        interval: _selectedInterval,
      )),
    );

    final allPrices = ref.watch(marketStateProvider);
    final currentPrice =
        allPrices.maybeWhen(
          data: (map) => map[widget.ticker]?.price,
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
            Text(widget.ticker, style: AppTextStyles.titleMedium),
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
      body: Column(
        children: [
          _IntervalFilterBar(
            selected: _selectedInterval,
            onChanged: (interval) {
              setState(() => _selectedInterval = interval);
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const PulseIndicator(),
                        const SizedBox(width: 6),
                        Text(
                          'Live · ${_selectedInterval.label}',
                          style: AppTextStyles.titleSmall,
                        ),
                        const Spacer(),
                        Text(
                          '${candles.length} nến',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.fromLTRB(12, 12, 4, 12),
                      child: candles.isEmpty
                          ? _EmptyChartState(interval: _selectedInterval)
                          : CandlestickChart(candles: candles),
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
          ),
        ],
      ),
    );
  }
}

class _IntervalFilterBar extends StatelessWidget {
  final CandleInterval selected;
  final ValueChanged<CandleInterval> onChanged;

  const _IntervalFilterBar({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: CandleInterval.values.map((interval) {
          final isSelected = interval == selected;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => onChanged(interval),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  interval.label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                    color: isSelected
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _EmptyChartState extends StatelessWidget {
  final CandleInterval interval;

  const _EmptyChartState({required this.interval});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 280,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.hourglass_top_rounded,
              color: AppColors.textSecondary,
              size: 32,
            ),
            SizedBox(height: 8),
            Text(
              'Đang thu thập dữ liệu...',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),
            SizedBox(height: 4),
            Text(
              'Nến sẽ xuất hiện sau vài giây',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
          ],
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
