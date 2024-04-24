import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entity/playlist/playlist_detail_entity.dart';
import '../../../../domain/usecase/album/get_album_by_id_usecase.dart';

part 'album_detail_event.dart';
part 'album_detail_state.dart';

class AlbumDetailBloc extends Bloc<AlbumDetailEvent, AlbumDetailState> {
  final GetAlbumByIdUsecase _getAlbumByIdUsecase;
  AlbumDetailBloc({
    required GetAlbumByIdUsecase getAlbumByIdUsecase,
  })  : _getAlbumByIdUsecase = getAlbumByIdUsecase,
        super(AlbumDetailLoading()) {
    on<GetAlbumDetail>(_getAlbumDetail, transformer: droppable());
  }

  void _getAlbumDetail(GetAlbumDetail event, Emitter<AlbumDetailState> emit) async {
    emit(AlbumDetailLoading());
    final result = await _getAlbumByIdUsecase.call(GetAlbumByIdUsecaseParams(id: event.id));

    if(result.isError) {
      emit(AlbumDetailError(result.asError!.error.toString()));
      return;
    }

    emit(AlbumDetailLoaded(result.asValue!.value));
  }
}
