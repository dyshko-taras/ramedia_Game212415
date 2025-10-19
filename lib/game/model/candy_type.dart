import 'package:code/constants/app_images.dart';
import 'package:code/game/core/physics_scale.dart';

enum CandyType {
  level0(AppImages.candyBlueSwirl, 13, 2),
  level1(AppImages.candyPinkSwirl, 16, 5),
  level2(AppImages.candySkyBlue, 20, 10),
  level3(AppImages.candyGreen, 25, 20),
  level4(AppImages.candyPurple, 31, 40),
  level5(AppImages.candyCool, 38, 80),
  level6(AppImages.candyTurquoise, 46, 160),
  level7(AppImages.candyYellow, 55, 320),
  level8(AppImages.candyRed, 65, 640),
  level9(AppImages.candyPuple, 76, 1280);


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
