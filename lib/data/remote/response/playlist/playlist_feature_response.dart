import 'package:json_annotation/json_annotation.dart';

import 'playlist_list_response.dart';

part 'playlist_feature_response.g.dart';

@JsonSerializable()
class PlaylistFeatureResponse {
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "playlists")
    PlaylistListResponse? playlists;

    PlaylistFeatureResponse({
        this.message,
        this.playlists,
    });

    factory PlaylistFeatureResponse.fromJson(Map<String, dynamic> json) => _$PlaylistFeatureResponseFromJson(json);

    Map<String, dynamic> toJson() => _$PlaylistFeatureResponseToJson(this);
}