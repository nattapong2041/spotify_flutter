import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entity/playlist/playlist_entity.dart';
import '../image_response.dart';
import '../owner_response.dart';

part 'playlist_response.g.dart';

@JsonSerializable()
class PlaylistResponse {
    @JsonKey(name: "description")
    String? description;
    @JsonKey(name: "id")
    String? id;
    @JsonKey(name: "images")
    List<ImageResponse>? images;
    @JsonKey(name: "name")
    String? name;
    @JsonKey(name: "owner")
    OwnerResponse? owner;
    @JsonKey(name: "type")
    String? type;

    PlaylistResponse({
        this.description,
        this.id,
        this.images,
        this.name,
        this.owner,
        this.type,
    });

    factory PlaylistResponse.fromJson(Map<String, dynamic> json) => _$PlaylistResponseFromJson(json);

    Map<String, dynamic> toJson() => _$PlaylistResponseToJson(this);
}

extension PlaylistResponseExtension on PlaylistResponse {
  PlaylistEntity toEntity() {
    return PlaylistEntity(
      description: description,
      id: id!,
      coverImage: images?.first.url,
      title: name ?? "",
      owner: owner?.displayName,
    );
  }
}