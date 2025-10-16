// path: lib/logic/cubits/dialogue_cubit.dart
import 'package:code/data/repositories/candy_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

@immutable
class DialogueState extends Equatable {
  const DialogueState({
    required this.currentIndex,
    required this.totalSteps,
    required this.completed,
  }) : assert(totalSteps > 0, 'totalSteps must be > 0'),
       assert(
         currentIndex >= 0 && currentIndex < totalSteps || completed,
         'currentIndex must be within [0, totalSteps) unless completed',
       );

  /// Zero-based index of the current step.
  final int currentIndex;

  /// Total number of steps in the dialogue flow.
  final int totalSteps;

  /// Whether the dialogue has been fully completed.
  final bool completed;

  /// Convenience: progress in [0, 1].
  double get progress =>
      completed ? 1.0 : (currentIndex / totalSteps).clamp(0.0, 1.0);

  DialogueState copyWith({
    int? currentIndex,
    int? totalSteps,
    bool? completed,
  }) {
    return DialogueState(
      currentIndex: currentIndex ?? this.currentIndex,
      totalSteps: totalSteps ?? this.totalSteps,
      completed: completed ?? this.completed,
    );
  }

  @override
  List<Object?> get props => <Object?>[currentIndex, totalSteps, completed];
}

/// Controls a simple step-based dialogue/tutorial flow.
/// On completion, persists `isDialogueCompleted = true` via repository.
final class DialogueCubit extends Cubit<DialogueState> {
  DialogueCubit({
    required CandyRepository repository,
    required int totalSteps,
  }) : _repo = repository,
       super(
         DialogueState(
           currentIndex: 0,
           totalSteps: totalSteps,
           completed: false,
         ),
       );

  final CandyRepository _repo;

  /// Advance to the next step. If at the last step, completes the dialogue.
  Future<void> next() async {
    if (state.completed) return;

    final nextIndex = state.currentIndex + 1;

    if (nextIndex >= state.totalSteps - 1) {
      emit(state.copyWith(currentIndex: nextIndex, completed: true));
      await _repo.setDialogueCompleted(true);
    } else {
      emit(state.copyWith(currentIndex: nextIndex));
    }
  }

  /// Jump to completion immediately (e.g., user skips tutorial).
  Future<void> skip() async {
    if (state.completed) return;
    await _complete();
  }

  /// Reset the dialogue to the first step (runtime only; does not clear persisted flag).
  void reset() {
    emit(state.copyWith(currentIndex: 0, completed: false));
  }

  Future<void> _complete() async {
    emit(state.copyWith(completed: true));
    await _repo.setDialogueCompleted(true);
  }
}
