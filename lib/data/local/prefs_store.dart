import 'package:shared_preferences/shared_preferences.dart';

final class PrefsStore {
  PrefsStore({SharedPreferences? prefs}) : _prefsAsync = _init(prefs);

  static const String _kBestScore = 'best_score';
  static const String _kDialogueCompleted = 'isDialogueCompleted';
  static const String _kSoundOn = 'sound_on';
  static const String _kHardness = 'hardness';

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

  // ---- Sound On/Off ----

  Future<void> setSoundOn(bool v) async {
    final prefs = await _prefsAsync;
    await prefs.setBool(_kSoundOn, v);
  }

  Future<bool> getSoundOn() async {
    final prefs = await _prefsAsync;
    return prefs.getBool(_kSoundOn) ?? true; // default ON
  }

  // ---- Hardness (1..5) ----
  Future<void> setHardness(int v) async {
    final prefs = await _prefsAsync;
    await prefs.setInt(_kHardness, v);
  }

  Future<int> getHardness() async {
    final prefs = await _prefsAsync;
    return prefs.getInt(_kHardness) ?? 3; // default 3
  }
}
