// path: lib/ui/screens/loading/loading_page.dart
import 'dart:async';
import 'dart:math' show pi;

import 'package:code/constants/app_images.dart';
import 'package:code/constants/app_routes.dart';
import 'package:code/logic/cubits/loading_cubit.dart';
import 'package:code/ui/theme/app_colors.dart';
import 'package:code/ui/theme/app_spacing.dart';
import 'package:code/ui/widgets/common/baloo_text.dart';
import 'package:code/ui/widgets/common/blur_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Loading screen with emblem, label, and animated progress bar.
class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    // Safe: provider lives above this widget (in AppRoutes).
    final c = context.read<LoadingCubit>();
    _ticker = Timer.periodic(const Duration(milliseconds: 60), (t) {
      c.tick(0.01);
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlurBackground(
      background: const AssetImage(AppImages.backgroundMenu),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: Space.hxL,
              child: BlocListener<LoadingCubit, LoadingState>(
                listenWhen: (prev, curr) =>
                    prev.progress < 1.0 && curr.progress >= 1.0,
                listener: (context, state) async {
                  _ticker?.cancel();
                  await Navigator.of(
                    context,
                  ).pushReplacementNamed(AppRoutes.mainMenu);
                },
                child: BlocBuilder<LoadingCubit, LoadingState>(
                  builder: (context, state) {
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final maxWidth = constraints.maxWidth;
                        final emblemSize = (maxWidth * 0.42).clamp(
                          160,
                          320,
                        );
                        final barWidth = (maxWidth * 0.78).clamp(
                          240,
                          520,
                        );
                        final barHeight = (barWidth * 0.18).clamp(
                          28,
                          64,
                        );

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _RotatingImage(
                              size: emblemSize.toDouble(),
                              assetPath: AppImages.candyStatic,
                            ),
                            Space.vL,
                            const BalooText(
                              'LOADING',
                              size: BalooSize.button32,
                              color: AppColors.white,
                              shadow: true,
                            ),
                            Space.vM,
                            _ProgressBar(
                              width: barWidth.toDouble(),
                              height: barHeight.toDouble(),
                              progress: state.progress,
                            ),
                            Space.vL,
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Image-based progress bar using frame & fill assets.
/// The fill is clipped horizontally according to [progress] in [0..1].
class _ProgressBar extends StatelessWidget {
  const _ProgressBar({
    required this.width,
    required this.height,
    required this.progress,
  });

  final double width;
  final double height;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final clamped = progress.clamp(0.0, 1.0);
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImages.progressFrame,
              fit: BoxFit.fill,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(height / 2),
            child: Align(
              alignment: Alignment.centerLeft,
              widthFactor: clamped,
              child: Image.asset(
                AppImages.progressFill,
                scale: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RotatingImage extends StatefulWidget {
  const _RotatingImage({
    required this.size,
    required this.assetPath,
  });

  final double size;
  final String assetPath;

  @override
  State<_RotatingImage> createState() => _RotatingImageState();
}

class _RotatingImageState extends State<_RotatingImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Transform.rotate(
            angle: _controller.value * 4 * pi,
            child: child,
          );
        },
        child: Image.asset(
          widget.assetPath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
