part of 'album_bloc.dart';

sealed class AlbumState extends Equatable {
  final List<PlaylistEntity> data;
  const AlbumState({
    this.data = const [],
  });

  @override
  List<Object> get props => [];
}

final class AlbumInitial extends AlbumState {}

final class AlbumLoading extends AlbumState {}

final class AlbumLoaded extends AlbumState {
  final String query;
  final bool hasNextPage;

  const AlbumLoaded({required super.data, this.hasNextPage = false, this.query = ""});

  AlbumLoaded copyWith({List<PlaylistEntity>? data, bool? hasNextPage, String? query}) {
    return AlbumLoaded(
      data: data ?? this.data,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      query: query ?? this.query,
    );
  }

  @override
  List<Object> get props => [data, hasNextPage];
}

final class AlbumError extends AlbumState {
  final String message;

  const AlbumError({this.message = ""});

  AlbumError copyWith({String? message}) {
    return AlbumError(message: message ?? this.message);
  }

  @override
  List<Object> get props => [message];
}
