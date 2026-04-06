import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../portfolio/domain/entities/asset.dart';

class PortfolioAsyncNotifier extends AsyncNotifier<List<Asset>> {
  @override
  Future<List<Asset>> build() async {
    await Future.delayed(const Duration(milliseconds: 900));
    return mockAssets;
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(milliseconds: 600));
      return mockAssets;
    });
  }
}

final portfolioProvider =
    AsyncNotifierProvider<PortfolioAsyncNotifier, List<Asset>>(
      PortfolioAsyncNotifier.new,
    );
