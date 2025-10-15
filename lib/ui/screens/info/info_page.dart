// path: lib/ui/screens/info/info_page.dart
import 'dart:math' as math;

import 'package:code/constants/app_images.dart';
import 'package:code/ui/theme/app_colors.dart';
import 'package:code/ui/theme/app_spacing.dart';
import 'package:code/ui/widgets/common/baloo_text.dart';
import 'package:code/ui/widgets/common/blur_background.dart';
import 'package:flutter/material.dart';

/// Info screen:
/// - Blurred background
/// - Central info panel with title
/// - Scrollable items (icon + title + paragraph)
/// - Custom right-side scrollbar (track + thumb)
/// - Back button and decorative candies
///
/// Images rule: every Image.asset uses `scale: 2`; size comes from parents.
class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final _controller = ScrollController();
  double _thumbTop = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateThumb);
  }

  void _updateThumb() {
    if (!_controller.hasClients) return;
    final maxExtent = _controller.position.maxScrollExtent;
    final pixels = _controller.position.pixels.clamp(0.0, maxExtent);
    final progress = maxExtent == 0 ? 0.0 : (pixels / maxExtent);
    setState(() {
      _thumbTop = progress; // normalized; actual px computed in layout
    });
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_updateThumb)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlurBackground(
      background: const AssetImage(AppImages.backgroundMenu),
      sigma: 16,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: Space.hxL,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final maxWidth = constraints.maxWidth;
                  // final panelWidth = (maxWidth * 0.84).clamp(280, 560);
                  // final panelHeight = (panelWidth * 1.32).clamp(
                  //   420,
                  //   820,
                  // );
                  const panelWidth = 372.0;
                  const panelHeight = 652.0;

                  return SizedBox(
                    width: panelWidth,
                    height: panelHeight,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Panel background
                        Positioned.fill(
                          child: Image.asset(
                            AppImages.infoPanel,
                            fit: BoxFit.fill,
                            scale: 2,
                          ),
                        ),

                        // Title
                        const Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(top: 24),
                            child: BalooText(
                              'INFO',
                              size: BalooSize.button32,
                              color: AppColors.white,
                              shadow: true,
                            ),
                          ),
                        ),

                        // Right candy decor (foreground)
                        Positioned(
                          right: -panelWidth * 0.04,
                          top: panelHeight * 0.38,
                          width: panelWidth * 0.08, // thin stick + candy
                          child: Image.asset(
                            AppImages.scrollBarTrack, // visual pole-like decor
                            fit: BoxFit.contain,
                            scale: 2,
                          ),
                        ),

                        // Left-bottom decor candy
                        Positioned(
                          left: -panelWidth * 0.15,
                          bottom: -panelHeight * 0.02,
                          width: panelWidth * 0.40,
                          child: Image.asset(
                            AppImages.decorCandy1,
                            fit: BoxFit.contain,
                            scale: 2,
                          ),
                        ),

                        // Right-bottom decor candy
                        Positioned(
                          right: -panelWidth * 0.02,
                          bottom: -panelHeight * 0.00,
                          width: panelWidth * 0.35,
                          child: Image.asset(
                            AppImages.decorCandy2,
                            fit: BoxFit.contain,
                            scale: 2,
                          ),
                        ),

                        // Scrollable content + custom scrollbar
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            panelWidth * 0.08,
                            panelHeight * 0.18,
                            panelWidth * 0.15, // leave room for scrollbar
                            panelHeight * 0.08,
                          ),
                          child: _ScrollableInfoList(
                            controller: _controller,
                            onPainted: (thumbAreaHeight, thumbHeight) {
                              // Recompute px offset when first laid out
                              _updateThumb();
                            },
                          ),
                        ),

                        // Custom scrollbar (track + thumb) attached to right inset
                        Positioned(
                          right: panelWidth * 0.06,
                          top: panelHeight * 0.22,
                          width: panelWidth * 0.04,
                          height: panelHeight * 0.60,
                          child: _ScrollBar(
                            controller: _controller,
                            progress: _thumbTop,
                          ),
                        ),

                        // Back button (top-left outside content)
                        Positioned(
                          left: Space.s,
                          top: Space.s,
                          child: _BackButton(
                            onTap: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const double size = 56;
    return Semantics(
      button: true,
      label: 'Back',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(size / 2),
        child: Ink(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size / 2),
          ),
          child: Image.asset(
            AppImages.btnBack,
            fit: BoxFit.contain,
            scale: 2,
          ),
        ),
      ),
    );
  }
}

class _ScrollableInfoList extends StatelessWidget {
  const _ScrollableInfoList({
    required this.controller,
    required this.onPainted,
  });

  final ScrollController controller;
  final void Function(double thumbAreaHeight, double thumbHeight) onPainted;

  @override
  Widget build(BuildContext context) {
    // Demo items per PRD assets. Texts are in English per mock (can localize later).
    const items = <(_CandyAsset, String, String)>[
      (
        _CandyAsset(AppImages.candyBlueSwirl),
        'BLUE SWIRL\nCANDY',
        'ONE INTERESTING FACT IS THAT ITS OCEAN-LIKE WAVES SYMBOLIZE ENDLESS SWEETNESS, MAKING IT FEEL LIKE DIVING INTO A SEA OF SUGAR',
      ),
      (
        _CandyAsset(AppImages.candyPinkSwirl),
        'PINK SWIRL\nCANDY',
        'ONE INTERESTING FACT IS THAT GIANT PINK SWIRLS WERE ONCE CARNIVAL CLASSICS, CRAFTED TO LOOK AS FUN AS THEY TASTE',
      ),
      (
        _CandyAsset(AppImages.candySkyBlue),
        'SKY BLUE\nCANDY',
        'ONE INTERESTING FACT IS THAT BLUE SWEETS CAN TRICK YOUR TASTE BUDS — MANY ARE BERRY-FLAVORED, NOT BLUEBERRY',
      ),
    ];

    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (n) {
        // layout info for thumb can be derived here if needed
        onPainted(0, 0);
        return false;
      },
      child: SizeChangedLayoutNotifier(
        child: ListView.separated(
          controller: controller,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final (asset, title, body) = items[index];
            return _InfoItem(
              iconAssetPath: asset.path,
              title: title,
              body: body,
            );
          },
          separatorBuilder: (_, __) => Space.vL,
          itemCount: items.length,
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.iconAssetPath,
    required this.title,
    required this.body,
  });

  final String iconAssetPath;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    const double iconSide = 96; // parent size; image itself uses scale:2

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Rounded square icon background + candy image
        SizedBox(
          width: iconSide,
          height: iconSide,
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    AppImages.infoItemBg,
                    fit: BoxFit.cover,
                    scale: 2,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: Space.aS,
                  child: Image.asset(
                    iconAssetPath,
                    fit: BoxFit.contain,
                    scale: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
        Space.hL,
        // Title + paragraph
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BalooText(
                title,
                size: BalooSize.dialog24,
                color: AppColors.white,
                shadow: true,
              ),
              Space.vS,
              // Paragraph text style – use a simpler Text to allow wrapping
              Text(
                body,
                style: const TextStyle(
                  fontFamily: 'Baloo', // per visual style
                  fontSize: 14,
                  height: 1.4,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ScrollBar extends StatelessWidget {
  const _ScrollBar({
    required this.controller,
    required this.progress,
  });

  final ScrollController controller;
  final double progress; // 0..1

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final trackHeight = c.maxHeight;
        final thumbHeight = math.max(32, trackHeight * 0.18);
        final available = trackHeight - thumbHeight;
        final top = available * progress;

        return Stack(
          children: [
            // Track
            Positioned.fill(
              child: Image.asset(
                AppImages.scrollBarTrack,
                fit: BoxFit.fill,
                scale: 2,
              ),
            ),
            // Thumb
            Positioned(
              top: top,
              left: 0,
              right: 0,
              height: thumbHeight.toDouble(),
              child: Image.asset(
                AppImages.scrollBarThumb,
                fit: BoxFit.contain,
                scale: 2,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CandyAsset {
  const _CandyAsset(this.path);
  final String path;
}
