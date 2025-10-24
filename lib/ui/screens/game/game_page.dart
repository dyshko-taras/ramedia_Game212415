// lib/ui/screens/game/game_page.dart
import 'package:code/constants/app_images.dart';
import 'package:code/constants/app_routes.dart';
import 'package:code/game/candy_game.dart';
import 'package:code/game/model/candy_type.dart';
import 'package:code/game/overlays/lose_dialog.dart';
import 'package:code/game/overlays/top_hud.dart';
import 'package:code/game/overlays/win_dialog.dart';
import 'package:code/logic/cubits/game_cubit.dart';
import 'package:code/ui/widgets/common/blur_background.dart';
import 'package:code/ui/widgets/scaled_game_view.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late final CandyGame _game;

  @override
  void initState() {
    super.initState();
    _game = CandyGame()..bindContext(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlurBackground(
      background: const AssetImage(AppImages.backgroundGame),
      sigma: 0,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            ScaledGameView(
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
            const _CharacterPeekLayer(),
            const _LoseSequenceLayer(),
          ],
        ),
      ),
    );
  }
}

class _CharacterPeekLayer extends StatefulWidget {
  const _CharacterPeekLayer();

  @override
  State<_CharacterPeekLayer> createState() => _CharacterPeekLayerState();
}

class _CharacterPeekLayerState extends State<_CharacterPeekLayer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen for merge events (mergeSeq increments) to trigger animation.
    // Ensure we don't restart while animating.
    return Positioned(
      // Layout parameters for slide-in/out from left
      top: 120,
      width: 240,
      left: _computeLeft(),
      child: BlocListener<GameCubit, GameState>(
        listenWhen: (p, n) => p.mergeSeq != n.mergeSeq,
        listener: (context, state) {
          if (!_controller.isAnimating) {
            _controller.forward(from: 0);
          }
        },
        child: const IgnorePointer(
          child: _CharacterImage(),
        ),
      ),
    );
  }

  double _computeLeft() {
    const hiddenLeft = -240; // fully outside
    const shownLeft = -20; // peek inside a bit
    final t = _controller.value;
    double progress;
    if (t < 0.5) {
      progress = t * 2; // 0..1 slide in
    } else {
      progress = 1 - (t - 0.5) * 2; // 1..0 slide out
    }
    return hiddenLeft + (shownLeft - hiddenLeft) * progress;
  }
}

class _CharacterImage extends StatelessWidget {
  const _CharacterImage();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.characterLeft,
      fit: BoxFit.contain,
    );
  }
}

class _LoseSequenceLayer extends StatefulWidget {
  const _LoseSequenceLayer();

  @override
  State<_LoseSequenceLayer> createState() => _LoseSequenceLayerState();
}

class _LoseSequenceLayerState extends State<_LoseSequenceLayer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _active = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1900),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _runAndShowDialog() async {
    setState(() => _active = true);
    try {
      await _controller.forward(from: 0);
    } finally {
      if (!mounted) return;
      await showLoseDialog(
        context,
        onRetry: () async {
          Navigator.of(context).pop();
          await Navigator.of(context).pushReplacementNamed(AppRoutes.game);
        },
        onExit: () async {
          Navigator.of(context).pop();
          await Navigator.of(context).pushReplacementNamed(AppRoutes.mainMenu);
        },
      );
      if (mounted) setState(() => _active = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameCubit, GameState>(
      listenWhen: (p, n) =>
          p.outcome != n.outcome && n.outcome == GameOutcome.lose,
      listener: (context, state) {
        if (!_active) {
          _runAndShowDialog();
        }
      },
      child: IgnorePointer(
        ignoring: !_active,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            if (!_active) return const SizedBox.shrink();
            final t = _controller.value;
            final dy = -400 + 400 * t;
            final angle = t * 6.283185307179586; // 2*pi
            return Stack(
              children: [
                Positioned.fill(
                  child: Container(color: Colors.black.withOpacity(0.25)),
                ),
                Positioned.fill(
                  child: Center(
                    child: Transform.translate(
                      offset: Offset(0, dy),
                      child: Transform.rotate(
                        angle: angle,
                        child: Image.asset(
                          AppImages.chupachupsBig,
                          scale: 2,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TapHintLayer extends StatelessWidget {
  const _TapHintLayer();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<GameCubit, GameState, bool>(
      // Show only if we are in hint phase AND user hasn't acknowledged it before
      selector: (s) => s.phase == GameUiPhase.hint && !s.tapToAnyPlace,
      builder: (context, show) {
        if (!show) return const SizedBox.shrink();
        return Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => context.read<GameCubit>().dismissHint(),
            child: Center(
              child: Image.asset(
                AppImages.tapHintHand,
                width: 120,
                fit: BoxFit.contain,
              ),
            ),
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
    return BlocListener<GameCubit, GameState>(
      listenWhen: (p, n) => p.outcome != n.outcome && n.outcome != null,
      listener: (context, state) async {
        final cubit = context.read<GameCubit>();
        if (state.outcome == GameOutcome.win) {
          await showWinDialog(
            context,
            score: state.currentScore,
            onClaimBonus: () async {
              // Apply bonus to final score and persist best, then go to menu
              await cubit.finalizeWinWithBonus(2500);
              Navigator.of(context).pop();
              await Navigator.of(
                context,
              ).pushReplacementNamed(AppRoutes.mainMenu);
            },
          );
        }
      },
      child: const SizedBox.shrink(),
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
