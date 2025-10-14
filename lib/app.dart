import 'package:code/constants/app_routes.dart';
import 'package:code/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Root application widget.
/// Material 3 is enabled and routes are centralized in [AppRoutes].
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: AppRoutes.loading,
      routes: AppRoutes.routes,
    );
  }
}
