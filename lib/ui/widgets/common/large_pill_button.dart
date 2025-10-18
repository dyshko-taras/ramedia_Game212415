// path: lib/ui/widgets/common/large_pill_button.dart
import 'package:code/constants/app_images.dart';
import 'package:code/ui/theme/app_colors.dart';
import 'package:code/ui/theme/app_spacing.dart';
import 'package:code/ui/widgets/common/baloo_text.dart';
import 'package:flutter/material.dart';

class LargePillButton extends StatelessWidget {
  const LargePillButton({
    required this.width,
    required this.label,
    required this.onTap,
    super.key,
  });

  final double width;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final height = (width / 3.5).clamp(48, 128);

    return Semantics(
      button: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(height / 2),
        child: Ink(
          width: width,
          height: height.toDouble(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(height / 2),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background pill image
              Positioned.fill(
                child: Image.asset(
                  AppImages.btnLarge,
                  fit: BoxFit.fill,
                ),
              ),
              // Label
              const Padding(
                padding: Space.aS,
                child: SizedBox.shrink(),
              ),
              BalooText(
                label,
                size: BalooSize.button32,
                color: AppColors.white,
                shadow: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
