import 'package:ufone_web/src/model/finance.dart';
import 'package:ufone_web/src/model/kse_rate.dart';

class KseRateFinance extends Finance {
  List<KseRate>? kseRate;

  KseRateFinance({this.kseRate});

  KseRateFinance.fromJson(Map<String, dynamic> json) {
    if (json['kse_rate'] != null) {
      kseRate = [];
      json['kse_rate'].forEach((v) {
        kseRate!.add(KseRate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.kseRate != null) {
      data['kse_rate'] = this.kseRate!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
