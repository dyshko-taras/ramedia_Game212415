// path: lib/ui/widgets/common/blur_background.dart
import 'dart:ui';

import 'package:flutter/material.dart';

/// Wraps [child] with a full-screen background image (optional) and a Gaussian blur.
/// Used by Loading, Main Menu, Settings, Info.
class BlurBackground extends StatelessWidget {
  const BlurBackground({
    required this.child,
    super.key,
    this.background,
    this.sigma = 3,
  });

  /// Optional decorative background (e.g., AppImages.backgroundMenu).
  final ImageProvider<Object>? background;

  /// Blur radius (sigma). Kept configurable; tokenization of spacing/durations happens in Phase 7.
  final double sigma;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Widget blurred = BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
      child: child,
    );

    if (background == null) {
      return Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // No background; just blur the content subtree.
          blurred,
        ],
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image(image: background!, fit: BoxFit.cover),
        blurred,
      ],
    );
  }
}
