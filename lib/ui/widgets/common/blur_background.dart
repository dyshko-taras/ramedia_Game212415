// path: lib/ui/widgets/common/blur_background.dart
import 'dart:ui';

import 'package:flutter/material.dart';

/// Used by Loading, Main Menu, Settings, Info.
class BlurBackground extends StatelessWidget {
  const BlurBackground({
    required this.child,
    super.key,
    this.background,
    this.sigma = 3,
  });

  final ImageProvider<Object>? background;

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
