class PrayerInfo {
  String? imsak;
  String? fajr;
  String? sunrise;
  String? dhuhr;
  String? asr;
  String? sunset;
  String? maghrib;
  String? isha;
  String? midnight;
  String? lat;
  String? long;
  String? calcMethod;
  String? asrMethod;
  String? dateStr;
  String? hijriStr;

  PrayerInfo(
      {this.imsak,
        this.fajr,
        this.sunrise,
        this.dhuhr,
        this.asr,
        this.sunset,
        this.maghrib,
        this.isha,
        this.midnight,
        this.lat,
        this.long,
        this.calcMethod,
        this.asrMethod,
        this.dateStr,
        this.hijriStr});

  PrayerInfo.fromJson(Map<String, dynamic> json) {
    imsak = json['imsak'];
    fajr = json['fajr'];
    sunrise = json['sunrise'];
    dhuhr = json['dhuhr'];
    asr = json['asr'];
    sunset = json['sunset'];
    maghrib = json['maghrib'];
    isha = json['isha'];
    midnight = json['midnight'];
    lat = json['lat'];
    long = json['long'];
    calcMethod = json['calc_method'];
    asrMethod = json['asr_method'];
    dateStr = json['date_str'];
    hijriStr = json['hijri_str'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imsak'] = this.imsak;
    data['fajr'] = this.fajr;
    data['sunrise'] = this.sunrise;
    data['dhuhr'] = this.dhuhr;
    data['asr'] = this.asr;
    data['sunset'] = this.sunset;
    data['maghrib'] = this.maghrib;
    data['isha'] = this.isha;
    data['midnight'] = this.midnight;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['calc_method'] = this.calcMethod;
    data['asr_method'] = this.asrMethod;
    data['date_str'] = this.dateStr;
    data['hijri_str'] = this.hijriStr;
    return data;
  }
}
