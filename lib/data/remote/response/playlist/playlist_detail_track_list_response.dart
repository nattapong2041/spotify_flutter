import 'package:json_annotation/json_annotation.dart';

import 'playlist_detail_track_response.dart';

part 'playlist_detail_track_list_response.g.dart';

@JsonSerializable()
class PlaylistDetailTrackListResponse {
    @JsonKey(name: "href")
    String? href;
    @JsonKey(name: "items")
    List<PlaylistDetailTrackResponse>? items;
    @JsonKey(name: "limit")
    int? limit;
    @JsonKey(name: "next")
    dynamic next;
    @JsonKey(name: "offset")
    int? offset;
    @JsonKey(name: "previous")
    dynamic previous;
    @JsonKey(name: "total")
    int? total;

    PlaylistDetailTrackListResponse({
        this.href,
        this.items,
        this.limit,
        this.next,
        this.offset,
        this.previous,
        this.total,
    });

    factory PlaylistDetailTrackListResponse.fromJson(Map<String, dynamic> json) => _$PlaylistDetailTrackListResponseFromJson(json);

    Map<String, dynamic> toJson() => _$PlaylistDetailTrackListResponseToJson(this);
}