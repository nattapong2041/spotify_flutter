import 'package:json_annotation/json_annotation.dart';

import '../owner_response.dart';
import '../track_response.dart';

part 'playlist_detail_track_response.g.dart';

@JsonSerializable()
class PlaylistDetailTrackResponse {
    @JsonKey(name: "added_at")
    DateTime? addedAt;
    @JsonKey(name: "added_by")
    OwnerResponse? addedBy;
    @JsonKey(name: "is_local")
    bool? isLocal;
    @JsonKey(name: "track")
    TrackResponse? track;

    PlaylistDetailTrackResponse({
        this.addedAt,
        this.addedBy,
        this.isLocal,
        this.track,
    });

    factory PlaylistDetailTrackResponse.fromJson(Map<String, dynamic> json) => _$PlaylistDetailTrackResponseFromJson(json);

    Map<String, dynamic> toJson() => _$PlaylistDetailTrackResponseToJson(this);
}