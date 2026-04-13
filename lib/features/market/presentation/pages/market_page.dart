import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/loading_overlay.dart';
import '../../data/providers/market_providers.dart';
import '../widgets/isolate_demo_panel.dart';
import '../widgets/price_ticker_card.dart';
import '../widgets/pulse_indicator.dart';
import '../widgets/stats_panel.dart';

class MarketPage extends ConsumerWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allPrices = ref.watch(marketStateProvider);
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
                child: LoadingOverlay(
                  message: 'compute() đang chạy trong isolate...',
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
                  PulseIndicator(),
                  const SizedBox(width: 4),
                  Text('1s stream', style: AppTextStyles.bodySmall),
                ],
              ),
            ),
          ),

          allPrices.when(
            loading: () => SliverToBoxAdapter(
              child: const Padding(
                padding: EdgeInsets.all(32),
                child: LoadingOverlay(),
              ),
            ),
            error: (err, stack) => SliverToBoxAdapter(
              child: Center(child: Text('Lỗi Stream: $err')),
            ),
            data: (priceMap) {
              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final ticker = priceMap.keys.elementAt(index);
                  final update = priceMap[ticker]!;
                  return PriceTickerCard(update: update);
                }, childCount: priceMap.length),
              );
            },
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
                'Isolate.spawn() - long-lived isolate',
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
