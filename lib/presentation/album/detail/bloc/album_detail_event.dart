part of 'album_detail_bloc.dart';

sealed class AlbumDetailEvent extends Equatable {
  const AlbumDetailEvent();

  @override
  List<Object> get props => [];
}

final class GetAlbumDetail extends AlbumDetailEvent {
  final String id;

  const GetAlbumDetail(this.id);

  @override
  List<Object> get props => [id];
}
