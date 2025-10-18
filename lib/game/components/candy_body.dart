// lib/game/components/candy_body.dart
import 'package:code/game/core/physics_scale.dart';
import 'package:code/game/model/candy_type.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class CandyBody extends BodyComponent with ContactCallbacks {
  CandyBody({required this.type, required Vector2 positionPx})
    : _initialPositionPx = positionPx;

  final CandyType type;
  final Vector2 _initialPositionPx; // in px

  SpriteComponent? sprite;
  bool _pendingPop = false;
  void Function(CandyBody other, Vector2 at)? onSameTypeContact;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final img = await game.images.load(type.asset);
    final radiusMeters = PhysicsScale.px2w(type.radiusPx);
    sprite = SpriteComponent(
      sprite: Sprite(img),
      size: Vector2.all(radiusMeters * 2), // meters
      anchor: Anchor.center,
    );
    sprite!.position = Vector2.zero();
    add(sprite!);
    if (_pendingPop) {
      _pendingPop = false;
      await _playPopEffect();
    }
  }

  @override
  Body createBody() {
    final shape = CircleShape()..radius = PhysicsScale.px2w(type.radiusPx);
    final fd = FixtureDef(
      shape,
      restitution: type.restitution,
      friction: type.friction,
    );
    final bd = BodyDef(
      type: BodyType.dynamic,
      position: PhysicsScale.px2wVec(_initialPositionPx),
      linearDamping: type.linearDamping,
      angularDamping: type.angularDamping,
    );
    final b = world.createBody(bd)..userData = this;
    final fixture = b.createFixture(fd)..userData = this;
    return b;
  }

  Future<void> pop() async {
    if (sprite == null || !sprite!.isMounted) {
      _pendingPop = true;
      return;
    }
    await _playPopEffect();
  }

  Future<void> _playPopEffect() async {
    await sprite!.add(
      ScaleEffect.to(
        Vector2.all(1.1),
        EffectController(duration: 0.08, alternate: true, repeatCount: 2),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Clamp angular velocity for stability (per level)
    final cap = type.angularVelocityCap;
    final w = body.angularVelocity;
    if (w > cap) {
      body.angularVelocity = cap;
    } else if (w < -cap) {
      body.angularVelocity = -cap;
    }
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is! CandyBody || other.type != type) return;
    if (!contact.isTouching()) return;

    final wm = WorldManifold();
    contact.getWorldManifold(wm);
    final pts = wm.points.where((p) => p.x != 0 || p.y != 0).toList();
    final at = pts.isNotEmpty
        ? pts.reduce((a, b) => a + b) / pts.length.toDouble()
        : (body.position + other.body.position) / 2;
    onSameTypeContact?.call(other, at);
  }
}
