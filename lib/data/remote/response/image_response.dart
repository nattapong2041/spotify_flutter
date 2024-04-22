import 'package:json_annotation/json_annotation.dart';

part 'image_response.g.dart';

@JsonSerializable()
class ImageResponse {
    @JsonKey(name: "url")
    String? url;
    @JsonKey(name: "height")
    int? height;
    @JsonKey(name: "width")
    int? width;

    ImageResponse({
        this.url,
        this.height,
        this.width,
    });

    factory ImageResponse.fromJson(Map<String, dynamic> json) => _$ImageResponseFromJson(json);

    Map<String, dynamic> toJson() => _$ImageResponseToJson(this);
}
