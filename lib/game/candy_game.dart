// lib/game/candy_game.dart
import 'package:code/constants/app_images.dart';
import 'package:code/game/components/candy_body.dart';
import 'package:code/game/components/game_frame_bounds.dart';
import 'package:code/game/components/top_line_sensor_body.dart';
import 'package:code/game/core/physics_scale.dart';
import 'package:code/logic/cubits/game_cubit.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart' hide World;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Fixed-resolution Forge2D surface. Renders frame + top line and
/// spawns simple physics balls on tap for testing.
class CandyGame extends Forge2DGame with HasCollisionDetection, TapCallbacks {
  // px above frame

  CandyGame() : super(zoom: PhysicsScale.pxPerWorld, gravity: Vector2(0, 20), camera: CameraComponent.withFixedResolution(width: screenW, height: screenH));
  // Debug switches
  static const bool kDebugMerges = false;
  static const double screenW = 393; // px
  static const double screenH = 852; // px
  static const double frameW = 371; // px
  static const double frameH = 467; // px
  static const double topLineH = 5; // px
  static const double topLineOffsetPx = 6;

  // App context for reading cubits when needed.
  late BuildContext appContext;
  late GameCubit cubit;

  void bindContext(BuildContext context) {
    appContext = context;
    cubit = context.read<GameCubit>();
  }

  @override
  Color backgroundColor() => Colors.transparent;

  late Rect _frameRectPx; // in px
  late double _topLineYPx; // in px
  final List<_MergeEvent> _merges = <_MergeEvent>[];
  final Set<String> _mergeGate = <String>{};
  DateTime? _lastSpawnAt;
  static const Duration _spawnCooldown = Duration(milliseconds: 400);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    images.prefix = '';

    // Ensure camera anchors to top-left for pixel-like coordinates
    camera.viewfinder.anchor = Anchor.topLeft;

    // Frame metrics (px)
    const frameLeft = (screenW - frameW) / 2;
    const frameTop = (screenH - frameH) / 2;
    const frameRect = Rect.fromLTWH(frameLeft, frameTop, frameW, frameH);
    _frameRectPx = frameRect;

    // Visuals: frame (sizes/positions in METERS = px / zoom)
    final frame = SpriteComponent()
      ..sprite = await loadSprite(AppImages.gameFrame)
      ..size = Vector2(frameW / PhysicsScale.pxPerWorld, frameH / PhysicsScale.pxPerWorld)
      ..anchor = Anchor.topLeft
      ..position = Vector2(
        frameLeft / PhysicsScale.pxPerWorld,
        frameTop / PhysicsScale.pxPerWorld,
      );

    // Visuals: top line
    const topLineY = frameTop - topLineOffsetPx;
    _topLineYPx = topLineY;
    final topLine = SpriteComponent()
      ..sprite = await loadSprite(AppImages.topLine)
      ..size = Vector2(screenW / PhysicsScale.pxPerWorld, topLineH / PhysicsScale.pxPerWorld)
      ..anchor = Anchor.topLeft
      ..position = Vector2(0, topLineY / PhysicsScale.pxPerWorld);

    await addAll([frame, topLine]);

    // Physics bodies
    await world.add(GameFrameBounds.fromPxRect(frameRect));
    await world.add(
      TopLineSensorBody(leftPx: 0, rightPx: screenW, yPx: topLineY)
        ..onExceeded = () => cubit.markLose(),
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    final now = DateTime.now();
    if (_lastSpawnAt != null &&
        now.difference(_lastSpawnAt!) < _spawnCooldown) {
      return;
    }
    // Spawn a Candy based on cubit.nextCandy
    final next = cubit.state.nextCandy;
    final radiusPx = next.radiusPx;
    final leftPx = _frameRectPx.left + radiusPx;
    final rightPx = _frameRectPx.right - radiusPx;
    final xPx = event.localPosition.x;
    final clampedPx = xPx.clamp(leftPx, rightPx);
    final spawnYPx = _topLineYPx + 10;
    final body = CandyBody(
      type: next,
      positionPx: Vector2(clampedPx, spawnYPx),
    );
    body.onSameTypeContact = (other, atMeters) {
      final idA = identityHashCode(body);
      final idB = identityHashCode(other);
      final key = idA < idB ? '$idA-$idB' : '$idB-$idA';
      if (_mergeGate.contains(key)) return;
      _mergeGate.add(key);
      if (kDebugMerges) {
        print(
          '[MERGE-QUEUE] types=${body.type} & ${other.type} key=$key at(m)=$atMeters',
        );
      }
      _merges.add(_MergeEvent(a: body, b: other, atMeters: atMeters));
    };
    world.add(body);
    cubit.rollNext();
    _lastSpawnAt = now;
  }

  @override
  void update(double dt) {
    super.update(dt);
    while (_merges.isNotEmpty) {
      final e = _merges.removeLast();
      if (!e.a.isMounted || !e.b.isMounted) continue;
      if (e.a.type != e.b.type) continue;

      final next = e.a.type.nextOrNull;
      e.a.removeFromParent();
      e.b.removeFromParent();

      if (next == null) {
        cubit.markWin();
      } else {
        final posPx = PhysicsScale.w2pxVec(e.atMeters);
        final merged = CandyBody(type: next, positionPx: posPx);
        // rewire handler so further merges work
        merged.onSameTypeContact = (other, atM) {
          final idA = identityHashCode(merged);
          final idB = identityHashCode(other);
          final key = idA < idB ? '$idA-$idB' : '$idB-$idA';
          if (_mergeGate.contains(key)) return;
          _mergeGate.add(key);
          _merges.add(_MergeEvent(a: merged, b: other, atMeters: atM));
        };
        if (kDebugMerges) {
          print('[MERGE-SPAWN] newType=$next at(px)=$posPx');
        }
        world.add(merged..pop());
        cubit.addPoints(next.score);
      }
    }
    _mergeGate.clear();
  }
}

class _MergeEvent {
  _MergeEvent({required this.a, required this.b, required this.atMeters});
  final CandyBody a;
  final CandyBody b;
  final Vector2 atMeters;
}

