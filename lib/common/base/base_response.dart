import 'package:json_annotation/json_annotation.dart';

base class BaseResponse {
  @JsonKey(name: 'status')
  int? status;

  @JsonKey(name: 'message')
  String? message;

  BaseResponse({this.status, this.message});
}
