import 'package:json_annotation/json_annotation.dart';
import 'package:ufone_web/src/model/SubCategory.dart';

part 'Category.g.dart';

@JsonSerializable()
class Category {
  @JsonKey(name: 'category')
  String category;
  @JsonKey(name: 'item')
  List<SubCategory?>? item;

  Category({
    required this.category,
    required this.item,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
