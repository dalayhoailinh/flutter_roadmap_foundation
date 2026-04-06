import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../data/providers/watchlist_notifier.dart';
import '../../domain/entities/watchlist_item.dart';
import '../widgets/watchlist_tile.dart';

class WatchlistPage extends ConsumerWidget {
  const WatchlistPage({super.key});

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController symbolController = TextEditingController();
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Thêm cổ phiếu', style: AppTextStyles.titleMedium),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: symbolController,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: const InputDecoration(
                labelText: 'Symbol (vd: TSLA)',
                labelStyle: TextStyle(color: AppColors.textSecondary),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.divider),
                ),
              ),
              textCapitalization: TextCapitalization.characters,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: nameController,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: const InputDecoration(
                labelText: 'Tên công ty',
                labelStyle: TextStyle(color: AppColors.textSecondary),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.divider),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(
              'Hủy',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () {
              final symbol = symbolController.text.trim().toUpperCase();
              final name = nameController.text.trim();
              if (symbol.isNotEmpty && name.isNotEmpty) {
                ref
                    .read(watchlistProvider.notifier)
                    .addItem(WatchlistItem(symbol: symbol, name: name));
              }
              Navigator.of(dialogContext).pop();
            },
            child: const Text(
              'Thêm',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchlist = ref.watch(watchlistProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('Watchlist', style: AppTextStyles.titleMedium),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded, color: AppColors.primary),
            onPressed: () => _showAddDialog(context, ref),
          ),
        ],
      ),
      body: watchlist.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.bookmark_border_rounded,
                    size: 48,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Chưa có cổ phiết theo dõi',
                    style: AppTextStyles.bodyMedium,
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: watchlist.length,
              itemBuilder: (context, index) {
                final item = watchlist[index];
                return WatchlistTile(
                  item: item,
                  onRemove: () => ref
                      .read(watchlistProvider.notifier)
                      .removeItem(item.symbol),
                );
              },
            ),
    );
  }
}
