import 'playlist_entity.dart';

class PlaylistDetailEntity extends PlaylistEntity {
  final String? image;
  final List<String> genres;

  const PlaylistDetailEntity({
    required super.id,
    required super.coverImage,
    required super.title,
    super.description,
    super.owner,
    this.image,
    required this.genres,
    required super.tracks,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        image,
        genres,
      ];
}