// path: lib/constants/app_routes.dart
import 'package:code/logic/cubits/loading_cubit.dart';
import 'package:code/ui/screens/loading/loading_page.dart';
import 'package:code/ui/screens/main_menu/main_menu_page.dart';
import 'package:code/ui/screens/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Centralized route names and route table.
final class AppRoutes {
  AppRoutes._();

  static const String loading = '/loading';
  static const String mainMenu = '/main-menu';
  static const String settings = '/settings';
  static const String info = '/info';
  static const String dialogue = '/dialogue';
  static const String game = '/game';

  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    // Loading with provider
    loading: (_) => BlocProvider<LoadingCubit>(
      create: (_) => LoadingCubit(),
      child: const LoadingPage(),
    ),

    mainMenu: (_) => const MainMenuPage(),
    settings: (_) => const SettingsPage(),
    
    info: (_) => const Scaffold(body: Center(child: Text('Info — WIP'))),
    dialogue: (_) =>
        const Scaffold(body: Center(child: Text('Dialogue — WIP'))),
    game: (_) => const Scaffold(body: Center(child: Text('Game — WIP'))),
  };
}
