import 'package:code/constants/app_images.dart';
import 'package:code/constants/app_routes.dart';
import 'package:code/logic/cubits/dialogue_cubit.dart';
import 'package:code/ui/widgets/common/baloo_text.dart';
import 'package:code/ui/widgets/common/small_pill_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialoguePage extends StatelessWidget {
  const DialoguePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _DialogueView();
  }
}

class _DialogueView extends StatelessWidget {
  const _DialogueView();

  static const List<String> _lines = <String>[
    'HELLO THERE!\nWHAT’S GOING ON\nIN THE CANDY?',
    'OH, THANK GOODNESS YOU’RE\nHERE! THERE’S A SOUR CANDY\nCAUSING CHAOS IN THE JAR. IT’S\nSCARING EVERYONE AND WE CAN’T\nENJOY OUR SWEETNESS ANYMORE.\nPLEASE, CAN YOU HELP US?',
    'THAT SOUNDS SERIOUS.\nI’LL DO WHAT I CAN TO\nDEAL WITH THE CANDY.',
    'THANK YOU SO\nMUCH! WE REALLY\nAPPRECIATE IT!',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background image switching based on dialogue index
          Positioned.fill(
            child: BlocBuilder<DialogueCubit, DialogueState>(
              builder: (context, state) {
                final idx = state.currentIndex;
                return Image.asset(
                  idx.isEven
                      ? AppImages.backgroundDialog0
                      : AppImages.backgroundDialog1,
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                );
              },
            ),
          ),

          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: BlocBuilder<DialogueCubit, DialogueState>(
                builder: (context, state) {
                  final text = _lines[state.currentIndex];
                  final completed = state.completed;
                  return Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: _BubblePanel(
                      text: text,
                      onNext: () async {
                        await context.read<DialogueCubit>().next();
                      },
                      onGo: completed
                          ? () async {
                              await Navigator.of(
                                context,
                              ).pushReplacementNamed(AppRoutes.game);
                            }
                          : null,
                      showGo: completed,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BubblePanel extends StatelessWidget {
  const _BubblePanel({
    required this.text,
    required this.onNext,
    required this.showGo,
    this.onGo,
  });

  final String text;
  final VoidCallback onNext;
  final VoidCallback? onGo;
  final bool showGo;

  @override
  Widget build(BuildContext context) {
    // 🔹 Вибір розміру шрифту за довжиною тексту
    final BalooSize size;
    if (text.length < 60) {
      size = BalooSize.dialog24;
    } else if (text.length < 70) {
      size = BalooSize.caption20;
    } else {
      size = BalooSize.dialogLong14;
    }

    return SizedBox(
      width: 335,
      height: 240,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Image.asset(
            AppImages.dialogueBox,
            fit: BoxFit.fill,
            scale: 2,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Center(
              child: BalooText(
                text,
                size: size,
              ),
            ),
          ),

          Positioned(
            bottom: -10,
            right: showGo ? null : 12,
            child: showGo
                ? SmallPillButton(
                    label: 'GO',
                    onTap: onGo!,
                  )
                : _NextButton(onTap: onNext),
          ),
        ],
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const double size = 56;
    return Semantics(
      button: true,
      label: 'Next',
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
            AppImages.btnNext,
            fit: BoxFit.contain,
            scale: 2,
          ),
        ),
      ),
    );
  }
}

