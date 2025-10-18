import 'package:code/constants/app_images.dart';
import 'package:code/ui/theme/app_colors.dart';
import 'package:code/ui/theme/app_spacing.dart';
import 'package:code/ui/widgets/common/baloo_text.dart';
import 'package:flutter/material.dart';

class LoseDialog extends StatelessWidget {
  const LoseDialog({required this.onRetry, super.key});
  static const id = 'lose_dialog';

  final VoidCallback onRetry;

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
              child: Image.asset(AppImages.dialogLose, fit: BoxFit.contain),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const BalooText(
                  'YOU LOSE!',
                  size: BalooSize.button32,
                  color: AppColors.white,
                  shadow: true,
                ),
                Space.vM,
                GestureDetector(
                  onTap: onRetry,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(AppImages.btnMedium, scale: 2,),
                      const BalooText(
                        'RETRY',
                        size: BalooSize.dialog24,
                        color: AppColors.white,
                        shadow: true,
                      ),
                    ],
                  ),
                ),
                Space.vM,
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(AppImages.btnMedium, scale: 2,),
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
          ],
        ),
      ),
    );
  }
}
