// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubCategory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubCategory _$SubCategoryFromJson(Map<String, dynamic> json) {
  return SubCategory(
      name: json['name'] as String,
      label: json['label'] as String,
      linkPage: json['linkPage'] as String,
      cardType: json['cardType'] as String,
      image: json['image'] as String);
}

Map<String, dynamic> _$SubCategoryToJson(SubCategory instance) =>
    <String, dynamic>{
      'name': instance.name,
      'label': instance.label,
      'linkPage': instance.linkPage,
      'cardType': instance.cardType,
      'image': instance.image
    };
