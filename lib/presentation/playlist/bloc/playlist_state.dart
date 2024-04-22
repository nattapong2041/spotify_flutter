part of 'playlist_bloc.dart';

sealed class PlaylistState extends Equatable {
  final List<PlaylistEntity> data;
  const PlaylistState({
    this.data = const [],
  });

  @override
  List<Object> get props => [];
}

final class PlaylistInitial extends PlaylistState {}

final class PlaylistLoading extends PlaylistState {}

final class PlaylistLoaded extends PlaylistState {
  final String message;
  
  final bool hasNextPage;

  const PlaylistLoaded({required super.data, this.message = "", this.hasNextPage = false});

  PlaylistLoaded copyWith({List<PlaylistEntity>? data, String? message}) {
    return PlaylistLoaded(data: data ?? this.data, message: message ?? this.message);
  }

  @override
  List<Object> get props => [data, message];
}

final class PlaylistError extends PlaylistState {
  final String message;

  const PlaylistError({this.message = ""});

  PlaylistError copyWith({String? message}) {
    return PlaylistError(message: message ?? this.message);
  }

  @override
  List<Object> get props => [message];
}
