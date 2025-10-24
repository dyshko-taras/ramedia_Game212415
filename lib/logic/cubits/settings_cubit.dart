// path: lib/logic/cubits/settings_cubit.dart
import 'package:code/data/local/prefs_store.dart';
import 'package:code/services/audio_service.dart';
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

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._store, this._audio)
    : super(const SettingsState(soundOn: true, hardness: 3));

  final PrefsStore _store;
  final AudioService _audio;

  Future<void> load() async {
    final sound = await _store.getSoundOn();
    final hard = await _store.getHardness();
    emit(state.copyWith(soundOn: sound, hardness: hard));
  }

  void toggleSound() => emit(state.copyWith(soundOn: !state.soundOn));

  void setHardness(int value) {
    final v = value.clamp(1, 5);
    emit(state.copyWith(hardness: v));
  }

  Future<void> save() async {
    await _store.setSoundOn(state.soundOn);
    await _store.setHardness(state.hardness);
    // Apply audio immediately
    await _audio.setEnabled(state.soundOn);
  }
}
