// path: test/data/local/prefs_store_test.dart
import 'package:code/data/local/prefs_store.dart';
import 'package:code/data/repositories/candy_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
  });

  test('PrefsStore returns defaults before any write', () async {
    final store = PrefsStore(prefs: await SharedPreferences.getInstance());
    expect(await store.getBestScore(), 0);
    expect(await store.getDialogueCompleted(), isFalse);
  });

  test('PrefsStore persists and reads best_score', () async {
    final store = PrefsStore(prefs: await SharedPreferences.getInstance());
    await store.setBestScore(1234);
    expect(await store.getBestScore(), 1234);
  });

  test('PrefsStore persists and reads isDialogueCompleted', () async {
    final store = PrefsStore(prefs: await SharedPreferences.getInstance());
    await store.setDialogueCompleted(true);
    expect(await store.getDialogueCompleted(), isTrue);
  });

    test('CandyRepository delegates best score set/get', () async {
    final prefs = await SharedPreferences.getInstance();
    final repo = CandyRepository(PrefsStore(prefs: prefs));

    expect(await repo.getBestScore(), 0);
    await repo.setBestScore(42);
    expect(await repo.getBestScore(), 42);
  });

  test('CandyRepository delegates dialogue completion flag', () async {
    final prefs = await SharedPreferences.getInstance();
    final repo = CandyRepository(PrefsStore(prefs: prefs));

    expect(await repo.isDialogueCompleted(), isFalse);
    await repo.setDialogueCompleted(true);
    expect(await repo.isDialogueCompleted(), isTrue);
  });
}
