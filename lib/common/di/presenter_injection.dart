import 'package:get_it/get_it.dart';


// import '../../domain/usecase/news/get_news_usecase.dart';
// import '../../features/news/bloc/news_bloc.dart';
import '../../domain/usecase/playlist/get_playlist_feature_list_usecase.dart';
import '../../presentation/playlist/bloc/playlist_bloc.dart';
import 'app_dependency_injection.dart';

/// Presenter Layer Injection which is used to inject all blocs
class PresenterInjection {
  static void inject() {
    injector.pushNewScope(
      scopeName: 'News',
      init: (GetIt getIt) {
        getIt.registerFactory<PlaylistBloc>(() => PlaylistBloc(
          getPlaylistFeatureListUsecase: GetIt.I.get<GetPlaylistFeatureListUsecase>()
        ));
      },
    );
  }
}
