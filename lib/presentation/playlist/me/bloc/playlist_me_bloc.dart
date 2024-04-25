import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../../common/base/pagination.dart';
import '../../../../domain/entity/playlist/playlist_entity.dart';
import '../../../../domain/usecase/playlist/create_playlist_usecase.dart';
import '../../../../domain/usecase/playlist/get_playlist_me_list_usecase.dart';

part 'playlist_me_event.dart';
part 'playlist_me_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PlaylistMeBloc extends Bloc<PlaylistMeEvent, PlaylistMeState> {
  final GetPlaylistMeListUsecase _getPlaylistMeListUsecase;
  final CreatePlaylistListUsecase _createPlaylistListUsecase;

  Pagination<PlaylistEntity> _pagination = Pagination<PlaylistEntity>();

  PlaylistMeBloc(
      {required GetPlaylistMeListUsecase getPlaylistMeListUsecase,
      required CreatePlaylistListUsecase createPlaylistListUsecase})
      : _getPlaylistMeListUsecase = getPlaylistMeListUsecase,
        _createPlaylistListUsecase = createPlaylistListUsecase,
        super(PlaylistMeInitial()) {
    on<PlaylistMeFetch>(
      _fetchFeatureList,
      transformer: throttleDroppable(throttleDuration),
    );
    on<PlaylistMeCreate>(_createPlaylist);
  }

  void _fetchFeatureList(PlaylistMeFetch event, Emitter<PlaylistMeState> emit) async {
    if (state is PlaylistMeLoaded && _pagination.hasNext == false && !event.refresh) {
      return;
    }

    if (state is! PlaylistMeLoaded || event.refresh) {
      emit(PlaylistMeLoading());
    }

    if (event.refresh) {
      _pagination = Pagination<PlaylistEntity>();
    }

    final result = await _getPlaylistMeListUsecase(
        GetPlaylistMeListUsecaseParams(limit: _pagination.limit, offset: _pagination.offset));

    if (result.isError) {
      emit(PlaylistMeError(message: result.asError!.error.toString()));
      return;
    }

    _pagination.setNext(
      result.asValue!.value.$2.list,
      result.asValue!.value.$2.offset + result.asValue!.value.$2.list.length,
      result.asValue!.value.$2.total,
      result.asValue!.value.$2.hasNext,
    );
    // Clear duplicate data
    final newList = List.of(state.data)..addAll(_pagination.list);

    emit(PlaylistMeLoaded(
        userId: result.asValue!.value.$1,
        data: newList.toSet().toList(),
        hasNextPage: _pagination.hasNext));
  }

  void _createPlaylist(PlaylistMeCreate event, Emitter<PlaylistMeState> emit) async {
    if (state is! PlaylistMeLoaded) {
      return;
    }
    final currentState = state as PlaylistMeLoaded;
    final result = await _createPlaylistListUsecase(CreatePlaylistListUsecaseParams(
        userId: currentState.userId, title: event.name));
    if (result.isError) {
      emit(PlaylistMeError(message: result.asError!.error.toString()));
      return;
    }

    emit(currentState.copyWith(data: List.of(state.data)..insert(0, result.asValue!.value)));
  }
}
