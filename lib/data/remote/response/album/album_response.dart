import 'package:json_annotation/json_annotation.dart';

import '../artist_response.dart';
import '../image_response.dart';
import '../track_list_response.dart';

part 'album_response.g.dart';

@JsonSerializable()
class AlbumResponse {
    @JsonKey(name: "album_type")
    String? albumType;
    @JsonKey(name: "artists")
    List<ArtistResposne>? artists;
    @JsonKey(name: "genres")
    List<String>? genres;
    @JsonKey(name: "id")
    String? id;
    @JsonKey(name: "images")
    List<ImageResponse>? images;
    @JsonKey(name: "label")
    String? label;
    @JsonKey(name: "name")
    String? name;
    @JsonKey(name: "popularity")
    int? popularity;
    @JsonKey(name: "total_tracks")
    int? totalTracks;
    @JsonKey(name: "tracks")
    TrackListResponse? tracks;
    @JsonKey(name: "type")
    String? type;

    AlbumResponse({
        this.albumType,
        this.artists,
        this.genres,
        this.id,
        this.images,
        this.label,
        this.name,
        this.popularity,
        this.totalTracks,
        this.tracks,
        this.type,
    });

    factory AlbumResponse.fromJson(Map<String, dynamic> json) => _$AlbumResponseFromJson(json);

    Map<String, dynamic> toJson() => _$AlbumResponseToJson(this);
}