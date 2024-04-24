import 'package:json_annotation/json_annotation.dart';

import 'search_item_response.dart';

part 'search_response.g.dart';

@JsonSerializable()
class SearchResponse {
    @JsonKey(name: "href")
    String? href;
    @JsonKey(name: "items")
    List<SearchItemResponse>? items;
    @JsonKey(name: "limit")
    int? limit;
    @JsonKey(name: "next")
    String? next;
    @JsonKey(name: "offset")
    int? offset;
    @JsonKey(name: "total")
    int? total;

    SearchResponse({
        this.href,
        this.items,
        this.limit,
        this.next,
        this.offset,
        this.total,
    });

    factory SearchResponse.fromJson(Map<String, dynamic> json) => _$SearchResponseFromJson(json);

    Map<String, dynamic> toJson() => _$SearchResponseToJson(this);
}