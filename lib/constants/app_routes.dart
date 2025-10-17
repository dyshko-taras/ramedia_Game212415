// lib/constants/app_routes.dart
import 'package:code/data/repositories/candy_repository.dart';
import 'package:code/logic/cubits/game_cubit.dart';
import 'package:code/logic/cubits/loading_cubit.dart';
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

  static const String loading = '/loading';
  static const String mainMenu = '/main-menu';
  static const String settings = '/settings';
  static const String info = '/info';
  static const String dialogue = '/dialogue';
  static const String game = '/game';

  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    loading: (_) => BlocProvider<LoadingCubit>(
      create: (_) => LoadingCubit(),
      child: const LoadingPage(),
    ),

    mainMenu: (_) => const MainMenuPage(),
    settings: (_) => const SettingsPage(),
    info: (_) => const InfoPage(),
    dialogue: (_) => const DialoguePage(),

    game: (ctx) => BlocProvider<GameCubit>(
      create: (ctx) => GameCubit(
        ctx.read<CandyRepository>(),
      )..load(),
      child: const GamePage(),
    ),
  };
}
