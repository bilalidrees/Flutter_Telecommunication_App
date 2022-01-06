// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
      category: json['category'] as String,
      item: (json['item'] as List)
          .map((e) => e == null
              ? null
              : SubCategory.fromJson(e as Map<String, dynamic>))
          .toList());
}

Map<String, dynamic> _$CategoryToJson(Category instance) =>
    <String, dynamic>{'category': instance.category, 'item': instance.item};
