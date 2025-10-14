// path: lib/logic/cubits/main_menu_cubit.dart
import 'package:code/data/repositories/candy_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// State for Main Menu — exposes the persisted bestScore.
class MainMenuState extends Equatable {
  const MainMenuState({required this.bestScore});

  final int bestScore;

  MainMenuState copyWith({int? bestScore}) =>
      MainMenuState(bestScore: bestScore ?? this.bestScore);

  @override
  List<Object?> get props => <Object?>[bestScore];
}

/// Loads best score from repository on demand.
/// Navigation handlers (`onPlay`, `onInfo`, `onSettings`) will be wired in UI layer (Phase 6).
class MainMenuCubit extends Cubit<MainMenuState> {
  MainMenuCubit(this._repo) : super(const MainMenuState(bestScore: 0));

  final CandyRepository _repo;

  Future<void> loadBestScore() async {
    final score = await _repo.getBestScore();
    emit(state.copyWith(bestScore: score));
  }
}
