part of 'playlist_detail_bloc.dart';

sealed class PlaylistDetailEvent extends Equatable {
  const PlaylistDetailEvent();

  @override
  List<Object> get props => [];
}

final class GetPlaylistDetail extends PlaylistDetailEvent {
  final String id;

  const GetPlaylistDetail(this.id);

  @override
  List<Object> get props => [id];
}

final class AddTrackToPlaylist extends PlaylistDetailEvent {
  final String playlistId;
  final String uri;

  const AddTrackToPlaylist({
    required this.playlistId,
    required this.uri,
  });

}
