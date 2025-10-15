// path: lib/ui/widgets/common/small_pill_button.dart
import 'package:code/constants/app_images.dart';
import 'package:code/ui/theme/app_colors.dart';
import 'package:code/ui/theme/app_spacing.dart';
import 'package:code/ui/widgets/common/baloo_text.dart';
import 'package:flutter/material.dart';

class SmallPillButton extends StatelessWidget {
  const SmallPillButton({
    required this.label,
    required this.onTap,
    super.key,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const w = 121;
    const h = 66;

    return Semantics(
      button: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(h / 2),
        child: Ink(
          width: w.toDouble(),
          height: h.toDouble(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(h / 2),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: Image.asset(
                  AppImages.btnSmall,
                  fit: BoxFit.fill,
                  scale: 2,
                ),
              ),
              Padding(
                padding: Space.aS,
                child: BalooText(
                  label,
                  size: BalooSize.button32,
                  color: AppColors.white,
                  shadow: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
