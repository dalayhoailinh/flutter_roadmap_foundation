import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../auth/data/providers/auth_notifier.dart';
import '../../../watchlist/data/providers/portfolio_provider.dart';
import '../../domain/entities/asset.dart';
import '../widgets/asset_list_item.dart';
import '../widgets/balance_card.dart';
import '../widgets/quick_action_row.dart';

class PortfolioPage extends ConsumerWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolioAsync = ref.watch(portfolioProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.background,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.refresh_rounded,
                  color: AppColors.primary,
                ),
                onPressed: () {
                  ref.read(portfolioProvider.notifier).refresh();
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.logout_rounded,
                  color: AppColors.negativeGain,
                ),
                onPressed: () {
                  ref.read(authProvider.notifier).logout();
                },
              ),
            ],
            title: const Text('Portfolio', style: AppTextStyles.titleMedium),
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good morning,',
                            style: AppTextStyles.bodyMedium,
                          ),
                          const SizedBox(height: 2),
                          Text('Investor', style: AppTextStyles.titleMedium),
                        ],
                      ),
                      _AvatarWithBadge(),
                    ],
                  ),
                ),
              ),
            ),
          ),

          portfolioAsync.when(
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, _) => SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline_rounded,
                      color: AppColors.negativeGain,
                      size: 48,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Không tải được dữ liệu',
                      style: AppTextStyles.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => ref.invalidate(portfolioProvider),
                      child: const Text(
                        'Thử lại',
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            data: (assets) => _PortfolioContent(assets: assets),
          ),
        ],
      ),
    );
  }
}

class _PortfolioContent extends StatelessWidget {
  final List<Asset> assets;

  const _PortfolioContent({required this.assets});

  double _totalValue(List<Asset> assets) =>
      assets.fold(0.0, (sum, asset) => sum + asset.totalValue);

  Widget _buildSectionHeader(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTextStyles.titleMedium),
            Text(
              'See all',
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: BalanceCard(
            totalValue: _totalValue(assets),
            totalChangePercent: 2.34,
          ),
        ),
        const SliverToBoxAdapter(child: QuickActionRow()),
        _buildSectionHeader('My Assets'),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => AssetListItem(asset: assets[index]),
            childCount: assets.length,
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }
}

class _AvatarWithBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primary, width: 2),
          ),
          child: const Icon(
            Icons.person_rounded,
            color: AppColors.primary,
            size: 22,
          ),
        ),
        Positioned(
          top: -4,
          right: -4,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: AppColors.positiveGain,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.background, width: 2),
            ),
            child: const Center(
              child: Text(
                '2',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
