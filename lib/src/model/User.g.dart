// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      fullname: json['fullname'] as String,
      id: json['_id'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      picture: json['picture'] as String,
      contact: json['contact'] as String,
      gender: json['gender'] as String,
      dob: json['dob'] as String);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'fullname': instance.fullname,
      '_id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'picture': instance.picture,
      'contact': instance.contact,
      'gender': instance.gender,
      'dob': instance.dob,
    };
