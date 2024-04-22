import 'package:json_annotation/json_annotation.dart';

part 'owner_response.g.dart';

@JsonSerializable()
class OwnerResponse {
    @JsonKey(name: "display_name")
    String? displayName;
    @JsonKey(name: "id")
    String? id;
    @JsonKey(name: "type")
    String? type;

    OwnerResponse({
        this.displayName,
        this.id,
        this.type,
    });

    factory OwnerResponse.fromJson(Map<String, dynamic> json) => _$OwnerResponseFromJson(json);

    Map<String, dynamic> toJson() => _$OwnerResponseToJson(this);
}