// lib/game/overlays/top_hud.dart
import 'package:code/constants/app_images.dart';
import 'package:code/constants/app_routes.dart';
import 'package:code/game/candy_game.dart';
import 'package:code/logic/cubits/game_cubit.dart';
import 'package:code/ui/theme/app_colors.dart';
import 'package:code/ui/widgets/common/baloo_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopHud extends StatelessWidget {
  const TopHud({this.game, super.key});
  static const id = 'top_hud';

  final CandyGame? game;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
        child: SizedBox(
          height: 59,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _BackButton(),
              const SizedBox(width: 8),
              // SCORE panel
              Expanded(
                child: _ScorePanel(),
              ),
              const SizedBox(width: 12),
              // NEXT panel
              _NextPanel(game: game),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScorePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3.2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(AppImages.scorePanel, fit: BoxFit.contain),
          BlocBuilder<GameCubit, GameState>(
            buildWhen: (p, n) => p.currentScore != n.currentScore,
            builder: (context, state) => BalooText(
              '${state.currentScore}',
              size: BalooSize.button32,
              color: AppColors.white,
              shadow: true,
            ),
          ),
        ],
      ),
    );
  }
}

class _NextPanel extends StatelessWidget {
  const _NextPanel({required this.game});
  final CandyGame? game;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Image.asset(AppImages.nextCandyPanel, fit: BoxFit.contain),
          BlocBuilder<GameCubit, GameState>(
            buildWhen: (p, n) => p.nextCandy != n.nextCandy,
            builder: (context, state) => Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(state.nextCandy.asset, width: 37, height: 37),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    const double size = 40;
    return Semantics(
      button: true,
      label: 'Back',
      child: InkWell(
        onTap: () async {
          await Navigator.of(context).pushReplacementNamed(AppRoutes.mainMenu);
        },
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
