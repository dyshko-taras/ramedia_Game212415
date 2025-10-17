// lib/game/components/top_line_sensor_body.dart
import 'dart:ui';

import 'package:code/game/core/physics_scale.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

/// Horizontal sensor line across the screen.
class TopLineSensorBody extends BodyComponent with ContactCallbacks {
  TopLineSensorBody({
    required this.leftPx,
    required this.rightPx,
    required this.yPx,
    this.grace = const Duration(milliseconds: 800),
  });
  final double leftPx;
  final double rightPx;
  final double yPx;
  final Duration grace;

  VoidCallback? onExceeded;
  int _contacts = 0;
  bool _scheduled = false;

  @override
  Body createBody() {
    final l = PhysicsScale.px2w(leftPx);
    final r = PhysicsScale.px2w(rightPx);
    final y = PhysicsScale.px2w(yPx);
    final shape = EdgeShape()..set(Vector2(l, y), Vector2(r, y));
    final fd = FixtureDef(shape, isSensor: true);
    final body = world.createBody(BodyDef());
    body.createFixture(fd);
    return body;
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (!contact.isTouching()) return;
    _contacts++;
    if (_scheduled) return;
    _scheduled = true;
    Future<void>.delayed(grace, () {
      _scheduled = false;
      if (_contacts > 0) onExceeded?.call();
    });
  }

  @override
  void endContact(Object other, Contact contact) {
    if (_contacts > 0) _contacts--;
  }
}
