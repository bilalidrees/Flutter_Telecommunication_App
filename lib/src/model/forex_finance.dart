import 'package:ufone_web/src/model/finance.dart';
import 'package:ufone_web/src/model/forex.dart';

class ForexFinance extends Finance {
  List<Forex>? forex;

  ForexFinance({this.forex});

  ForexFinance.fromJson(Map<String, dynamic> json) {
    if (json['forex'] != null) {
      forex = [];
      json['forex'].forEach((v) {
        forex!.add(Forex.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.forex != null) {
      data['forex'] = this.forex!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
