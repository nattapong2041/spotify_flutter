part of 'playlist_bloc.dart';

sealed class PlaylistEvent extends Equatable {
  const PlaylistEvent();

  @override
  List<Object> get props => [];
}

final class GetPlaylistFeatureListEvent extends PlaylistEvent {
  final bool shouldRefresh;

  const GetPlaylistFeatureListEvent({this.shouldRefresh = false});
}