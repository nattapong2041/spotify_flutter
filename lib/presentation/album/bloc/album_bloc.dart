import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../common/base/pagination.dart';
import '../../../domain/entity/playlist/playlist_entity.dart';
import '../../../domain/usecase/search/search_usecase.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final SearchUsecase _searchUsecase;

  Pagination<PlaylistEntity> _pagination = Pagination<PlaylistEntity>();
  AlbumBloc({
    required SearchUsecase searchUsecase,
  })  : _searchUsecase = searchUsecase,
        super(AlbumInitial()) {
    on<SearchAlbumEvent>(_onSearchAlbum, transformer: (events, mapper) {
      return restartable<SearchAlbumEvent>()
          .call(events.debounce(const Duration(milliseconds: 300)), mapper);
    });
  }

  void _onSearchAlbum(SearchAlbumEvent event, Emitter<AlbumState> emit) async {
    String? query = event.query;
    if (state is AlbumLoaded && event.query == null) {
      query = (state as AlbumLoaded).query;
    }
    if (query == null || query.isEmpty) {
      emit(AlbumInitial());
      return;
    }

    if (event.shouldRefresh) {
      _pagination = Pagination<PlaylistEntity>();
    }

    if (state is AlbumLoaded && _pagination.hasNext == false) {
      return;
    }
    if (state is! AlbumLoaded || event.shouldRefresh) {
      emit(AlbumLoading());
    }

    final result = await _searchUsecase(SearchUsecaseParams(
      query: query,
      limit: _pagination.limit,
      offset: _pagination.offset,
      type: [SearchType.album],
    ));

    if (result.isError) {
      emit(AlbumError(message: result.asError!.error.toString()));
      return;
    }

    _pagination.setNext(
      result.asValue!.value.list,
      result.asValue!.value.offset + result.asValue!.value.list.length,
      result.asValue!.value.total,
      result.asValue!.value.hasNext,
    );

    emit(AlbumLoaded(
      query: query,
      data: List.of(state.data)..addAll(_pagination.list),
      hasNextPage: _pagination.hasNext,
  ));
  }
}
