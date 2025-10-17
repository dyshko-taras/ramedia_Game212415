// lib/ui/screens/game/game_page.dart
import 'package:code/constants/app_images.dart';
import 'package:code/game/model/candy_type.dart';
import 'package:code/game/candy_game.dart';
import 'package:flame/game.dart';
import 'package:code/game/overlays/top_hud.dart';
import 'package:code/game/overlays/lose_dialog.dart';
import 'package:code/game/overlays/win_dialog.dart';
import 'package:code/logic/cubits/game_cubit.dart';
import 'package:code/ui/widgets/common/blur_background.dart';
import 'package:code/ui/widgets/scaled_game_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late final GameCubit _cubit;
  late final CandyGame _game;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<GameCubit>();
    _game = CandyGame()..bindContext(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlurBackground(
      background: const AssetImage(AppImages.backgroundGame),
      sigma: 0,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: ScaledGameView(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: (d) =>
                  context.read<GameCubit>().onTapAt(d.localPosition.dx),
              child: Stack(
                children: [
                  // Game canvas (Flame)
                  GameWidget(
                    game: _game,
                    backgroundBuilder: (_) => const SizedBox.shrink(),
                  ),
                // For now, show only HUD driven by GameCubit (no GameWidget)
                const TopHud(),

                // Tap hint layer (centered)
                const _TapHintLayer(),

                // Win / Lose dialogs driven by cubit
                const _OutcomeLayer(),

                // Bottom palette (decor only)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 320,
                    height: 186,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          AppImages.candiesBar,
                          fit: BoxFit.contain,
                        ),
                        const _PaletteIconsRow(),
                      ],
                    ),
                  ),
                ),

                // No game outcome overlays for now
              ],
            ),
          ),
          ),
        ),
      ),
    );
  }
}

class _TapHintLayer extends StatelessWidget {
  const _TapHintLayer();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<GameCubit, GameState, GameUiPhase>(
      selector: (s) => s.phase,
      builder: (context, phase) {
        if (phase != GameUiPhase.hint) return const SizedBox.shrink();
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'TAP TO ANY PLACE',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Image.asset(
                AppImages.tapHintHand,
                width: 120,
                fit: BoxFit.contain,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _OutcomeLayer extends StatelessWidget {
  const _OutcomeLayer();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      buildWhen: (p, n) => p.outcome != n.outcome || p.currentScore != n.currentScore,
      builder: (context, state) {
        final outcome = state.outcome;
        if (outcome == null) return const SizedBox.shrink();
        if (outcome == GameOutcome.win) {
          return WinDialog(
            score: state.currentScore,
            onClose: () => context.read<GameCubit>().closeDialogAndRestart(),
            onGetBonus: () =>
                context.read<GameCubit>().addBonusAndRestart(2500),
          );
        }
        return LoseDialog(
          onRetry: () => context.read<GameCubit>().closeDialogAndRestart(),
        );
      },
    );
  }
}

class _PaletteIconsRow extends StatelessWidget {
  const _PaletteIconsRow();

  @override
  Widget build(BuildContext context) {
    const icons = CandyType.values;
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: List.generate(
        icons.length,
        (i) => Image.asset(
          icons[i].asset,
          width: 53,
          height: 53,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
