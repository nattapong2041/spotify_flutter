import 'package:json_annotation/json_annotation.dart';

part 'artist_response.g.dart';

@JsonSerializable()
class ArtistResposne {
    @JsonKey(name: "id")
    String? id;
    @JsonKey(name: "name")
    String? name;
    @JsonKey(name: "type")
    String? type;

    ArtistResposne({
        this.id,
        this.name,
        this.type,
    });

    factory ArtistResposne.fromJson(Map<String, dynamic> json) => _$ArtistResposneFromJson(json);

    Map<String, dynamic> toJson() => _$ArtistResposneToJson(this);
}