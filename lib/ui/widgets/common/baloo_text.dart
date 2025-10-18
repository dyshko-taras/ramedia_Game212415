// path: lib/ui/widgets/common/baloo_text.dart
import 'package:code/ui/theme/app_colors.dart';
import 'package:code/ui/theme/app_fonts.dart';
import 'package:flutter/material.dart';

class BalooText extends StatelessWidget {
  const BalooText(
    this.text, {
    required this.size,
    super.key,
    this.color = AppColors.primary,
    this.shadow = false,
    this.textAlign = TextAlign.center,
    this.maxLines,
    this.softWrap,
    this.height,
  });

  final String text;

  final BalooSize size;

  final Color color;

  final bool shadow;

  final TextAlign textAlign;
  final int? maxLines;
  final bool? softWrap;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final fontSize = switch (size) {
      BalooSize.score64 => FontSizes.score64,
      BalooSize.label40 => FontSizes.label40,
      BalooSize.button32 => FontSizes.button32,
      BalooSize.dialog24 => FontSizes.dialog24,
      BalooSize.caption20 => FontSizes.caption20,
      BalooSize.dialogLong14 => FontSizes.dialogLong14,
      BalooSize.info10 => FontSizes.info10,
    };

    // Opposite-color shadow (small blur + offset) to achieve outlined/contrasty look from the Visual Guide.
    final shadows = shadow
        ? <Shadow>[
            Shadow(
              offset: const Offset(0, 2),
              blurRadius: 2,
              color: color == AppColors.white
                  ? AppColors.primary
                  : AppColors.white,
            ),
          ]
        : null;

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: baloo(
        fontSize,
        color: color,
        height: height,
        shadows: shadows,
      ),
    );
  }
}

/// Enumerated size names exactly per spec table.
enum BalooSize {
  score64,
  label40,
  button32,
  dialog24,
  caption20,
  dialogLong14,
  info10,
}
