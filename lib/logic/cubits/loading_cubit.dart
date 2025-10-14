// path: lib/logic/cubits/loading_cubit.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Loading state: progress in [0, 1].
class LoadingState extends Equatable {
  const LoadingState({required this.progress});
  final double progress;

  LoadingState copyWith({double? progress}) =>
      LoadingState(progress: progress ?? this.progress);

  @override
  List<Object?> get props => <Object?>[progress];
}

/// Controls the Loading Screen progress bar and completion event.
/// Spec: auto-increment via ticks; complete() sets 1.0.
class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit() : super(const LoadingState(progress: 0));

  /// Adds [delta] to current progress and clamps to [0,1].
  void tick(double delta) {
    final next = (state.progress + delta).clamp(0.0, 1.0);
    emit(state.copyWith(progress: next));
  }

  /// Forces progress to 1.0.
  void complete() => emit(state.copyWith(progress: 1));
}
