import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entity/playlist/playlist_detail_entity.dart';
import '../../../../domain/usecase/playlist/get_playlist_by_id_usecase.dart';

part 'playlist_detail_event.dart';
part 'playlist_detail_state.dart';

class PlaylistDetailBloc extends Bloc<PlaylistDetailEvent, PlaylistDetailState> {
  final GetPlaylistByIdUsecase _getPlaylistByIdUsecase;
  PlaylistDetailBloc({
    required GetPlaylistByIdUsecase getPlaylistByIdUsecase,
  })  : _getPlaylistByIdUsecase = getPlaylistByIdUsecase,
        super(PlaylistDetailLoading()) {
    on<GetPlaylistDetail>(_getPlaylistDetail, transformer: droppable());
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
}
