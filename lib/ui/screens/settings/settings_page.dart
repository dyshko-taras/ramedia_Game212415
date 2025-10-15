// path: lib/ui/screens/settings/settings_page.dart
// ignore_for_file: omit_local_variable_types

import 'package:code/constants/app_images.dart';
import 'package:code/constants/app_routes.dart';
import 'package:code/logic/cubits/settings_cubit.dart';
import 'package:code/ui/theme/app_colors.dart';
import 'package:code/ui/theme/app_spacing.dart';
import 'package:code/ui/widgets/common/baloo_text.dart';
import 'package:code/ui/widgets/common/blur_background.dart';
import 'package:code/ui/widgets/common/large_pill_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Settings screen:
/// - Panel background (settings_panel.png)
/// - SOUND checkbox (checkbox_checked / checkbox_unchecked)
/// - HARDNESS slider (slider_track / slider_thumb) with 1..5 steps
/// - OK button (LargePillButton) that closes the screen
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: Space.hxL,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double maxWidth = constraints.maxWidth;

                  // Panel scales with screen width.
                  final double panelWidth = (maxWidth * 0.84).clamp(280, 560);
                  final double panelHeight = (panelWidth * 1.22).clamp(
                    360,
                    720,
                  );

                  return SizedBox(
                    width: panelWidth,
                    height: panelHeight,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Panel background
                        Positioned.fill(
                          child: Image.asset(
                            AppImages.settingsPanel,
                            fit: BoxFit.fill,
                          ),
                        ),

                        // Content
                        Padding(
                          padding: Space.aL,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const BalooText(
                                'SETTINGS',
                                size: BalooSize.button32,
                                color: AppColors.white,
                                shadow: true,
                              ),
                              Space.vXL,

                              // SOUND row
                              const _SoundRow(),
                              Space.vXL,

                              // HARDNESS + slider
                              const BalooText(
                                'HARDNESS',
                                size: BalooSize.button32,
                                color: AppColors.white,
                                shadow: true,
                              ),
                              Space.vM,
                              _HardnessSlider(
                                width: panelWidth * 0.78,
                                height: (panelWidth * 0.14).clamp(28, 64),
                              ),

                              const Spacer(),
                              // OK button
                              LargePillButton(
                                width: panelWidth * 0.48,
                                label: 'OK',
                                onTap: () async{
                                  await context.read<SettingsCubit>().save();
                                  await Navigator.of(
                                    context,
                                  ).pushReplacementNamed(AppRoutes.mainMenu);
                                },
                              ),
                            ],
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
    const double size = 44;
    return Semantics(
      button: true,
      label: checked ? 'Sound on' : 'Sound off',
      child: InkWell(
        onTap: () => onChanged(!checked),
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          width: size,
          height: size,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Image.asset(
            checked ? AppImages.checkboxChecked : AppImages.checkboxUnchecked,
            fit: BoxFit.contain,
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
        final double trackPadding = height * 0.28;
        final double thumbSize = height * 0.62;
        final double usable = width - (trackPadding * 2);
        const int steps = max - min;
        final double stepW = usable / steps;
        final int index = (state.hardness - min).clamp(0, steps);
        final double thumbLeft = trackPadding + index * stepW - (thumbSize / 2);

        void setFromLocalDx(double localDx) {
          // Convert local x to step index
          final double x = (localDx - trackPadding).clamp(0, usable);
          final int newIndex = (x / stepW).round().clamp(0, steps);
          final int value = min + newIndex;
          context.read<SettingsCubit>().setHardness(value);
        }

        return SizedBox(
          width: width,
          height: height,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Track
              Positioned.fill(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTapDown: (d) => setFromLocalDx(d.localPosition.dx),
                  onHorizontalDragUpdate: (d) =>
                      setFromLocalDx(d.localPosition.dx),
                  child: Image.asset(
                    AppImages.sliderTrack,
                    fit: BoxFit.fill,
                  ),
                ),
              ),

              // Tick marks (visual guides between steps)
              Positioned.fill(
                child: IgnorePointer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      steps + 1,
                      (_) => Container(
                        width: 2,
                        height: height * 0.38,
                        margin: EdgeInsets.symmetric(vertical: height * 0.31),
                        color: Colors.white.withOpacity(0.20),
                      ),
                    ),
                  ),
                ),
              ),

              // Thumb
              Positioned(
                left: thumbLeft,
                top: (height - thumbSize) / 2,
                child: IgnorePointer(
                  child: Image.asset(
                    AppImages.sliderThumb,
                    width: thumbSize,
                    height: thumbSize,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
