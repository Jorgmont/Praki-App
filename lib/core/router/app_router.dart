import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:praki/menu.dart';
import '../di/injection_container.dart';
import '../theme/app_theme.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/auth/presentation/cubit/auth_state.dart';
import 'go_router_refresh_stream.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/menu',
    refreshListenable: GoRouterRefreshStream(sl<AuthCubit>().stream),
    redirect: (context, state) {
      final authState = sl<AuthCubit>().state;
      final isLoggingIn = state.matchedLocation == '/login';

      if (authState is! AuthAuthenticated) {
        return isLoggingIn ? null : '/login';
      }

      if (isLoggingIn) {
      return '/menu'; 
    }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/menu',
        name: 'menu',
        builder: (context, state) => const MenuScreen(),
      ),
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

