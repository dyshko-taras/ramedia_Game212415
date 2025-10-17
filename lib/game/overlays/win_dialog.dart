import 'package:code/constants/app_images.dart';
import 'package:code/ui/theme/app_colors.dart';
import 'package:code/ui/theme/app_spacing.dart';
import 'package:code/ui/widgets/common/baloo_text.dart';
import 'package:flutter/material.dart';

class WinDialog extends StatelessWidget {
  const WinDialog({
    required this.score,
    required this.onClose,
    required this.onGetBonus,
    super.key,
  });
  static const id = 'win_dialog';

  final int score;
  final VoidCallback onClose;
  final VoidCallback onGetBonus;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black.withOpacity(0.25),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Image.asset(AppImages.dialogWin, fit: BoxFit.contain),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const BalooText(
                    'RECORD SCORE:',
                    size: BalooSize.dialog24,
                    color: AppColors.white,
                    shadow: true,
                  ),
                  Space.vS,
                  BalooText(
                    '$score',
                    size: BalooSize.button32,
                    color: AppColors.white,
                    shadow: true,
                  ),
                  Space.vL,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const BalooText(
                        'YOUR BONUS',
                        size: BalooSize.button32,
                        color: AppColors.white,
                        shadow: true,
                      ),
                      Space.hS,
                      Image.asset(AppImages.iconStar),
                    ],
                  ),
                  Space.vL,
                  GestureDetector(
                    onTap: onGetBonus,
                    child: Image.asset(
                      AppImages.btnLarge,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 24,
              top: 24,
              child: GestureDetector(
                onTap: onClose,
                child: const Icon(Icons.close, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
