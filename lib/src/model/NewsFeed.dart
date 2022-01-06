import 'package:json_annotation/json_annotation.dart';
import 'package:ufone_web/src/model/MediaLinks.dart';

part 'NewsFeed.g.dart';

@JsonSerializable()
class NewsFeed {
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'description')
  String description;
  @JsonKey(name: 'encoded_content')
  String encodedContent;
  @JsonKey(name: 'long_description')
  String longDescription;
  @JsonKey(name: 'tuuid')
  String tuuid;
  @JsonKey(name: 'sno')
  int sno;
  @JsonKey(name: 'media_links')
  MediaLinks? mediaLinks;
  @JsonKey(name: 'pubdate')
  String pubdate;
  @JsonKey(name: 'lang')
  String lang;
  String articlePublishedTime;
  String image;

  NewsFeed(
      {required this.title,
      required this.description,
      required this.longDescription,
      required this.encodedContent,
      required this.tuuid,
      required this.sno,
      required this.pubdate,
      required this.lang,
      required this.articlePublishedTime,
      required this.image});

  factory NewsFeed.fromJson(Map<String, dynamic> json) =>
      _$NewsFeedFromJson(json);

  Map<String, dynamic> toJson() => _$NewsFeedToJson(this);
}
