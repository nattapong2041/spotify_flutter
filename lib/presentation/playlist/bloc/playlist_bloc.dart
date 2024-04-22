import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../common/base/pagination.dart';
import '../../../domain/entity/playlist/playlist_entity.dart';
import '../../../domain/usecase/playlist/get_playlist_feature_list_usecase.dart';

part 'playlist_event.dart';
part 'playlist_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  final GetPlaylistFeatureListUsecase _getPlaylistFeatureListUsecase;

  Pagination<PlaylistEntity> _pagination = Pagination<PlaylistEntity>();

  PlaylistBloc({required GetPlaylistFeatureListUsecase getPlaylistFeatureListUsecase})
      : _getPlaylistFeatureListUsecase = getPlaylistFeatureListUsecase,
        super(PlaylistInitial()) {
    on<GetPlaylistFeatureListEvent>(
      _fetchFeatureList,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  void _fetchFeatureList(GetPlaylistFeatureListEvent event, Emitter<PlaylistState> emit) async {
    if (state is PlaylistLoaded && _pagination.hasNext == false) {
      return;
    }
    if (state is! PlaylistLoaded || event.shouldRefresh) {
      emit(PlaylistLoading());
    }

    if (event.shouldRefresh) {
      _pagination = Pagination<PlaylistEntity>();
    }

    final result = await _getPlaylistFeatureListUsecase(
        GetPlaylistFeatureListUsecaseParams(limit: _pagination.limit, offset: _pagination.offset));

    if (result.isError) {
      emit(PlaylistError(message: result.asError!.error.toString()));
      return;
    }

    _pagination.setNext(
      result.asValue!.value.$2.list,
      result.asValue!.value.$2.offset + result.asValue!.value.$2.list.length,
      result.asValue!.value.$2.total,
      result.asValue!.value.$2.hasNext,
    );

    emit(PlaylistLoaded(
        data: List.of(state.data)..addAll(_pagination.list),
        message: result.asValue!.value.$1,
        hasNextPage: _pagination.hasNext));
  }
}
