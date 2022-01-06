// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MediaLinks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaLinks _$MediaLinksFromJson(Map<String, dynamic> json) {
  return MediaLinks(
      picture: json['picture'] == null
          ? null
          : Picture.fromJson(json['picture'] as Map<String, dynamic>));
}

Map<String, dynamic> _$MediaLinksToJson(MediaLinks instance) =>
    <String, dynamic>{'picture': instance.picture};
