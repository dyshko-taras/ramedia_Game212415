// path: lib/data/repositories/candy_repository.dart
import 'package:code/data/local/prefs_store.dart';
import 'package:meta/meta.dart';

/// Repository is the single entry point to persistence for Cubits/UI.
/// It delegates to [PrefsStore] with a small convenience API per plan. :contentReference[oaicite:2]{index=2} :contentReference[oaicite:3]{index=3}
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
}
