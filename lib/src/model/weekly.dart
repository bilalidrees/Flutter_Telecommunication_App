class Weekly {
  int? time;
  String? summary;
  String? icon;
  dynamic humidity;
  dynamic temperatureLow;
  dynamic temperatureHigh;

  Weekly(
      {this.time,
      this.summary,
      this.icon,
      this.humidity,
      this.temperatureLow,
      this.temperatureHigh});

  Weekly.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    summary = json['summary'];
    icon = json['icon'];
    humidity = json['humidity'];
    temperatureLow = json['temperatureLow'];
    temperatureHigh = json['temperatureHigh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['summary'] = this.summary;
    data['icon'] = this.icon;
    data['humidity'] = this.humidity;
    data['temperatureLow'] = this.temperatureLow;
    data['temperatureHigh'] = this.temperatureHigh;
    return data;
  }
}
