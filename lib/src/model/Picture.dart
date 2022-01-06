import 'package:json_annotation/json_annotation.dart';

part 'Picture.g.dart';

@JsonSerializable()
class Picture {
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'link')
  String link;

  Picture({required this.title, required this.link});

  factory Picture.fromJson(Map<String, dynamic> json) =>
      _$PictureFromJson(json);

  Map<String, dynamic> toJson() => _$PictureToJson(this);
}
