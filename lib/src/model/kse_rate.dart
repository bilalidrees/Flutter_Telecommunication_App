class KseRate {
  String? highIndex;
  String? updatetime;
  String? currentIndex;
  String? source;
  String? timestamp;
  String? indexCode;
  String? netChange;
  String? lowIndex;

  KseRate(
      {required this.highIndex,
        required this.updatetime,
        required this.currentIndex,
        required this.source,
        required this.timestamp,
        required this.indexCode,
        required this.netChange,
        required this.lowIndex});

  KseRate.fromJson(Map<String, dynamic> json) {
    highIndex = json['HighIndex'];
    updatetime = json['updatetime'];
    currentIndex = json['CurrentIndex'];
    source = json['Source'];
    timestamp = json['Timestamp'];
    indexCode = json['IndexCode'];
    netChange = json['NetChange'];
    lowIndex = json['LowIndex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HighIndex'] = this.highIndex;
    data['updatetime'] = this.updatetime;
    data['CurrentIndex'] = this.currentIndex;
    data['Source'] = this.source;
    data['Timestamp'] = this.timestamp;
    data['IndexCode'] = this.indexCode;
    data['NetChange'] = this.netChange;
    data['LowIndex'] = this.lowIndex;
    return data;
  }
}