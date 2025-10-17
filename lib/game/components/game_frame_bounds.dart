// lib/game/components/game_frame_bounds.dart
import 'package:code/game/core/physics_scale.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

/// Static boundaries (left, right, bottom) for the gameplay frame.
/// Input rect is in px and converted to world via PhysicsScale.
class GameFrameBounds extends BodyComponent {
  GameFrameBounds._(this._rectWorld);

  factory GameFrameBounds.fromPxRect(Rect pxRect) {
    final r = Rect.fromLTRB(
      PhysicsScale.px2w(pxRect.left),
      PhysicsScale.px2w(pxRect.top),
      PhysicsScale.px2w(pxRect.right),
      PhysicsScale.px2w(pxRect.bottom),
    );
    return GameFrameBounds._(r);
  }

  final Rect _rectWorld;

  @override
  Body createBody() {
    final body = world.createBody(BodyDef());

    // Left wall
    body.createFixtureFromShape(
      EdgeShape()..set(
        Vector2(_rectWorld.left, _rectWorld.top),
        Vector2(_rectWorld.left, _rectWorld.bottom),
      ),
    );
    // Right wall
    body.createFixtureFromShape(
      EdgeShape()..set(
        Vector2(_rectWorld.right, _rectWorld.top),
        Vector2(_rectWorld.right, _rectWorld.bottom),
      ),
    );
    // Bottom
    body.createFixtureFromShape(
      EdgeShape()..set(
        Vector2(_rectWorld.left, _rectWorld.bottom),
        Vector2(_rectWorld.right, _rectWorld.bottom),
      ),
    );

    return body;
  }
}
