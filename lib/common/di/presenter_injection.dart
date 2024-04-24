import 'package:get_it/get_it.dart';

// import '../../domain/usecase/news/get_news_usecase.dart';
// import '../../features/news/bloc/news_bloc.dart';
import '../../domain/usecase/album/get_album_by_id_usecase.dart';
import '../../domain/usecase/playlist/get_playlist_feature_list_usecase.dart';
import '../../domain/usecase/search/search_usecase.dart';
import '../../presentation/album/bloc/album_bloc.dart';
import '../../presentation/album/detail/bloc/album_detail_bloc.dart';
import '../../presentation/playlist/bloc/playlist_bloc.dart';
import 'app_dependency_injection.dart';

/// Presenter Layer Injection which is used to inject all blocs
class PresenterInjection {
  static void inject() {
    injector.pushNewScope(
      scopeName: 'News',
      init: (GetIt getIt) {
        getIt.registerFactory<PlaylistBloc>(() => PlaylistBloc(
            getPlaylistFeatureListUsecase: GetIt.I.get<GetPlaylistFeatureListUsecase>()));
      },
    );

    injector.pushNewScope(
      scopeName: 'Album',
      init: (GetIt getIt) {
        getIt.registerFactory<AlbumBloc>(() => AlbumBloc(
            searchUsecase: GetIt.I.get<SearchUsecase>()));
                    getIt.registerFactory<AlbumDetailBloc>(() => AlbumDetailBloc(
            getAlbumByIdUsecase: GetIt.I.get<GetAlbumByIdUsecase>()));
      },
    );
  }
}
