import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/candle_data.dart';

class CandlestickPainter extends CustomPainter {
  final List<CandleData> data;

  const CandlestickPainter({required this.data});

  static const double _rightAxisWidth = 64.0;
  static const double _paddingTop = 16.0;
  static const double _paddingBottom = 8.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final chartWidth = size.width - _rightAxisWidth;
    final chartHeight = size.height - _paddingTop - _paddingBottom;
    final chartTop = _paddingTop;

    final allLows = data.map((c) => c.low);
    final allHighs = data.map((c) => c.high);
    final rawMin = allLows.reduce(min);
    final rawMax = allHighs.reduce(max);
    final rangePadding = (rawMax - rawMin) * 0.08;
    final displayMin = rawMin - rangePadding;
    final displayMax = rawMax + rangePadding;
    final priceRange = displayMax - displayMin;

    double priceToY(double price) {
      return chartTop + (displayMax - price) / priceRange * chartHeight;
    }

    final columnWidth = chartWidth / data.length;
    final bodyWidth = (columnWidth * 0.6).clamp(2.0, 18.0);
    final bodyPaint = Paint();

    const int gridCount = 5;
    final gridPaint = Paint()
      ..color = AppColors.divider
      ..strokeWidth = 1.0;

    for (int g = 0; g <= gridCount; g++) {
      final y = chartTop + (g / gridCount) * chartHeight;
      canvas.drawLine(Offset(0, y), Offset(chartWidth, y), gridPaint);
    }

    final wickPaint = Paint()..strokeWidth = 1.0;

    for (int i = 0; i < data.length; i++) {
      final candle = data[i];
      final isUp = candle.close >= candle.open;
      bodyPaint.color = isUp ? AppColors.positiveGain : AppColors.negativeGain;

      final centerX = i * columnWidth + columnWidth / 2;
      final bodyLeft = centerX - bodyWidth / 2;

      final openY = priceToY(candle.open);
      final closeY = priceToY(candle.close);

      final bodyTop = min(openY, closeY);
      final bodyBottom = max(openY, closeY);
      final bodyHeight = (bodyBottom - bodyTop).clamp(1.0, double.infinity);
      final highY = priceToY(candle.high);
      final lowY = priceToY(candle.low);

      wickPaint.color = isUp ? AppColors.positiveGain : AppColors.negativeGain;
      canvas.drawLine(
        Offset(centerX, highY),
        Offset(centerX, bodyTop),
        wickPaint,
      );
      canvas.drawLine(
        Offset(centerX, bodyBottom),
        Offset(centerX, lowY),
        wickPaint,
      );

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(bodyLeft, bodyTop, bodyWidth, bodyHeight),
          const Radius.circular(2.0),
        ),
        bodyPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CandlestickPainter oldDelegate) {
    return oldDelegate.data != data;
  }
}
