// path: lib/data/local/prefs_store.dart
import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferences-backed key-value storage for app state.
/// Spec keys: `best_score` (int), `isDialogueCompleted` (bool).
/// Defaults: best_score=0, isDialogueCompleted=false. :contentReference[oaicite:0]{index=0} :contentReference[oaicite:1]{index=1}
final class PrefsStore {
  PrefsStore({SharedPreferences? prefs}) : _prefsAsync = _init(prefs);

  static const String _kBestScore = 'best_score';
  static const String _kDialogueCompleted = 'isDialogueCompleted';

  final Future<SharedPreferences> _prefsAsync;

  static Future<SharedPreferences> _init(SharedPreferences? injected) async {
    if (injected != null) return injected;
    return SharedPreferences.getInstance();
  }

  // ---- Best Score ----

  Future<void> setBestScore(int v) async {
    final prefs = await _prefsAsync;
    await prefs.setInt(_kBestScore, v);
  }

  Future<int> getBestScore() async {
    final prefs = await _prefsAsync;
    return prefs.getInt(_kBestScore) ?? 0;
  }

  // ---- Dialogue Completed ----

  Future<void> setDialogueCompleted(bool v) async {
    final prefs = await _prefsAsync;
    await prefs.setBool(_kDialogueCompleted, v);
  }

  Future<bool> getDialogueCompleted() async {
    final prefs = await _prefsAsync;
    return prefs.getBool(_kDialogueCompleted) ?? false;
  }
}
