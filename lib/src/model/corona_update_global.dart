import 'package:ufone_web/src/model/country_stats.dart';
import 'package:ufone_web/src/model/summary.dart';

class CoronaUpdateGlobal {
  List<CountryStats>? data;
  Summary? summary;
  String? internationalUpdateDateTime;

  CoronaUpdateGlobal({this.data, this.summary, this.internationalUpdateDateTime});

  CoronaUpdateGlobal.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data =  <CountryStats>[];
      json['data'].forEach((v) {
        data!.add(CountryStats.fromJson(v));
      });
    }
    summary =
    json['summary'] != null ?  Summary.fromJson(json['summary']) : null;
    internationalUpdateDateTime = json['internationalUpdateDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.summary != null) {
      data['summary'] = summary!.toJson();
    }
    data['internationalUpdateDateTime'] = this.internationalUpdateDateTime;
    return data;
  }
}