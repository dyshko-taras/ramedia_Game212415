import 'package:code/data/local/prefs_store.dart';
import 'package:meta/meta.dart';

@immutable
final class CandyRepository {
  const CandyRepository(this._store);

  final PrefsStore _store;

  // Best score
  Future<int> getBestScore() => _store.getBestScore();
  Future<void> setBestScore(int value) => _store.setBestScore(value);

  // Intro dialogue gating (first run)
  Future<bool> isDialogueCompleted() => _store.getDialogueCompleted();
  Future<void> setDialogueCompleted(bool value) =>
      _store.setDialogueCompleted(value);

  // Tap to any place setting
  Future<bool> getTapToAnyPlace() => _store.getTapToAnyPlace();
  Future<void> setTapToAnyPlace(bool value) => _store.setTapToAnyPlace(value);
}
