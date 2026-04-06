import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                      // Avatar placeholder
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceLight,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.person_rounded,
                          color: AppColors.primary,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Placeholder – BalanceCard
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                '← BalanceCard sẽ ở đây',
                style: TextStyle(color: Colors.white38),
              ),
            ),
          ),

          // Placeholder – QuickActionRow
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '← QuickActionRow sẽ ở đây',
                style: TextStyle(color: Colors.white38),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
