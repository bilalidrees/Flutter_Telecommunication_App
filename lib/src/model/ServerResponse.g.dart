// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ServerResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerResponse _$ServerResponseFromJson(Map<String, dynamic> json) {
  return ServerResponse(json['success'] as bool, json['token'] as String,
      json['message'] as String, json['data']);
}

Map<String, dynamic> _$ServerResponseToJson(ServerResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'token': instance.token,
      'message': instance.apiMessage,
      'data': instance.data
    };
