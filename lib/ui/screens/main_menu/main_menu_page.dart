// path: lib/ui/screens/main_menu/main_menu_page.dart
// ignore_for_file: omit_local_variable_types

import 'package:code/constants/app_images.dart';
import 'package:code/constants/app_routes.dart';
import 'package:code/logic/cubits/main_menu_cubit.dart';
import 'package:code/ui/theme/app_colors.dart';
import 'package:code/ui/theme/app_spacing.dart';
import 'package:code/ui/widgets/common/baloo_text.dart';
import 'package:code/ui/widgets/common/blur_background.dart';
import 'package:code/ui/widgets/common/large_pill_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _MainMenuView();
  }
}
class _MainMenuView extends StatelessWidget {
  const _MainMenuView();

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
              child: BlocBuilder<MainMenuCubit, MainMenuState>(
                builder: (context, state) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final double maxWidth = constraints.maxWidth;
                      final double btnWidth = (maxWidth * 0.72).clamp(220, 520);

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _ScoreBanner(score: state.bestScore),
                          Space.vXL,
                          LargePillButton(
                            width: btnWidth,
                            label: 'PLAY',
                            onTap: () async {
                              await Navigator.of(
                                context,
                              ).pushReplacementNamed(
                                state.isDialogueCompleted
                                    ? AppRoutes.game
                                    : AppRoutes.dialogue,
                              );
                            },
                          ),
                          Space.vL,
                          LargePillButton(
                            width: btnWidth,
                            label: 'INFO',
                            onTap: () =>
                                Navigator.of(context).pushNamed(AppRoutes.info),
                          ),
                          Space.vL,
                          LargePillButton(
                            width: btnWidth,
                            label: 'SETTINGS',
                            onTap: () => Navigator.of(
                              context,
                            ).pushNamed(AppRoutes.settings),
                          ),
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
    );
  }
}

class _ScoreBanner extends StatelessWidget {
  const _ScoreBanner({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          AppImages.mainScoreBanner,
          scale: 2,
        ),
        BalooText(
          '$score',
          size: BalooSize.label40,
          color: AppColors.white,
          shadow: true,
        ),
      ],
    );
  }
}

