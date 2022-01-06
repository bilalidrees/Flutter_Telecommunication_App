import 'package:json_annotation/json_annotation.dart';

import 'Picture.dart';

part 'MediaLinks.g.dart';

@JsonSerializable()
class MediaLinks {
  @JsonKey(name: 'picture')
  Picture? picture;

  MediaLinks({
     this.picture,
  });

  factory MediaLinks.fromJson(Map<String, dynamic> json) =>
      _$MediaLinksFromJson(json);

  Map<String, dynamic> toJson() => _$MediaLinksToJson(this);
}
