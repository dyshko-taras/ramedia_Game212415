import 'dart:async';

import 'package:code/data/local/prefs_store.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';

/// Simple service for background music using flame_audio.
/// - Preloads bgm asset during Loading phase
/// - Respects user preference from [PrefsStore] (sound on/off)
final class AudioService {
  AudioService(this._prefs, {String? bgmAsset})
    : _bgmAsset = bgmAsset ?? 'background.mp3';

  final PrefsStore _prefs;
  final String _bgmAsset;
  bool _initialized = false;

  /// Initializes BGM pipeline and preloads music file.
  Future<void> init() async {
    if (_initialized) return;
    try {
      await FlameAudio.bgm.initialize();
      // Preload gracefully; ignore if file is missing.
      await FlameAudio.audioCache.load(_bgmAsset);
      _initialized = true;

      // Autoplay if enabled by prefs
      final enabled = await _prefs.getSoundOn();
      if (enabled) {
        await play();
      }
    } catch (e, st) {
      if (kDebugMode) {
        // Do not crash app if audio is absent; just log in debug
        print('AudioService.init error: $e\n$st');
      }
    }
  }

  Future<void> play({double volume = 0.6}) async {
    if (!_initialized) return;
    try {
      await FlameAudio.bgm.play(_bgmAsset, volume: volume);
    } catch (_) {
      // ignore
    }
  }

  Future<void> stop() async {
    try {
      await FlameAudio.bgm.stop();
    } catch (_) {
      // ignore
    }
  }

  Future<void> setEnabled(bool enabled) async {
    await _prefs.setSoundOn(enabled);
    if (enabled) {
      await play();
    } else {
      await stop();
    }
  }

  void dispose() {
    try {
      FlameAudio.bgm.dispose();
    } catch (_) {
      // ignore
    }
  }
}
