// path: lib/logic/cubits/game_cubit.dart
import 'package:code/data/repositories/candy_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

@immutable
class GameState extends Equatable {
  const GameState({
    required this.currentScore,
    required this.bestScore,
    required this.isOver,
  });

  final int currentScore;
  final int bestScore;
  final bool isOver;

  GameState copyWith({
    int? currentScore,
    int? bestScore,
    bool? isOver,
  }) {
    return GameState(
      currentScore: currentScore ?? this.currentScore,
      bestScore: bestScore ?? this.bestScore,
      isOver: isOver ?? this.isOver,
    );
  }

  @override
  List<Object?> get props => <Object?>[currentScore, bestScore, isOver];
}

/// Minimal gameplay state machine for scoring lifecycle.
/// - Tracks `currentScore` during a run.
/// - Updates `bestScore` in repository when a run ends with a higher score.
final class GameCubit extends Cubit<GameState> {
  GameCubit(this._repo)
    : super(const GameState(currentScore: 0, bestScore: 0, isOver: false));

  final CandyRepository _repo;

  /// Loads persisted best score (call on game start).
  Future<void> load() async {
    final best = await _repo.getBestScore();
    emit(state.copyWith(bestScore: best, currentScore: 0, isOver: false));
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

  /// Starts a new run (keeps best score).
  void resetRun() {
    emit(state.copyWith(currentScore: 0, isOver: false));
  }
}
