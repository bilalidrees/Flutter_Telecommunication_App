import 'package:json_annotation/json_annotation.dart';

part 'SubCategory.g.dart';

@JsonSerializable()
class SubCategory {
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'label')
  final String label;
  @JsonKey(name: 'linkPage')
  String linkPage;
  @JsonKey(name: 'cardType')
  final String cardType;
  String image;

  SubCategory(
      {required this.name,
      required this.label,
      required this.linkPage,
      required this.cardType,
      required this.image});

  factory SubCategory.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SubCategoryToJson(this);
}
