import 'package:code/constants/app_images.dart';
import 'package:code/ui/theme/app_colors.dart';
import 'package:code/ui/theme/app_spacing.dart';
import 'package:code/ui/widgets/common/baloo_text.dart';
import 'package:flutter/material.dart';

class WinDialog extends StatelessWidget {
  const WinDialog({
    required this.score,
    required this.onClaimBonus,
    super.key,
  });

  final int score;
  final VoidCallback onClaimBonus;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Panel background
          Image.asset(AppImages.dialogWin, fit: BoxFit.contain),
          // Close button (X)
          Positioned(
            top: 20,
            right: 20,
            child: GestureDetector(
              onTap: onClaimBonus,
              child: Image.asset(AppImages.btnClose, scale: 2),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const BalooText(
                  'RECORD SCORE:',
                  size: BalooSize.dialogLong14,
                ),
                Space.vS,
                BalooText(
                  '$score',
                  size: BalooSize.button32,
                ),
                Space.vS,
                const BalooText(
                  'YOUR BONUS',
                  size: BalooSize.button32,
                  color: AppColors.white,
                  shadow: true,
                ),
                Space.vS,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const BalooText(
                      '2500',
                      size: BalooSize.button32,
                      shadow: true,
                    ),
                    Space.hS,
                    Image.asset(AppImages.iconStar, scale: 2),
                  ],
                ),
                Space.vS,
                GestureDetector(
                  onTap: onClaimBonus,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(AppImages.btnMedium, scale: 2),
                      const BalooText(
                        'GET BONUS',
                        size: BalooSize.dialog24,
                        color: AppColors.white,
                        shadow: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> showWinDialog(
  BuildContext context, {
  required int score,
  required VoidCallback onClaimBonus,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.white24,
    builder: (_) => WinDialog(score: score, onClaimBonus: onClaimBonus),
  );
}
