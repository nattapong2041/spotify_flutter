import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:realm/realm.dart';

import '../../data/local/realm/credential_rmodel.dart';
import '../../presentation/album/album_screen.dart';
import '../../presentation/album/bloc/album_bloc.dart';
import '../../presentation/album/detail/album_detail_screen.dart';
import '../../presentation/album/detail/bloc/album_detail_bloc.dart';
import '../../presentation/login/login_screen.dart';
import '../../presentation/main_screen.dart';
import '../../presentation/playlist/bloc/playlist_bloc.dart';
import '../../presentation/playlist/detail/bloc/playlist_detail_bloc.dart';
import '../../presentation/playlist/detail/playlist_detail_screen.dart';
import '../../presentation/playlist/me/bloc/playlist_me_bloc.dart';
import '../../presentation/playlist/me/playlist_me_screen.dart';
import '../../presentation/playlist/playlist_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

/// Screen paths for all app routes
class ScreenPaths {
  static String login = '/login';
  static String playlist = '/';
  static String playlistDetail = '/playlist/detail';
  static String album = '/album';
  static String albumDetail = '/album/detail';
  static String mePlaylist = '/me/playlists';
  static String mePlaylistDetail = '/me/playlist/detail';
}

/// Main app routes using Go Router package
/// which contains the bottom navigation bar routes
/// and also all app routes working with path
final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: GetIt.instance.get<Realm>().all<CredentialRModel>().firstOrNull?.token != null
      ? ScreenPaths.playlist
      : ScreenPaths.login,
  routes: <RouteBase>[
    GoRoute(
      name: ScreenPaths.login,
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
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
              routes: [
                  GoRoute(
                    name: ScreenPaths.playlistDetail,
                    path: 'detail/:id',
                    builder: (context, state) => BlocProvider(
                      create: (context) => GetIt.I.get<PlaylistDetailBloc>()
                        ..add(GetPlaylistDetail(state.pathParameters['id']!)),
                      child: PlaylistDetailScreen(id: state.pathParameters['id']!, userId: 'other'),
                    ),
                  )
                ]
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              name: ScreenPaths.album,
              path: '/album',
              builder: (context, state) => BlocProvider(
                create: (context) => GetIt.I.get<AlbumBloc>(),
                child: const AlbumScreen(),
              ),
              routes: [
                GoRoute(
                  name: ScreenPaths.albumDetail,
                  path: 'detail/:id',
                  builder: (context, state) => BlocProvider(
                    create: (context) => GetIt.I.get<AlbumDetailBloc>()
                      ..add(GetAlbumDetail(state.pathParameters['id']!)),
                    child: const AlbumDetailScreen(),
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
                name: ScreenPaths.mePlaylist,
                path: '/me/playlists',
                builder: (context, state) => BlocProvider(
                      create: (context) => GetIt.I.get<PlaylistMeBloc>(),
                      child: const PlaylistMeScren(),
                    ),
                routes: [
                  GoRoute(
                    name: ScreenPaths.mePlaylistDetail,
                    path: 'detail/:id',
                    builder: (context, state) => BlocProvider(
                      create: (context) => GetIt.I.get<PlaylistDetailBloc>()
                        ..add(GetPlaylistDetail(state.pathParameters['id']!)),
                      child: PlaylistDetailScreen(id: state.pathParameters['id']!, userId: 'me'),
                    ),
                  )
                ]),
          ],
        ),
      ],
    ),
  ],
);
