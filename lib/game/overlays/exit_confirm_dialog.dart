import 'package:code/constants/app_images.dart';
import 'package:code/ui/theme/app_colors.dart';
import 'package:code/ui/theme/app_spacing.dart';
import 'package:code/ui/widgets/common/baloo_text.dart';
import 'package:flutter/material.dart';

class ExitConfirmationDialog extends StatelessWidget {
  const ExitConfirmationDialog({
    required this.onConfirm,
    required this.onCancel,
    super.key,
  });

  final VoidCallback onConfirm;
  final VoidCallback onCancel;

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
                'ARE YOU SURE?',
                size: BalooSize.dialog24,
                color: AppColors.white,
                shadow: true,
              ),
              Space.vS,
              const BalooText(
                'Do you really want to exit the game?',
                size: BalooSize.dialogLong14,
                color: AppColors.white,
                shadow: true,
              ),
              Space.vS,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: onConfirm,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(AppImages.btnSmall, scale: 2),
                        const BalooText(
                          'YES',
                          size: BalooSize.dialog24,
                          color: AppColors.white,
                          shadow: true,
                        ),
                      ],
                    ),
                  ),
                  Space.hS,
                  GestureDetector(
                    onTap: onCancel,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(AppImages.btnSmall, scale: 2),
                        const BalooText(
                          'NO',
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
        ],
      ),
    );
  }
}

Future<void> showExitConfirmationDialog(
  BuildContext context, {
  required VoidCallback onConfirm,
  required VoidCallback onCancel,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.white24,
    builder: (_) => ExitConfirmationDialog(
      onConfirm: onConfirm,
      onCancel: onCancel,
    ),
  );
}
