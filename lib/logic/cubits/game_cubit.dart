// path: lib/logic/cubits/game_cubit.dart
import 'dart:math';

import 'package:code/data/repositories/candy_repository.dart';
import 'package:code/game/model/candy_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum GameUiPhase { hint, playing, ended }

enum GameOutcome { win, lose }

class GameState extends Equatable {
  const GameState({
    required this.currentScore,
    required this.bestScore,
    required this.isOver,
    required this.nextCandy,
    required this.phase,
    required this.mergeSeq,
    required this.tapToAnyPlace,
    this.lastTapX,
    this.outcome,
  });

  final int currentScore;
  final int bestScore;
  final bool isOver;
  final CandyType nextCandy;
  final GameUiPhase phase;
  final int mergeSeq; // increments on every merge
  final double? lastTapX;
  final GameOutcome? outcome;
  final bool tapToAnyPlace;

  GameState copyWith({
    int? currentScore,
    int? bestScore,
    bool? isOver,
    CandyType? nextCandy,
    GameUiPhase? phase,
    int? mergeSeq,
    double? lastTapX,
    GameOutcome? outcome,
    bool? tapToAnyPlace,
  }) {
    return GameState(
      currentScore: currentScore ?? this.currentScore,
      bestScore: bestScore ?? this.bestScore,
      isOver: isOver ?? this.isOver,
      nextCandy: nextCandy ?? this.nextCandy,
      phase: phase ?? this.phase,
      mergeSeq: mergeSeq ?? this.mergeSeq,
      lastTapX: lastTapX ?? this.lastTapX,
      outcome: outcome ?? this.outcome,
      tapToAnyPlace: tapToAnyPlace ?? this.tapToAnyPlace,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    currentScore,
    bestScore,
    isOver,
    nextCandy,
    phase,
    mergeSeq,
    lastTapX,
    outcome,
    tapToAnyPlace,
  ];
}

final class GameCubit extends Cubit<GameState> {
  GameCubit(
    this._repo,
  ) : _rnd = Random(),
      super(
        const GameState(
          currentScore: 0,
          bestScore: 0,
          isOver: false,
          nextCandy: CandyType.level0,
          phase: GameUiPhase.hint,
          mergeSeq: 0,
          tapToAnyPlace: false,
        ),
      );

  final CandyRepository _repo;
  final Random _rnd;

  /// Loads persisted best score (call on game start).
  Future<void> load() async {
    final best = await _repo.getBestScore();
    final tapToAnyPlace = await _repo.getTapToAnyPlace();
    emit(
      state.copyWith(
        bestScore: best,
        currentScore: 0,
        isOver: false,
        phase: tapToAnyPlace ? GameUiPhase.playing : GameUiPhase.hint,
        mergeSeq: 0,
        tapToAnyPlace: tapToAnyPlace,
      ),
    );
    rollNext();
  }

  /// Adds points to the current score (no-ops if game is over).
  void addPoints(int points) {
    if (state.isOver) return;
    final next = state.currentScore + points;
    emit(state.copyWith(currentScore: next));
  }

  /// Ends the current run; persists best score if exceeded.
  Future<void> endGame() async {
    if (state.isOver) return;
    var best = state.bestScore;
    if (state.currentScore > best) {
      best = state.currentScore;
      await _repo.setBestScore(best);
    }
    emit(state.copyWith(bestScore: best, isOver: true));
  }

  /// Finalizes a win by applying a bonus to the current score and
  /// persisting best score accordingly. Works even after markWin() set isOver.
  Future<void> finalizeWinWithBonus(int bonus) async {
    final total = state.currentScore + bonus;
    var best = state.bestScore;
    if (total > best) {
      best = total;
      await _repo.setBestScore(best);
    }
    emit(
      state.copyWith(
        currentScore: total,
        bestScore: best,
        isOver: true,
        outcome: GameOutcome.win,
        phase: GameUiPhase.ended,
      ),
    );
  }

  /// Starts a new run (keeps best score).
  void resetRun() {
    emit(
      state.copyWith(
        currentScore: 0,
        isOver: false,
        phase: state.tapToAnyPlace ? GameUiPhase.playing : GameUiPhase.hint,
      ),
    );
    rollNext();
  }

  /// Picks the next candy to display in HUD/preview.
  void rollNext() {
    // Simple first pass: 70% L0, 30% L1
    final next = _rnd.nextInt(100) < 70 ? CandyType.level0 : CandyType.level1;
    emit(state.copyWith(nextCandy: next));
  }

  /// Signals that a merge has occurred in the game world.
  void notifyMerged() {
    if (state.isOver) return;
    emit(state.copyWith(mergeSeq: state.mergeSeq + 1));
  }

  /// Handles tap from UI surface (393-based coords)
  void onTapAt(double x) {
    if (state.isOver) return;
    // First tap starts the session
    final nextPhase = state.phase == GameUiPhase.hint
        ? GameUiPhase.playing
        : state.phase;
    // Store tap position for any overlay needs
    emit(state.copyWith(phase: nextPhase, lastTapX: x));
    // Simulate a spawn effect by rolling next
    rollNext();
  }

  /// Dismisses the hint overlay without relying on a tap position.
  /// Useful when hint is a full-screen overlay that just needs to close.
  void dismissHint() {
    if (state.isOver) return;
    if (state.phase == GameUiPhase.hint) {
      emit(state.copyWith(phase: GameUiPhase.playing));
      setTapToAnyPlace(true);
    }
  }

  // ---- Win / Lose dialog control ----

  Future<void> markWin() async {
    if (state.isOver) return;
    var best = state.bestScore;
    if (state.currentScore > best) {
      best = state.currentScore;
      await _repo.setBestScore(best);
    }
    emit(
      state.copyWith(
        bestScore: best,
        isOver: true,
        outcome: GameOutcome.win,
        phase: GameUiPhase.ended,
      ),
    );
  }

  Future<void> markLose() async {
    if (state.isOver) return;
    var best = state.bestScore;
    if (state.currentScore > best) {
      best = state.currentScore;
      await _repo.setBestScore(best);
    }
    emit(
      state.copyWith(
        bestScore: best,
        isOver: true,
        outcome: GameOutcome.lose,
        phase: GameUiPhase.ended,
      ),
    );
  }

  void closeDialogAndRestart() {
    emit(
      state.copyWith(
        isOver: false,
        phase: state.tapToAnyPlace ? GameUiPhase.playing : GameUiPhase.hint,
        currentScore: 0,
      ),
    );
    rollNext();
  }

  void addBonusAndRestart(int bonus) {
    emit(
      state.copyWith(
        isOver: false,
        phase: state.tapToAnyPlace ? GameUiPhase.playing : GameUiPhase.hint,
        currentScore: bonus,
      ),
    );
    rollNext();
  }

  //Tap to any place
  Future<void> setTapToAnyPlace(bool value) async {
    emit(state.copyWith(tapToAnyPlace: value));
    await _repo.setTapToAnyPlace(value);
  }
}
