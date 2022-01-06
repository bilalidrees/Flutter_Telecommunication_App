import 'package:json_annotation/json_annotation.dart';

part 'SourList.g.dart';

@JsonSerializable()
class SourList {
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'label')
  String label;
  @JsonKey(name: 'linkPage')
  String linkPage;
  @JsonKey(name: 'cardType')
  String cardType;
  @JsonKey(name: 'image')
  String image;
  @JsonKey(name: 'logo')
  String logo;

  SourList(
      {required this.name,
      required this.label,
      required this.linkPage,
      required this.cardType,
      required this.image,
      required this.logo});

  factory SourList.fromJson(Map<String, dynamic> json) =>
      _$SourListFromJson(json);

  Map<String, dynamic> toJson() => _$SourListToJson(this);
}
