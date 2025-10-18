// path: lib/ui/theme/app_spacing.dart
import 'package:flutter/widgets.dart';

abstract final class Space {
  static const double xxs = 4;
  static const double xs = 8;
  static const double s = 12;
  static const double m = 16;
  static const double l = 24;
  static const double xl = 32;
  static const double xxl = 48;

  static const SizedBox vXXS = SizedBox(height: xxs);
  static const SizedBox vXS = SizedBox(height: xs);
  static const SizedBox vS = SizedBox(height: s);
  static const SizedBox vM = SizedBox(height: m);
  static const SizedBox vL = SizedBox(height: l);
  static const SizedBox vXL = SizedBox(height: xl);
  static const SizedBox vXXL = SizedBox(height: xxl);

  static const SizedBox hXXS = SizedBox(width: xxs);
  static const SizedBox hXS = SizedBox(width: xs);
  static const SizedBox hS = SizedBox(width: s);
  static const SizedBox hM = SizedBox(width: m);
  static const SizedBox hL = SizedBox(width: l);
  static const SizedBox hXL = SizedBox(width: xl);
  static const SizedBox hXXL = SizedBox(width: xxl);

  static const EdgeInsets aS = EdgeInsets.all(s);
  static const EdgeInsets aM = EdgeInsets.all(m);
  static const EdgeInsets aL = EdgeInsets.all(l);

  static const EdgeInsets hxS = EdgeInsets.symmetric(horizontal: s);
  static const EdgeInsets hxM = EdgeInsets.symmetric(horizontal: m);
  static const EdgeInsets hxL = EdgeInsets.symmetric(horizontal: l);

  static const EdgeInsets vxS = EdgeInsets.symmetric(vertical: s);
  static const EdgeInsets vxM = EdgeInsets.symmetric(vertical: m);
  static const EdgeInsets vxL = EdgeInsets.symmetric(vertical: l);
}
