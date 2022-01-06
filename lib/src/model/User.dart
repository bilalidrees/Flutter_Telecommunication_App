import 'package:json_annotation/json_annotation.dart';
import 'package:provider/provider.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'fullname')
  String fullname;
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'password')
  String password;
  @JsonKey(name: 'picture')
  String picture;
  @JsonKey(name: 'contact')
  String contact;
  @JsonKey(name: 'gender')
  String gender;
  @JsonKey(name: 'dob')
  String dob;


  User(
      {required this.fullname,
        required this.id,
        required this.email,
        required this.password,
        required this.picture,
        required this.contact,
        required this.gender,
        required this.dob});


  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
