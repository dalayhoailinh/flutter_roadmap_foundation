import 'package:flutter/material.dart';

import '../../../../core/animations/animation_constants.dart';
import '../../../../core/constants/app_colors.dart';

class PulseIndicator extends StatefulWidget {
  final Color color;
  final double size;

  const PulseIndicator({
    super.key,
    this.color = AppColors.positiveGain,
    this.size = 8,
  });

  @override
  State<PulseIndicator> createState() => _PulseIndicatorState();
}

class _PulseIndicatorState extends State<PulseIndicator>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _glowAnim;
  late final Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AnimationConstants.pulseLoop,
    )..repeat(reverse: true);

    _glowAnim = Tween<double>(
      begin: 0,
      end: 6,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _opacityAnim = Tween<double>(
      begin: 0.55,
      end: 0,
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
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color.withValues(alpha: _opacityAnim.value),
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: 0.5 * _opacityAnim.value),
                blurRadius: _glowAnim.value,
                spreadRadius: _glowAnim.value * 0.4,
              ),
            ],
          ),
        );
      },
    );
  }
}
