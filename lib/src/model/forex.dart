class Forex {
  String? source;
  String? updatetime;
  Value? value;
  String? key;

  Forex({this.source, this.updatetime, this.value, this.key});

  Forex.fromJson(Map<String, dynamic> json) {
    source = json['Source'];
    updatetime = json['updatetime'];
    value = json['value'] != null ? new Value.fromJson(json['value']) : null;
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Source'] = this.source;
    data['updatetime'] = this.updatetime;
    if (this.value != null) {
      data['value'] = this.value!.toJson();
    }
    data['key'] = this.key;
    return data;
  }
}

class Value {
  String? selling;
  String? buying;

  Value({this.selling, this.buying});

  Value.fromJson(Map<String, dynamic> json) {
    selling = json['selling'];
    buying = json['buying'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['selling'] = this.selling;
    data['buying'] = this.buying;
    return data;
  }
}
