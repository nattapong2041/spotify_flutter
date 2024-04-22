import 'package:equatable/equatable.dart';

class TrackEntity extends Equatable {
  final String id;
  final String name;
  final Duration duration;
  final String? artist;

  const TrackEntity({
    required this.id,
    required this.name,
    required this.duration,
    this.artist,
  });

  @override
  List<Object?> get props => [id, name, duration, artist];
}