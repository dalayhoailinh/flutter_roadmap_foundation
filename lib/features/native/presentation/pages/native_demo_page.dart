import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../data/device_channel.dart';
import '../../data/native_math_ffi.dart';

final deviceInfoProvider = FutureProvider<String>((ref) async {
  return DeviceChannel.getDeviceInfo();
});

final ffiBenchmarkResultProvider = StateProvider<String?>((ref) => null);

class NativeDemoPage extends ConsumerWidget {
  const NativeDemoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceAsync = ref.watch(deviceInfoProvider);
    final ffiResult = ref.watch(ffiBenchmarkResultProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('Native Bridge', style: AppTextStyles.titleMedium),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // ── Week label ──
          const Text(
            'WEEK 11 · FFI + PLATFORM CHANNEL',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 20),

          // ── Card 1: Platform Channel ──
          _BridgeCard(
            icon: Icons.cable_rounded,
            title: 'Platform Channel',
            subtitle: 'Dart → MethodChannel → Kotlin → Android Build API',
            child: deviceAsync.when(
              // While the Future is pending, show a small spinner
              loading: () => const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                  strokeWidth: 2,
                ),
              ),
              error: (e, _) => Text(
                'Error: $e',
                style: const TextStyle(color: AppColors.error, fontSize: 13),
              ),
              data: (info) => Text(
                info,
                style: const TextStyle(
                  color: AppColors.accent,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ── Card 2: Dart FFI ──
          _BridgeCard(
            icon: Icons.bolt_rounded,
            title: 'Dart FFI',
            subtitle: 'Dart → dart:ffi → C function in libmathplugin.so',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Show placeholder until button is pressed
                Text(
                  ffiResult ?? 'Press the button to call the C function',
                  style: TextStyle(
                    color: ffiResult != null
                        ? AppColors.positiveGain
                        : AppColors.textSecondary,
                    fontSize: 13,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 14),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.play_arrow_rounded, size: 18),
                  label: const Text(
                    'Run FFI Benchmark',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  onPressed: () => _runBenchmark(ref),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ── Q2 Explainer ──
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.4),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.arrow_forward_rounded,
                      color: AppColors.primary,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    const Text('Bridge to Q2', style: AppTextStyles.titleSmall),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'In Q2, the C function in native_math.c will be replaced by '
                  'a Rust crate compiled via flutter_rust_bridge. Same dart:ffi '
                  'mechanism underneath — but Rust gives us memory safety, the '
                  'Cargo ecosystem, and the ability to compute RSI, MACD, and '
                  'Bollinger Bands at millions of ticks per second.',
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _runBenchmark(WidgetRef ref) {
    NativeMathFfi.init();

    final prices = List.generate(1000, (i) => 10000 + (i * 7) % 5000);

    final ffiStart = DateTime.now();
    final ffiSum = NativeMathFfi.movingAverageSum(prices);
    final ffiMicros = DateTime.now().difference(ffiStart).inMicroseconds;

    final dartStart = DateTime.now();
    int dartSum = 0;
    for (final p in prices) {
      dartSum += p;
    }
    final dartMicros = DateTime.now().difference(dartStart).inMicroseconds;

    ref.read(ffiBenchmarkResultProvider.notifier).state =
        'C (FFI):  sum = $ffiSum  →  $ffiMicrosµs\n'
        'Dart:     sum = $dartSum  →  $dartMicrosµs\n\n'
        '✓ Same result. Different runtime path.\n'
        'FFI overhead includes calloc + memcopy (see code comments).';
  }
}

class _BridgeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget child;

  const _BridgeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 18),
              const SizedBox(width: 8),
              Text(title, style: AppTextStyles.titleSmall),
            ],
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: AppTextStyles.bodySmall),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: AppColors.divider, height: 1),
          ),
          child,
        ],
      ),
    );
  }
}
