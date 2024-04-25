import 'package:json_annotation/json_annotation.dart';

import 'playlist_list_response.dart';
import 'playlist_response.dart';

part 'playlist_me_response.g.dart';

@JsonSerializable()
class PlaylistMeResponse  extends PlaylistListResponse{
    PlaylistMeResponse({
        super.href,
        super.items,
        super.limit,
        super.next,
        super.offset,
        super.previous,
        super.total,
    });

    factory PlaylistMeResponse.fromJson(Map<String, dynamic> json) => _$PlaylistMeResponseFromJson(json);

    @override
    Map<String, dynamic> toJson() => _$PlaylistMeResponseToJson(this);
}