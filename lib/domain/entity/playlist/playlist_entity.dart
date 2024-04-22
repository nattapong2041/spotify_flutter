import 'package:equatable/equatable.dart';

class PlaylistEntity extends Equatable {
  final String id;
  final String? coverImage;
  final String title;
  final String? description;
  final String? owner;

  const PlaylistEntity({
    required this.id,
    this.coverImage,
    required this.title,
    this.description,
    this.owner,
  });

  @override
  List<Object?> get props => [
        id,
        coverImage,
        title,
        description,
        owner,
      ];
}
