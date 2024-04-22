import '../track_entity.dart';
import 'playlist_entity.dart';

class PlaylistDetailEntity extends PlaylistEntity {
  final String image;
  final List<String> genres;
  final List<TrackEntity> tracks;

  const PlaylistDetailEntity({
    required super.id,
    required super.coverImage,
    required super.title,
    super.description,
    super.owner,
    required this.image,
    required this.genres,
    required this.tracks,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        image,
        genres,
        tracks,
      ];
}