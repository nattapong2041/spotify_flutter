import 'package:get_it/get_it.dart';

// import '../../domain/usecase/news/get_news_usecase.dart';
// import '../../features/news/bloc/news_bloc.dart';
import '../../domain/usecase/album/get_album_by_id_usecase.dart';
import '../../domain/usecase/playlist/add_item_to_playlist_usecase.dart';
import '../../domain/usecase/playlist/create_playlist_usecase.dart';
import '../../domain/usecase/playlist/get_playlist_by_id_usecase.dart';
import '../../domain/usecase/playlist/get_playlist_feature_list_usecase.dart';
import '../../domain/usecase/playlist/get_playlist_me_list_usecase.dart';
import '../../domain/usecase/search/search_usecase.dart';
import '../../presentation/album/bloc/album_bloc.dart';
import '../../presentation/album/detail/bloc/album_detail_bloc.dart';
import '../../presentation/playlist/bloc/playlist_bloc.dart';
import '../../presentation/playlist/detail/bloc/playlist_detail_bloc.dart';
import '../../presentation/playlist/me/bloc/playlist_me_bloc.dart';
import 'app_dependency_injection.dart';

/// Presenter Layer Injection which is used to inject all blocs
class PresenterInjection {
  static void inject() {
    injector.pushNewScope(
      scopeName: 'Playlist',
      init: (GetIt getIt) {
        getIt.registerFactory<PlaylistBloc>(() => PlaylistBloc(
            getPlaylistFeatureListUsecase: GetIt.I.get<GetPlaylistFeatureListUsecase>()));
        getIt.registerFactory<PlaylistMeBloc>(() => PlaylistMeBloc(
            createPlaylistListUsecase: GetIt.I.get<CreatePlaylistListUsecase>(),
            getPlaylistMeListUsecase: GetIt.I.get<GetPlaylistMeListUsecase>()));
        getIt.registerFactory<PlaylistDetailBloc>(() => PlaylistDetailBloc(
            addItemToPlaylistListUsecase: GetIt.I.get<AddItemToPlaylistListUsecase>(),
            getPlaylistByIdUsecase: GetIt.I.get<GetPlaylistByIdUsecase>()));
      },
    );

    injector.pushNewScope(
      scopeName: 'Album',
      init: (GetIt getIt) {
        getIt.registerFactory<AlbumBloc>(
            () => AlbumBloc(searchUsecase: GetIt.I.get<SearchUsecase>()));
        getIt.registerFactory<AlbumDetailBloc>(
            () => AlbumDetailBloc(getAlbumByIdUsecase: GetIt.I.get<GetAlbumByIdUsecase>()));
      },
    );
  }
}
