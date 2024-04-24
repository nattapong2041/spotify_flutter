part of 'album_bloc.dart';

sealed class AlbumEvent extends Equatable {
  const AlbumEvent();

  @override
  List<Object> get props => [];
}

final class SearchAlbumEvent extends AlbumEvent {
  final String? query;
  final bool shouldRefresh;

  const SearchAlbumEvent({this.query, this.shouldRefresh = false});
}