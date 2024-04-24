import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entity/track_entity.dart';
import 'artist_response.dart';

part 'track_response.g.dart';

@JsonSerializable()
class TrackResponse {
    @JsonKey(name: "artists")
    List<ArtistResposne>? artists;
    @JsonKey(name: "available_markets")
    List<String>? availableMarkets;
    @JsonKey(name: "disc_number")
    int? discNumber;
    @JsonKey(name: "duration_ms")
    int? durationMs;
    @JsonKey(name: "explicit")
    bool? explicit;
    @JsonKey(name: "href")
    String? href;
    @JsonKey(name: "id")
    String? id;
    @JsonKey(name: "is_local")
    bool? isLocal;
    @JsonKey(name: "name")
    String? name;
    @JsonKey(name: "preview_url")
    String? previewUrl;
    @JsonKey(name: "track_number")
    int? trackNumber;
    @JsonKey(name: "uri")
    String? uri;

    TrackResponse({
        this.artists,
        this.availableMarkets,
        this.discNumber,
        this.durationMs,
        this.explicit,
        this.href,
        this.id,
        this.isLocal,
        this.name,
        this.previewUrl,
        this.trackNumber,
        this.uri,
    });

    factory TrackResponse.fromJson(Map<String, dynamic> json) => _$TrackResponseFromJson(json);

    Map<String, dynamic> toJson() => _$TrackResponseToJson(this);
}

extension TrackResponseExtension on TrackResponse {
  TrackEntity toEntity() {
    return TrackEntity(
      id: id ?? "",
      name: name ?? "",
      duration: Duration(milliseconds: durationMs ?? 0),
      artist: artists?.map((e) => e.name).join(", "),
    );
  }
}