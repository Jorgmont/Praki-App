import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'dashboard',
        builder: (context, state) => ValueListenableBuilder<ThemeMode>(
          valueListenable: AppTheme.themeNotifier,
          builder: (context, mode, _) {
            return DashboardPage(
              isDarkMode: mode == ThemeMode.dark,
              onToggleTheme: () {
                AppTheme.themeNotifier.value =
                    mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
              },
            );
          },
        ),
      ),
    ],
  );
}
