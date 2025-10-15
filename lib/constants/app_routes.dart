// path: lib/constants/app_routes.dart
import 'package:code/logic/cubits/loading_cubit.dart';
import 'package:code/ui/screens/loading/loading_page.dart';
import 'package:code/ui/widgets/common/debug_placeholder_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Centralized route names and route table.
final class AppRoutes {
  AppRoutes._();

  // Route names
  static const String loading = '/loading';
  static const String mainMenu = '/main-menu';
  static const String settings = '/settings';
  static const String info = '/info';
  static const String dialogue = '/dialogue';
  static const String game = '/game';

  /// Route registry.
  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    // Provide LoadingCubit ABOVE the LoadingPage to avoid ProviderNotFoundException.
    loading: (_) => BlocProvider<LoadingCubit>(
      create: (_) => LoadingCubit(),
      child: const LoadingPage(),
    ),

    // Placeholders for now; will be replaced with real screens later.
    mainMenu: (_) => const DebugPlaceholderPage(
      title: 'Main Menu',
      note: 'Phase 2 placeholder.',
    ),
    settings: (_) => const DebugPlaceholderPage(
      title: 'Settings',
      note: 'Phase 2 placeholder.',
    ),
    info: (_) => const DebugPlaceholderPage(
      title: 'Info',
      note: 'Phase 2 placeholder.',
    ),
    dialogue: (_) => const DebugPlaceholderPage(
      title: 'Dialogue',
      note: 'Phase 2 placeholder.',
    ),
    game: (_) => const DebugPlaceholderPage(
      title: 'Game',
      note: 'Phase 2 placeholder.',
    ),
  };
}
