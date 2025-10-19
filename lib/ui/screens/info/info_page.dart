// path: lib/ui/screens/info/info_page.dart
import 'package:code/constants/app_images.dart';
import 'package:code/logic/cubits/info_cubit.dart';
import 'package:code/ui/theme/app_spacing.dart';
import 'package:code/ui/widgets/common/baloo_text.dart';
import 'package:code/ui/widgets/common/blur_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final _controller = ScrollController();
  double _progress = 0; // 0..1 for custom scrollbar

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_controller.hasClients) return;
    final max = _controller.position.maxScrollExtent;
    final px = _controller.position.pixels.clamp(0, max);
    setState(() => _progress = max == 0 ? 0 : px / max);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onScroll)
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button in the top-left corner.
              const Padding(
                padding: EdgeInsets.only(
                  top: Space.s,
                  left: Space.s,
                ),
                child: _BackButton(),
              ),
              // Main panel & content centered.
              Expanded(
                child: Center(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: SizedBox(
                          width: constraints.maxWidth * 0.9,
                          height: constraints.maxHeight * 0.9,
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              // Panel background
                              Image.asset(
                                AppImages.infoPanel,
                                fit: BoxFit.contain,
                              ),

                              // Content
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                  constraints.maxWidth * 0.2,
                                  constraints.maxHeight * 0.15,
                                  constraints.maxWidth * 0.04,
                                  constraints.maxHeight * 0.1,
                                ),
                                child: Row(
                                  children: [
                                    // Scrollable list
                                    Expanded(
                                      child: BlocBuilder<InfoCubit, InfoState>(
                                        builder: (context, state) {
                                          return ListView.separated(
                                            controller: _controller,
                                            padding: EdgeInsets.zero,
                                            itemBuilder: (_, i) => _InfoItem(
                                              item: state.items[i],
                                            ),
                                            separatorBuilder: (_, _) =>
                                                Space.vL,
                                            itemCount: state.items.length,
                                          );
                                        },
                                      ),
                                    ),
                                    Space.hL,

                                    // Custom scrollbar
                                    SizedBox(
                                      width: 16,
                                      child: LayoutBuilder(
                                        builder: (context, c) {
                                          final trackH = c.maxHeight;
                                          const thumbH = 15;
                                          final avail = trackH - thumbH;
                                          final top = avail * _progress;

                                          return Stack(
                                            alignment: Alignment.center,
                                            clipBehavior: Clip.none,
                                            children: [
                                              // Track
                                              Image.asset(
                                                AppImages.scrollBarTrack,
                                                height: trackH,
                                              ),
                                              // Thumb
                                              Positioned(
                                                top: top,
                                                child: Image.asset(
                                                  AppImages.scrollBarThumb,
                                                  fit: BoxFit.contain,
                                                  scale: 2,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Right candy decor
                              Positioned(
                                right: -100,
                                bottom: -180,
                                child: Image.asset(
                                  AppImages.decorCandy3,
                                  width: 250,
                                  fit: BoxFit.contain,
                                ),
                              ),

                              // Left-bottom candy decor
                              Positioned(
                                left: -60,
                                bottom: -100,
                                child: Image.asset(
                                  AppImages.decorCandy1,
                                  width: 200,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    const double size = 56; // tap area; image scales internally
    return Semantics(
      button: true,
      label: 'Back',
      child: InkWell(
        onTap: () => Navigator.of(context).pop(),
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

class _InfoItem extends StatelessWidget {
  const _InfoItem({required this.item});

  final InfoItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  AppImages.infoItemBg,
                  width: 60,
                  height: 60,
                ),
                Image.asset(
                  item.imagePath,
                  width: 48,
                  height: 48,
                ),
              ],
            ),
            Space.hS,
            BalooText(
              item.title,
              size: BalooSize.caption20,
              shadow: true,
            ),
          ],
        ),
        Text(
          item.description,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
