import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';

// import '../../data/repository/news_repository_impl.dart';
// import '../../data/service/remote/news_remote.dart';
import '../../data/authorization_repository_impl.dart';
import '../../data/local/authorization_local.dart';
import '../../data/playlist_repository_impl.dart';
import '../../data/remote/authorization_remote.dart';
import '../../data/remote/playlist_remote.dart';
import '../../domain/repository/authorization_repository.dart';
import '../../domain/repository/playlist_repository.dart';
import 'app_dependency_injection.dart';

/// Data model injection
class DataInjection {
  static void inject() {
    injector.pushNewScope(
      scopeName: 'Authorization Data',
      init: (GetIt getIt) {
        getIt.registerLazySingleton<AuthorizationRemote>(
            () => AuthorizationRemote(dio: getIt.get<Dio>(instanceName: 'account')));
        getIt.registerLazySingleton<AuthorizationLocal>(
            () => AuthorizationLocal(realm: getIt.get<Realm>()));
        getIt.registerLazySingleton<AuthorizationRepository>(() => AuthorizationRepositoryImpl(
            local: getIt.get<AuthorizationLocal>(), remote: getIt.get<AuthorizationRemote>()));
      },
    );

    injector.pushNewScope(
      scopeName: 'Playlist Data',
      init: (GetIt getIt) {
        getIt.registerLazySingleton<PlaylistRemote>(() => PlaylistRemote(dio: getIt.get<Dio>()));
        getIt.registerLazySingleton<PlaylistRepository>(
            () => PlaylistRepositoryImpl(remote: getIt.get<PlaylistRemote>()));
      },
    );
  }
}
