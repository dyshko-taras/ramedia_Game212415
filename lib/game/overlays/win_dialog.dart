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

  final int score;
  final VoidCallback onClose;
  final VoidCallback onGetBonus;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Image.asset(AppImages.dialogWin, fit: BoxFit.contain),
        ),
        Positioned(
          top: 60,
          right: 60,
          child: GestureDetector(
            onTap: onClose,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  AppImages.btnClose,
                  scale: 2,
                ),
              ],
            ),
          ),
        ),
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
                  Image.asset(
                    AppImages.iconStar,
                    scale: 2,
                  ),
                ],
              ),
              Space.vS,
              GestureDetector(
                onTap: onGetBonus,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      AppImages.btnMedium,
                      scale: 2,
                    ),
                    const BalooText(
                      'GET BONUS',
                      size: BalooSize.dialog24,
                      color: AppColors.white,
                      shadow: true,
                    ),
                  ],
                ),
              ),
              Space.vS,
              GestureDetector(
                onTap: onClose,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      AppImages.btnMedium,
                      scale: 2,
                    ),
                    const BalooText(
                      'EXIT',
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
    );
  }
}
