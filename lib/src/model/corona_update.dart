import 'package:ufone_web/src/model/corona_update_global.dart';

class CoronaUpdate {
  String? updatedatimelocal;
  String? recovered;
  String? deaths;
  String? islamabad;
  String? punjab;
  String? sindh;
  String? kP;
  String? balochistan;
  String? aJK;
  String? gB;
  String? confirmedCases;
  String? totalTests;
  CoronaUpdateGlobal? worldwide;

  CoronaUpdate(
      {this.updatedatimelocal,
        this.recovered,
        this.deaths,
        this.islamabad,
        this.punjab,
        this.sindh,
        this.kP,
        this.balochistan,
        this.aJK,
        this.gB,
        this.confirmedCases,
        this.totalTests,
        this.worldwide});

  CoronaUpdate.fromJson(Map<String, dynamic> json) {
    updatedatimelocal = json['updatedatimelocal'];
    recovered = json['Recovered'];
    deaths = json['Deaths'];
    islamabad = json['Islamabad'];
    punjab = json['Punjab'];
    sindh = json['Sindh'];
    kP = json['KP'];
    balochistan = json['Balochistan'];
    aJK = json['AJK'];
    gB = json['GB'];
    confirmedCases = json['ConfirmedCases'];
    totalTests = json['Total Tests'];
    worldwide = (json['worldwide'] != null
        ?  CoronaUpdateGlobal.fromJson(json['worldwide'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updatedatimelocal'] = this.updatedatimelocal;
    data['Recovered'] = this.recovered;
    data['Deaths'] = this.deaths;
    data['Islamabad'] = this.islamabad;
    data['Punjab'] = this.punjab;
    data['Sindh'] = this.sindh;
    data['KP'] = this.kP;
    data['Balochistan'] = this.balochistan;
    data['AJK'] = this.aJK;
    data['GB'] = this.gB;
    data['ConfirmedCases'] = this.confirmedCases;
    data['Total Tests'] = this.totalTests;
    if (this.worldwide != null) {
      data['worldwide'] = this.worldwide!.toJson();
    }
    return data;
  }
}