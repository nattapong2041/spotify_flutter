part of 'playlist_me_bloc.dart';

sealed class PlaylistMeState extends Equatable {
  final List<PlaylistEntity> data;
  const PlaylistMeState({
    this.data = const [],
  });

  @override
  List<Object> get props => [];
}

final class PlaylistMeInitial extends PlaylistMeState {}

final class PlaylistMeLoading extends PlaylistMeState {}

final class PlaylistMeLoaded extends PlaylistMeState {
  final String userId;
  final bool hasNextPage;

  const PlaylistMeLoaded({required this.userId ,required super.data, this.hasNextPage = false});

  PlaylistMeLoaded copyWith({List<PlaylistEntity>? data, bool? hasNextPage}) {
    return PlaylistMeLoaded(
      userId: userId,
      data: data ?? this.data,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  @override
  List<Object> get props => [data, hasNextPage];
}

final class PlaylistMeError extends PlaylistMeState {
  final String message;

  const PlaylistMeError({this.message = ""});

  PlaylistMeError copyWith({String? message}) {
    return PlaylistMeError(message: message ?? this.message);
  }

  @override
  List<Object> get props => [message];
}
