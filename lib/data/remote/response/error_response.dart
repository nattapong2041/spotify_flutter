import 'package:json_annotation/json_annotation.dart';

import '../../../common/base/base_response.dart';

part 'error_response.g.dart';

@JsonSerializable()
final class ErrorResponse extends BaseResponse {
    ErrorResponse({
        super.status,
        super.message,
    });

    factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);

    Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}
