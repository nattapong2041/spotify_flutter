import 'package:json_annotation/json_annotation.dart';

import 'playlist_response.dart';


part 'playlist_list_response.g.dart';

@JsonSerializable()
class PlaylistListResponse {
    @JsonKey(name: "href")
    String? href;
    @JsonKey(name: "items")
    List<PlaylistResponse>? items;
    @JsonKey(name: "limit")
    int? limit;
    @JsonKey(name: "next")
    String? next;
    @JsonKey(name: "offset")
    int? offset;
    @JsonKey(name: "previous")
    dynamic previous;
    @JsonKey(name: "total")
    int? total;

    PlaylistListResponse({
        this.href,
        this.items,
        this.limit,
        this.next,
        this.offset,
        this.previous,
        this.total,
    });

    factory PlaylistListResponse.fromJson(Map<String, dynamic> json) => _$PlaylistListResponseFromJson(json);

    Map<String, dynamic> toJson() => _$PlaylistListResponseToJson(this);
}