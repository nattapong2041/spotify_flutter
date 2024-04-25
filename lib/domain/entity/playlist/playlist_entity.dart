import 'package:equatable/equatable.dart';

import '../track_entity.dart';

class PlaylistEntity extends Equatable {
  final String id;
  final String? coverImage;
  final String title;
  final String? description;
  final String? owner;
  final List<TrackEntity> tracks;

  const PlaylistEntity({
    required this.id,
    this.coverImage,
    required this.title,
    this.description,
    this.owner,
    this.tracks = const [],
  });

  @override
  List<Object?> get props => [
        id,
        coverImage,
        title,
        description,
        owner,
        tracks,
      ];
}
