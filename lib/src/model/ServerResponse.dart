import 'package:json_annotation/json_annotation.dart';

part 'ServerResponse.g.dart';

@JsonSerializable()
class ServerResponse {
  @JsonKey(name: 'success')
  final bool success;
  @JsonKey(name: 'token')
  final String token;
  @JsonKey(name: 'message')
  final String apiMessage;
  @JsonKey(name: 'data')
  final dynamic data;


  ServerResponse(this.success, this.token, this.apiMessage, this.data);

  factory ServerResponse.fromJson(Map<String, dynamic> json) =>
      _$ServerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ServerResponseToJson(this);
}
