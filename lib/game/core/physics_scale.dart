// lib/game/core/physics_scale.dart
import 'package:flame/extensions.dart';

abstract final class PhysicsScale {
  static const double pxPerWorld = 10;

  static double px2w(double px) => px / pxPerWorld;
  static Vector2 px2wVec(Vector2 v) => v / pxPerWorld;

  static double w2px(double w) => w * pxPerWorld;
  static Vector2 w2pxVec(Vector2 v) => v * pxPerWorld;
}
