import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../data/providers/market_providers.dart';
import '../widgets/isolate_demo_panel.dart';
import '../widgets/price_ticker_card.dart';
import '../widgets/stats_panel.dart';
import '../widgets/trading_spinner.dart';

class MarketPage extends ConsumerWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final priceAsync = ref.watch(priceTickerProvider);
    final statsAsync = ref.watch(portfolioStatsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text('Market', style: AppTextStyles.titleLarge),
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text('Portfolio Stats', style: AppTextStyles.titleSmall),
            ),
          ),
          SliverToBoxAdapter(
            child: statsAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(32),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TradingSpinner(),
                      SizedBox(height: 12),
                      Text('compute() đang chạy trong isolate...'),
                    ],
                  ),
                ),
              ),
              error: (error, stackTrace) => Padding(
                padding: const EdgeInsets.all(16),
                child: Center(child: Text('Lỗi: $error')),
              ),
              data: (stats) => StatsPanel(stats: stats),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Row(
                children: [
                  Text('Live Prices', style: AppTextStyles.titleSmall),
                  const SizedBox(width: 8),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text('1s stream', style: AppTextStyles.bodySmall),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: priceAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: TradingSpinner()),
              ),
              error: (error, stackTrace) => Padding(
                padding: const EdgeInsets.all(16),
                child: Center(child: Text('Stream lỗi: $error')),
              ),
              data: (update) => PriceTickerCard(update: update),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Mỗi giây StreamProvider nhận một PriceUpdate mới.\n'
                'Widget rebuild tự động - không có setState() hay StreamSubscription thủ công.',
                style: AppTextStyles.bodySmall,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Text(
                'Isolate.spawn() – long-lived isolate',
                style: AppTextStyles.titleSmall,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: IsolateDemoPanel()),

          SliverPadding(padding: EdgeInsets.only(bottom: 88)),
        ],
      ),
    );
  }
}
