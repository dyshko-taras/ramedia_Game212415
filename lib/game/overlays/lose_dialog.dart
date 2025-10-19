import 'package:code/constants/app_images.dart';
import 'package:code/ui/theme/app_colors.dart';
import 'package:code/ui/theme/app_spacing.dart';
import 'package:code/ui/widgets/common/baloo_text.dart';
import 'package:flutter/material.dart';

class LoseDialog extends StatelessWidget {
  const LoseDialog({required this.onRetry, required this.onExit, super.key});

  final VoidCallback onRetry;
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(AppImages.dialogLose, fit: BoxFit.contain),
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
                    Image.asset(AppImages.btnMedium, scale: 2),
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
                onTap: onExit,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(AppImages.btnMedium, scale: 2),
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
    );
  }
}

Future<void> showLoseDialog(
  BuildContext context, {
  required VoidCallback onRetry,
  required VoidCallback onExit,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => LoseDialog(onRetry: onRetry, onExit: onExit),
  );
}
