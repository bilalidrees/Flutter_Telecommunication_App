import 'package:ufone_web/src/model/currently.dart';
import 'package:ufone_web/src/model/weekly.dart';

class Weather {
  double? latitude;
  double? longitude;
  String? city;
  String? datetime;
  Currently? currently;
  List<Weekly>? weekly;

  Weather(
      {this.latitude,
      this.longitude,
      this.city,
      this.datetime,
      this.currently,
      this.weekly});

  Weather.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    city = json['city'];
    datetime = json['datetime'];
    currently = json['currently'] != null
        ? new Currently.fromJson(json['currently'])
        : null;
    if (json['weekly'] != null) {
      weekly = [];
      json['weekly'].forEach((v) {
        weekly!.add(Weekly.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['city'] = this.city;
    data['datetime'] = this.datetime;
    if (this.currently != null) {
      data['currently'] = this.currently?.toJson();
    }
    if (this.weekly != null) {
      data['weekly'] = this.weekly!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  int getRound(dynamic temp) {
    var t = temp! * 100;
    return t.round();
  }
}
