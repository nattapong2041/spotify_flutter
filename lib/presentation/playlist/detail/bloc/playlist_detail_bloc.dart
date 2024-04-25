import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entity/playlist/playlist_detail_entity.dart';
import '../../../../domain/usecase/playlist/add_item_to_playlist_usecase.dart';
import '../../../../domain/usecase/playlist/get_playlist_by_id_usecase.dart';

part 'playlist_detail_event.dart';
part 'playlist_detail_state.dart';

class PlaylistDetailBloc extends Bloc<PlaylistDetailEvent, PlaylistDetailState> {
  final GetPlaylistByIdUsecase _getPlaylistByIdUsecase;
  final AddItemToPlaylistListUsecase _addItemToPlaylistListUsecase;
  PlaylistDetailBloc({
    required GetPlaylistByIdUsecase getPlaylistByIdUsecase,
    required AddItemToPlaylistListUsecase addItemToPlaylistListUsecase,
  })  : _getPlaylistByIdUsecase = getPlaylistByIdUsecase,
        _addItemToPlaylistListUsecase = addItemToPlaylistListUsecase,
        super(PlaylistDetailLoading()) {
    on<GetPlaylistDetail>(_getPlaylistDetail, transformer: droppable());
    on<AddTrackToPlaylist>(_addTrackToPlaylist, transformer: droppable());
  }

  void _getPlaylistDetail(GetPlaylistDetail event, Emitter<PlaylistDetailState> emit) async {
    emit(PlaylistDetailLoading());
    final result = await _getPlaylistByIdUsecase.call(GetPlaylistByIdUsecaseParams(id: event.id));

    if(result.isError) {
      emit(PlaylistDetailError(result.asError!.error.toString()));
      return;
    }

    emit(PlaylistDetailLoaded(result.asValue!.value));
  }

  void _addTrackToPlaylist(AddTrackToPlaylist event, Emitter<PlaylistDetailState> emit) async {
    final result = await _addItemToPlaylistListUsecase.call(AddItemToPlaylistListUsecaseParams(
      playlistId: event.playlistId,
      uris: [event.uri],
    ));

    if(result.isError) {
      emit(PlaylistDetailError(result.asError!.error.toString()));
      return;
    }
  }
}
