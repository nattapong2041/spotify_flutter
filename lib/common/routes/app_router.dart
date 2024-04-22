import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/main_screen.dart';
import '../../presentation/playlist/bloc/playlist_bloc.dart';
import '../../presentation/playlist/playlist_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

/// Screen paths for all app routes
class ScreenPaths {
  static String playlist = '/';
  static String chat = '/chat';
  static String setting = '/setting';
}

/// Main app routes using Go Router package
/// which contains the bottom navigation bar routes
/// and also all app routes working with path
final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: ScreenPaths.playlist,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder:
          (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
        return MainScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              name: ScreenPaths.playlist,
              path: '/',
              builder: (context, state) => BlocProvider(
                create: (context) => GetIt.I.get<PlaylistBloc>(),
                child: const PlaylistScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              name: ScreenPaths.chat,
              path: '/chat',
              builder: (context, state) => const Scaffold(
                body: Center(
                  child: Text('Chat'),
                ),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              name: ScreenPaths.setting,
              path: '/setting',
              builder: (context, state) => const Scaffold(
                body: Center(
                  child: Text('Setting'),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
