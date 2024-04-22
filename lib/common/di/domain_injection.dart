import 'package:get_it/get_it.dart';

import '../../domain/repository/authorization_repository.dart';
import '../../domain/repository/playlist_repository.dart';
import '../../domain/usecase/authorization/login_usecase.dart';
import '../../domain/usecase/playlist/get_playlist_feature_list_usecase.dart';
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
        });
  }
}
