// path: lib/constants/app_routes.dart
import 'package:code/ui/common/debug_placeholder_page.dart';
import 'package:flutter/material.dart';

/// Centralized route names and route table.
/// Per plan 2.1, we expose all named routes now. A dedicated shell exists but is unused.
final class AppRoutes {
  AppRoutes._();

  // Route names (Phase 2)
  static const String loading = '/loading';
  static const String mainMenu = '/main-menu';
  static const String settings = '/settings';
  static const String info = '/info';
  static const String dialogue = '/dialogue';
  static const String game = '/game';

  /// Route registry mapping to temporary placeholder pages.
  /// Real screens will replace these in Phase 6.
  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    loading: (_) => const DebugPlaceholderPage(
      title: 'Loading',
      note: 'Phase 2 placeholder — real Loading Screen lands in Phase 6.',
    ),
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
