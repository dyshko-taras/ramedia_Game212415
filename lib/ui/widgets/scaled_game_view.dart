// lib/ui/widgets/scaled_game_view.dart
import 'package:flutter/widgets.dart';

class ScaledGameView extends StatelessWidget {
  const ScaledGameView({required this.child, super.key});

  final Widget child;

  static const baseWidth = 393.0;
  static const baseHeight = 852.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        child: SizedBox(
          width: baseWidth,
          height: baseHeight,
          child: child,
        ),
      ),
    );
  }
}
