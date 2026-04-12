import 'package:flutter/material.dart';

import '../../../../core/animations/animation_constants.dart';
import '../../../../core/constants/app_colors.dart';

class TradingSpinner extends StatefulWidget {
  final double size;

  const TradingSpinner({super.key, this.size = 56});

  @override
  State<TradingSpinner> createState() => _TradingSpinnerState();
}

class _TradingSpinnerState extends State<TradingSpinner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _arcAnim;
  late final Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AnimationConstants.spinnerLoop,
    )..repeat(reverse: true);

    _arcAnim = Tween<double>(begin: 0, end: 0.9).animate(
      CurvedAnimation(
        parent: _controller,
        curve: AnimationConstants.standardEase,
      ),
    );

    _pulseAnim = Tween<double>(
      begin: 0.65,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: _arcAnim.value,
                strokeWidth: 3,
                backgroundColor: AppColors.surfaceLight,
                valueColor: const AlwaysStoppedAnimation(AppColors.primary),
              ),
              Transform.scale(scale: _pulseAnim.value, child: child),
            ],
          ),
        );
      },
      child: Container(
        width: widget.size * 0.32,
        height: widget.size * 0.32,
        decoration: const BoxDecoration(
          color: AppColors.accent,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
