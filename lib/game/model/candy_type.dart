import 'package:code/constants/app_images.dart';
import 'package:code/game/core/physics_scale.dart';

enum CandyType {
  level0(AppImages.candyBlueSwirl, 26, 5),
  level1(AppImages.candyPinkSwirl, 32, 10),
  level2(AppImages.candySkyBlue, 40, 20),
  level3(AppImages.candyGreen, 50, 40),
  level4(AppImages.candyPurple, 62, 80),
  level5(AppImages.candyCool, 76, 160),
  level6(AppImages.candyTurquoise, 92, 320),
  level7(AppImages.candyYellow, 110, 640),
  level8(AppImages.candyRed, 130, 1280),
  level9(AppImages.candyPuple, 152, 2560);

  const CandyType(this.asset, this.radiusPx, this.score);
  final String asset;
  final double radiusPx;
  final int score;

  double get radiusWorld => PhysicsScale.px2w(radiusPx);
  double get radiusMeters => PhysicsScale.px2w(radiusPx);

  double get restitution {
    final t = (radiusPx - 26) / (152 - 26); // 0..1
    return (0.04 - 0.02 * t).clamp(0.01, 0.05);
  }

  double get friction {
    final t = (radiusPx - 26) / (152 - 26);
    return (0.35 + 0.20 * t).clamp(0.35, 0.55);
  }

  double get linearDamping {
    return 0.02;
  }

  double get angularDamping {
    final t = (radiusPx - 26) / (152 - 26);
    return (0.04 + 0.06 * t).clamp(0.04, 0.10);
  }

  double get angularVelocityCap {
    final t = (radiusPx - 26) / (152 - 26);
    return (6.0 - 4.0 * t).clamp(2.0, 6.0);
  }

  CandyType? get nextOrNull =>
      (index + 1 < values.length) ? values[index + 1] : null;
}
