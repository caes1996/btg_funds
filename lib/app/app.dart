import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fondo_btg/core/constants/app_constants.dart';

import '../core/providers/theme_provider.dart';
import '../core/theme/app_theme.dart';
import 'app_router.dart';

class FondoBtgApp extends ConsumerWidget {
  const FondoBtgApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: goRouter,
    );
  }
}