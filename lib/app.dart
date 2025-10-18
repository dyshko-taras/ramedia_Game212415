// lib/app.dart
import 'package:code/constants/app_routes.dart';
import 'package:code/data/local/prefs_store.dart';
import 'package:code/data/repositories/candy_repository.dart'; 
import 'package:code/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<CandyRepository>(
      create: (_) => CandyRepository(PrefsStore()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        initialRoute: AppRoutes.loading,
        routes: AppRoutes.routes,
      ),
    );
  }
}
