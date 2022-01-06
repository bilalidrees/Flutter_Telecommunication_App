import 'package:json_annotation/json_annotation.dart';

part 'Provider.g.dart';

@JsonSerializable()
class Provider {
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'id')
  String? id;

  Provider({ this.name,  this.id});

  factory Provider.fromJson(Map<String, dynamic> json) =>
      _$ProviderFromJson(json);

  Map<String, dynamic> toJson() => _$ProviderToJson(this);
}
