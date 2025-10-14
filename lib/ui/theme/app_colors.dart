// path: lib/ui/theme/app_colors.dart
import 'package:flutter/material.dart';

/// Canonical color tokens (restricted palette from the Visual Guide).
/// Keep all color lookups centralized here.
abstract final class AppColors {
  static const Color primary = Color(0xFF990071); // фіолетово-малиновий
  static const Color white = Color(0xFFFFFFFF);

  // Derived semantic roles (Material 3 mapping will use these).
  static const Color onPrimary = white;
  static const Color surface = white;
  static const Color onSurface = primary;
}
