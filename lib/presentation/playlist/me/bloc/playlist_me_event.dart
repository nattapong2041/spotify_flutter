part of 'playlist_me_bloc.dart';

sealed class PlaylistMeEvent extends Equatable {
  const PlaylistMeEvent();

  @override
  List<Object> get props => [];
}

final class PlaylistMeFetch extends PlaylistMeEvent {
  final bool refresh;

  const PlaylistMeFetch({this.refresh = false});
}

final class PlaylistMeCreate extends PlaylistMeEvent {
  final String name;

  const PlaylistMeCreate({required this.name});
}