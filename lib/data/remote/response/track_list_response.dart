import 'package:json_annotation/json_annotation.dart';

import 'track_response.dart';

part 'track_list_response.g.dart';

@JsonSerializable()
class TrackListResponse {
    @JsonKey(name: "href")
    String? href;
    @JsonKey(name: "items")
    List<TrackResponse>? items;
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

    TrackListResponse({
        this.href,
        this.items,
        this.limit,
        this.next,
        this.offset,
        this.previous,
        this.total,
    });

    factory TrackListResponse.fromJson(Map<String, dynamic> json) => _$TrackListResponseFromJson(json);

    Map<String, dynamic> toJson() => _$TrackListResponseToJson(this);
}