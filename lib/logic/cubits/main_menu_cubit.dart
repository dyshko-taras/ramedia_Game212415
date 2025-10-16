// path: lib/logic/cubits/main_menu_cubit.dart
import 'package:code/data/repositories/candy_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// State for Main Menu — exposes the persisted bestScore.
class MainMenuState extends Equatable {
  const MainMenuState({
    required this.bestScore,
    required this.isDialogueCompleted,
  });

  final int bestScore;
  final bool isDialogueCompleted;

  @override
  List<Object?> get props => <Object?>[bestScore];

  MainMenuState copyWith({
    int? bestScore,
    bool? isDialogueCompleted,
  }) {
    return MainMenuState(
      bestScore: bestScore ?? this.bestScore,
      isDialogueCompleted: isDialogueCompleted ?? this.isDialogueCompleted,
    );
  }
}

/// Loads best score from repository on demand.
/// Navigation handlers (`onPlay`, `onInfo`, `onSettings`) will be wired in UI layer (Phase 6).
class MainMenuCubit extends Cubit<MainMenuState> {
  MainMenuCubit(this._repo)
    : super(const MainMenuState(bestScore: 0, isDialogueCompleted: false));

  final CandyRepository _repo;

  Future<void> loadBestScore() async {
    final score = await _repo.getBestScore();
    final completed = await _repo.isDialogueCompleted();
    emit(state.copyWith(bestScore: score, isDialogueCompleted: completed));
  }
}
