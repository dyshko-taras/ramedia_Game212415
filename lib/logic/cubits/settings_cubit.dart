// path: lib/logic/cubits/settings_cubit.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Settings state: soundOn and hardness (1..5).
class SettingsState extends Equatable {
  const SettingsState({
    required this.soundOn,
    required this.hardness,
  });

  final bool soundOn;
  final int hardness; // 1..5

  SettingsState copyWith({bool? soundOn, int? hardness}) => SettingsState(
    soundOn: soundOn ?? this.soundOn,
    hardness: hardness ?? this.hardness,
  );

  @override
  List<Object?> get props => <Object?>[soundOn, hardness];
}

/// Manages settings interactions.
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState(soundOn: true, hardness: 3));

  void toggleSound() => emit(state.copyWith(soundOn: !state.soundOn)); //TODO

  void setHardness(int value) {
    final v = value.clamp(1, 5);
    emit(state.copyWith(hardness: v));
  }

  Future<void> save() async {
    // Placeholder for future persistence (e.g., SharedPreferences keys).
    // Intentionally no-op in this phase per implementation plan scope.
  }
}
