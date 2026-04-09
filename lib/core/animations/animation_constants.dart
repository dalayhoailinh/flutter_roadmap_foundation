import 'package:flutter/material.dart';

abstract final class AnimationConstants {
  static const Duration spinnerLoop = Duration(milliseconds: 1400);
  static const Duration pulseLoop = Duration(milliseconds: 1600);
  static const Duration priceFlash = Duration(milliseconds: 700);
  static const Curve standardEase = Curves.easeInOutCubic;
  static const Curve flashEase = Curves.easeOut;
}
