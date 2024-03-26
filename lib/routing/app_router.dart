import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wine_snob/data/repositories/firebase_auth_repository.dart';
import 'package:wine_snob/pages/custom_profile_screen.dart';
import 'package:wine_snob/pages/custom_sign_in_screen.dart';
import 'package:wine_snob/pages/history_screen.dart';
import 'package:wine_snob/pages/oracle_multimodal_screen.dart';
import 'package:wine_snob/pages/oracle_text_screen.dart';
import 'package:wine_snob/routing/go_router_refresh_stream.dart';
import 'package:wine_snob/widgets/scaffold_with_nested_navigation.dart';

part 'app_router.g.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _oracleTextNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'oracle_text');
final _oracleMultimodalNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'oracle_multimodal');
final _historyNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'history');
final _accountNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'account');

enum AppRoute {
  signIn,
  profile,
  oracle_text,
  oracle_multimodal,
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
          return '/oracle_text';
        }
      } else {
        if (state.matchedLocation.startsWith('/oracle_text') ||
            state.matchedLocation.startsWith('/oracle_multimodal') ||
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
            navigatorKey: _oracleTextNavigatorKey,
            routes: [
              GoRoute(
                path: '/oracle_text',
                name: AppRoute.oracle_text.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const OracleTextScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _oracleMultimodalNavigatorKey,
            routes: [
              GoRoute(
                path: '/oracle_multimodal',
                name: AppRoute.oracle_multimodal.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const OracleMultimodalScreen(),
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
