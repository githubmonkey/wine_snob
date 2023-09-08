import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wine_snob/data/repositories/firebase_auth_repository.dart';
import 'package:wine_snob/pages/custom_profile_screen.dart';
import 'package:wine_snob/pages/custom_sign_in_screen.dart';
import 'package:wine_snob/pages/history_screen.dart';
import 'package:wine_snob/pages/oracle_screen.dart';
import 'package:wine_snob/routing/go_router_refresh_stream.dart';
import 'package:wine_snob/widgets/scaffold_with_nested_navigation.dart';

part 'app_router.g.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _oracleNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'oracle');
final _historyNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'history');
final _accountNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'account');

enum AppRoute {
  signIn,
  profile,
  oracle,
  history,
  account,
}

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/signIn',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = authRepository.currentUser != null;
      if (isLoggedIn) {
        if (state.matchedLocation.startsWith('/signIn')) {
          return '/oracle';
        }
      } else {
        if (state.matchedLocation.startsWith('/oracle') ||
            state.matchedLocation.startsWith('/history') ||
            state.matchedLocation.startsWith('/account')) {
          return '/signIn';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/signIn',
        name: AppRoute.signIn.name,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const CustomSignInScreen(),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _oracleNavigatorKey,
            routes: [
              GoRoute(
                path: '/oracle',
                name: AppRoute.oracle.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const OracleScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _historyNavigatorKey,
            routes: [
              GoRoute(
                path: '/history',
                name: AppRoute.history.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const HistoryScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _accountNavigatorKey,
            routes: [
              GoRoute(
                path: '/account',
                name: AppRoute.profile.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const CustomProfileScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
