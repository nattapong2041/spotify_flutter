import 'package:json_annotation/json_annotation.dart';

import '../artist_response.dart';
import '../image_response.dart';

part 'search_item_response.g.dart';

@JsonSerializable()
class SearchItemResponse {
    @JsonKey(name: "album_type")
    String? albumType;
    @JsonKey(name: "artists")
    List<ArtistResposne>? artists;
    @JsonKey(name: "available_markets")
    List<String>? availableMarkets;
    @JsonKey(name: "href")
    String? href;
    @JsonKey(name: "id")
    String? id;
    @JsonKey(name: "images")
    List<ImageResponse>? images;
    @JsonKey(name: "name")
    String? name;
    @JsonKey(name: "release_date")
    String? releaseDate;
    @JsonKey(name: "total_tracks")
    int? totalTracks;
    @JsonKey(name: "type")
    String? type;

    SearchItemResponse({
        this.albumType,
        this.artists,
        this.availableMarkets,
        this.href,
        this.id,
        this.images,
        this.name,
        this.releaseDate,
        this.totalTracks,
        this.type,
    });

    factory SearchItemResponse.fromJson(Map<String, dynamic> json) => _$SearchItemResponseFromJson(json);

    Map<String, dynamic> toJson() => _$SearchItemResponseToJson(this);
}