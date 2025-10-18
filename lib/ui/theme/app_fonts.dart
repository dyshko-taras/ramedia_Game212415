// path: lib/ui/theme/app_fonts.dart
import 'package:flutter/material.dart';

/// Baloo font & text-size tokens from the Visual Guide.
abstract final class AppFonts {
  static const String family = 'Baloo';
}

abstract final class FontSizes {
  static const double score64 = 64;
  static const double label40 = 40;
  static const double button32 = 32;
  static const double dialog24 = 24;
  static const double caption20 = 20;
  static const double dialogLong14 = 14;
  static const double info10 = 10;
}

TextStyle baloo(
  double size, {
  Color? color,
  double? height,
  List<Shadow>? shadows,
}) {
  return TextStyle(
    fontFamily: AppFonts.family,
    fontSize: size,
    fontWeight: FontWeight.w400,
    color: color,
    height: height,
    shadows: shadows,
  );
}
