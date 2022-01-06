// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SourList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourList _$SourListFromJson(Map<String, dynamic> json) {
  return SourList(
      name: json['name'] as String,
      label: json['label'] as String,
      linkPage: json['linkPage'] as String,
      cardType: json['cardType'] as String,
      image: json['image'] as String,
      logo: json['logo'] as String);
}

Map<String, dynamic> _$SourListToJson(SourList instance) => <String, dynamic>{
      'name': instance.name,
      'label': instance.label,
      'linkPage': instance.linkPage,
      'cardType': instance.cardType,
      'image': instance.image,
      'logo': instance.logo
    };
