// path: lib/ui/screens/settings/settings_page.dart
import 'package:code/constants/app_images.dart';
import 'package:code/constants/app_routes.dart';
import 'package:code/logic/cubits/settings_cubit.dart';
import 'package:code/ui/theme/app_colors.dart';
import 'package:code/ui/theme/app_spacing.dart';
import 'package:code/ui/widgets/common/baloo_text.dart';
import 'package:code/ui/widgets/common/blur_background.dart';
import 'package:code/ui/widgets/common/small_pill_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsCubit>(
      create: (_) => SettingsCubit(),
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    return BlurBackground(
      background: const AssetImage(AppImages.backgroundMenu),
      sigma: 16,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: [
              // Back button in the top-left corner.
              Positioned(
                left: Space.s,
                top: Space.s,
                child: _BackButton(
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
              // Main panel & content centered.
              Center(
                child: Padding(
                  padding: Space.hxL,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      const panelWidth = 370;
                      const panelHeight = 373;

                      return SizedBox(
                        width: panelWidth.toDouble(),
                        height: panelHeight.toDouble(),
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            // Panel background (fills by constraints)
                            Image.asset(
                              AppImages.settingsPanel,
                              fit: BoxFit.fill,
                              scale: 2,
                            ),

                            // Content
                            Padding(
                              padding: Space.aL,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Spacer(),

                                  // SOUND row
                                  const _SoundRow(),
                                  Space.vS,

                                  // HARDNESS + slider
                                  const BalooText(
                                    'HARDNESS',
                                    size: BalooSize.button32,
                                    color: AppColors.white,
                                    shadow: true,
                                  ),
                                  Space.vS,
                                  _HardnessSlider(
                                    width: panelWidth * 0.78,
                                    height: (panelWidth * 0.14).clamp(28, 64),
                                  ),

                                  Space.vS,
                                  // OK button — small pill
                                  SmallPillButton(
                                    label: 'OK',
                                    onTap: () async {
                                      await context
                                          .read<SettingsCubit>()
                                          .save();
                                      await Navigator.of(
                                        context,
                                      ).pushReplacementNamed(
                                        AppRoutes.mainMenu,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            // Right candy decor
                            Positioned(
                              right: -panelWidth * 0.15,
                              top: panelHeight * 0.36,
                              width: panelWidth * 0.40,
                              child: Image.asset(
                                AppImages.decorCandy2,
                                fit: BoxFit.contain,
                                scale: 2,
                              ),
                            ),

                            // Left-bottom candy decor
                            Positioned(
                              left: -panelWidth * 0.20,
                              bottom: -panelHeight * 0.05,
                              width: panelWidth * 0.5,
                              child: Image.asset(
                                AppImages.decorCandy1,
                                fit: BoxFit.contain,
                                scale: 2,
                              ),
                            ),
                          ],
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
  const _BackButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const double size = 56; // tap area; image scales internally
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

class _SoundRow extends StatelessWidget {
  const _SoundRow();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const BalooText(
              'SOUND',
              size: BalooSize.button32,
              color: AppColors.white,
              shadow: true,
            ),
            Space.hL,
            _ImageCheckbox(
              checked: state.soundOn,
              onChanged: (_) => context.read<SettingsCubit>().toggleSound(),
            ),
          ],
        );
      },
    );
  }
}

class _ImageCheckbox extends StatelessWidget {
  const _ImageCheckbox({required this.checked, required this.onChanged});

  final bool checked;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    const double tapSize = 44; // tap target; image uses scale:2
    return Semantics(
      button: true,
      label: checked ? 'Sound on' : 'Sound off',
      child: InkWell(
        onTap: () => onChanged(!checked),
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          width: tapSize,
          height: tapSize,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Image.asset(
            checked ? AppImages.checkboxChecked : AppImages.checkboxUnchecked,
            fit: BoxFit.contain,
            scale: 2,
            gaplessPlayback: true,
          ),
        ),
      ),
    );
  }
}

class _HardnessSlider extends StatelessWidget {
  const _HardnessSlider({required this.width, required this.height});
  final double width;
  final double height;

  static const int min = 1;
  static const int max = 5;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (p, n) => p.hardness != n.hardness,
      builder: (context, state) {
        const backWidth = 176.0;
        const trackWidth = 160.0;
        const thumbWidth = 15.0;

        const trackOffset = trackWidth / 2;

        final progress = ((state.hardness - min) / (max - min)).clamp(0.0, 1.0);

        final thumbLeft =
            (width / 2) -
            trackOffset +
            (trackWidth * progress) -
            (thumbWidth / 2);

        void updateHardness(double globalDx, BuildContext context) {
          final box = context.findRenderObject()! as RenderBox;
          final localDx = box.globalToLocal(Offset(globalDx, 0)).dx;
          final trackStart = (width / 2) - trackOffset;
          final clampedX = (localDx - trackStart).clamp(0.0, trackWidth);
          final newProgress = clampedX / trackWidth;
          final newValue = (min + newProgress * (max - min)).round().clamp(
            min,
            max,
          );
          context.read<SettingsCubit>().setHardness(newValue);
        }

        return SizedBox(
          width: width,
          height: height,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (d) => updateHardness(d.globalPosition.dx, context),
            onHorizontalDragUpdate: (d) =>
                updateHardness(d.globalPosition.dx, context),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Backplate
                Image.asset(
                  AppImages.sliderBack,
                  width: backWidth,
                  height: 33,
                ),

                ClipRect(
                  clipper: _ProgressClipper(progress),
                  child: Image.asset(
                    AppImages.sliderTrack,
                    width: trackWidth,
                    height: 20,
                  ),
                ),

                // Thumb
                Positioned(
                  left: thumbLeft,
                  child: IgnorePointer(
                    child: Image.asset(
                      AppImages.sliderThumb,
                      width: thumbWidth,
                      height: 26,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProgressClipper extends CustomClipper<Rect> {
  const _ProgressClipper(this.progress);
  final double progress;

  @override
  Rect getClip(Size size) =>
      Rect.fromLTRB(0, 0, size.width * progress, size.height);

  @override
  bool shouldReclip(_ProgressClipper old) => old.progress != progress;
}
