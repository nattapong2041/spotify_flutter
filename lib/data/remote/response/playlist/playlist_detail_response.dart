import 'package:json_annotation/json_annotation.dart';

import '../image_response.dart';
import '../owner_response.dart';
import 'playlist_detail_track_list_response.dart';

part 'playlist_detail_response.g.dart';

@JsonSerializable()
class PlaylistDetailResponse {
    @JsonKey(name: "description")
    String? description;
    @JsonKey(name: "href")
    String? href;
    @JsonKey(name: "id")
    String? id;
    @JsonKey(name: "images")
    List<ImageResponse>? images;
    @JsonKey(name: "name")
    String? name;
    @JsonKey(name: "owner")
    OwnerResponse? owner;
    @JsonKey(name: "public")
    bool? public;
    @JsonKey(name: "tracks")
    PlaylistDetailTrackListResponse? tracks;
    @JsonKey(name: "type")
    String? type;
    @JsonKey(name: "uri")
    String? uri;

    PlaylistDetailResponse({
        this.description,
        this.href,
        this.id,
        this.images,
        this.name,
        this.owner,
        this.public,
        this.tracks,
        this.type,
        this.uri,
    });

    factory PlaylistDetailResponse.fromJson(Map<String, dynamic> json) => _$PlaylistDetailResponseFromJson(json);

    Map<String, dynamic> toJson() => _$PlaylistDetailResponseToJson(this);
}