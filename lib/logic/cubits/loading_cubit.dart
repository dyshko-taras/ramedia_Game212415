// path: lib/logic/cubits/loading_cubit.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:code/services/audio_service.dart';

class LoadingState extends Equatable {
  const LoadingState({required this.progress});
  final double progress;

  LoadingState copyWith({double? progress}) =>
      LoadingState(progress: progress ?? this.progress);

  @override
  List<Object?> get props => <Object?>[progress];
}

class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit() : super(const LoadingState(progress: 0));

  void tick(double delta) {
    final next = (state.progress + delta).clamp(0.0, 1.0);
    emit(state.copyWith(progress: next));
  }

  void complete() => emit(state.copyWith(progress: 1));

  /// Preloads heavy resources. When finished, marks progress complete.
  /// Currently handles background music initialization via [AudioService].
  Future<void> preload(AudioService audio) async {
    try {
      await audio.init();
    } catch (_) {
      // Swallow errors to not block loading navigation.
    }
    complete();
  }
}
