part of 'playlist_detail_bloc.dart';

sealed class PlaylistDetailState extends Equatable {
  const PlaylistDetailState();
  
  @override
  List<Object> get props => [];
}

final class PlaylistDetailLoading extends PlaylistDetailState {}

final class PlaylistDetailLoaded extends PlaylistDetailState {
  final PlaylistDetailEntity data;
  
  const PlaylistDetailLoaded(this.data);
  
  @override
  List<Object> get props => [data];
}

final class PlaylistDetailError extends PlaylistDetailState {
  final String message;
  
  const PlaylistDetailError(this.message);
  
  @override
  List<Object> get props => [message];
}
