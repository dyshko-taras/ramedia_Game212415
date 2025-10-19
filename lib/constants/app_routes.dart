// lib/constants/app_routes.dart
import 'package:code/data/local/prefs_store.dart';
import 'package:code/data/repositories/candy_repository.dart';
import 'package:code/logic/cubits/dialogue_cubit.dart';
import 'package:code/logic/cubits/game_cubit.dart';
import 'package:code/logic/cubits/info_cubit.dart';
import 'package:code/logic/cubits/loading_cubit.dart';
import 'package:code/logic/cubits/main_menu_cubit.dart';
import 'package:code/logic/cubits/settings_cubit.dart';
import 'package:code/services/audio_service.dart';
import 'package:code/ui/screens/dialogue/dialogue_page.dart';
import 'package:code/ui/screens/game/game_page.dart';
import 'package:code/ui/screens/info/info_page.dart';
import 'package:code/ui/screens/loading/loading_page.dart';
import 'package:code/ui/screens/main_menu/main_menu_page.dart';
import 'package:code/ui/screens/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class AppRoutes {
  AppRoutes._();

  // Shared audio service instance
  static final AudioService audio = AudioService(PrefsStore());

  static const String loading = '/loading';
  static const String mainMenu = '/main-menu';
  static const String settings = '/settings';
  static const String info = '/info';
  static const String dialogue = '/dialogue';
  static const String game = '/game';

  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    loading: (_) => BlocProvider<LoadingCubit>(
      create: (_) => LoadingCubit()..preload(audio),
      child: const LoadingPage(),
    ),

    mainMenu: (_) => BlocProvider<MainMenuCubit>(
      create: (_) =>
          MainMenuCubit(CandyRepository(PrefsStore()))..loadBestScore(),
      child: const MainMenuPage(),
    ),
    settings: (_) => BlocProvider<SettingsCubit>(
      create: (_) => SettingsCubit(
        PrefsStore(),
        audio,
      )..load(),
      child: const SettingsPage(),
    ),
    info: (_) => BlocProvider<InfoCubit>(
      create: (_) => InfoCubit()..loadItems(),
      child: const InfoPage(),
    ),
    dialogue: (_) => BlocProvider<DialogueCubit>(
      create: (_) => DialogueCubit(
        repository: CandyRepository(PrefsStore()),
        totalSteps: 4,
      ),
      child: const DialoguePage(),
    ),

    game: (_) => BlocProvider<GameCubit>(
      create: (_) => GameCubit(
        CandyRepository(PrefsStore()),
      )..load(),
      child: const GamePage(),
    ),
  };
}
