// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NewsFeed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsFeed _$NewsFeedFromJson(Map<String, dynamic> json) {
  return NewsFeed(
      title: json['title'] as String,
      description: json['description'] as String,
      longDescription: json['long_description'] as String,
      encodedContent: json['encoded_content'] as String,
      tuuid: json['tuuid'] as String,
      sno: json['sno'] as int,
      pubdate: json['pubdate'] as String,
      lang: json['lang'] as String,
      articlePublishedTime: json['articlePublishedTime'] as String,
      image: json['image'] as String)
    ..mediaLinks = json['media_links'] == null
        ? null
        : MediaLinks.fromJson(json['media_links'] as Map<String, dynamic>);
}

Map<String, dynamic> _$NewsFeedToJson(NewsFeed instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'encoded_content': instance.encodedContent,
      'long_description': instance.longDescription,
      'tuuid': instance.tuuid,
      'sno': instance.sno,
      'media_links': instance.mediaLinks,
      'pubdate': instance.pubdate,
      'lang': instance.lang,
      'articlePublishedTime': instance.articlePublishedTime,
      'image': instance.image
    };
