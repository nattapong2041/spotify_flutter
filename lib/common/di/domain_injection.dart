import 'package:get_it/get_it.dart';

import '../../domain/repository/album_repository.dart';
import '../../domain/repository/authorization_repository.dart';
import '../../domain/repository/playlist_repository.dart';
import '../../domain/repository/search_repository.dart';
import '../../domain/usecase/album/get_album_by_id_usecase.dart';
import '../../domain/usecase/authorization/login_usecase.dart';
import '../../domain/usecase/playlist/create_playlist_usecase.dart';
import '../../domain/usecase/playlist/get_playlist_by_id_usecase.dart';
import '../../domain/usecase/playlist/get_playlist_feature_list_usecase.dart';
import '../../domain/usecase/playlist/get_playlist_me_list_usecase.dart';
import '../../domain/usecase/search/search_usecase.dart';
import 'app_dependency_injection.dart';

/// Domain Layer Injection
class DomainInjection {
  static void inject() {
    injector.pushNewScope(
        scopeName: 'Authorization Domain',
        init: (GetIt getIt) {
          getIt.registerLazySingleton<LoginUseCase>(
            () => LoginUseCase(
              repository: getIt.get<AuthorizationRepository>(),
            ),
          );
        });

    injector.pushNewScope(
        scopeName: 'Playlist Domain',
        init: (GetIt getIt) {
          getIt.registerLazySingleton<GetPlaylistFeatureListUsecase>(
            () => GetPlaylistFeatureListUsecase(
              repository: getIt.get<PlaylistRepository>(),
            ),
          );
          getIt.registerLazySingleton<GetPlaylistMeListUsecase>(
            () => GetPlaylistMeListUsecase(
              repository: getIt.get<PlaylistRepository>(),
            ),
          );
          getIt.registerLazySingleton<CreatePlaylistListUsecase>(
            () => CreatePlaylistListUsecase(
              repository: getIt.get<PlaylistRepository>(),
            ),
          );
          getIt.registerLazySingleton<GetPlaylistByIdUsecase>(
            () => GetPlaylistByIdUsecase(
              repository: getIt.get<PlaylistRepository>(),
            ),
          );
        });

    injector.pushNewScope(
        scopeName: 'Searc Domain',
        init: (GetIt getIt) {
          getIt.registerLazySingleton<SearchUsecase>(
            () => SearchUsecase(
              repository: getIt.get<SearchRepository>(),
            ),
          );
        });

    injector.pushNewScope(
        scopeName: 'Album Domain',
        init: (GetIt getIt) {
          getIt.registerLazySingleton<GetAlbumByIdUsecase>(
            () => GetAlbumByIdUsecase(
              repository: getIt.get<AlbumRepository>(),
            ),
          );
        });
  }
}
